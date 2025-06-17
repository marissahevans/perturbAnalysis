function [AS, fb, ASsem, fbSem] = pterbModel4sim(numTrial,numSims,r,ptb,arcSize,sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim,alpha_mf)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%initalizing variables
aimNoise = zeros(1,numTrial);
aimNoise(21:71) = sigma_aim;
sigma_mf1 = zeros(1,numTrial);       %initial condition for percieved motor noise (VARIANCE)
sigma_mf1(1) = sigma_m;
sigma_M = ones(1,numTrial);        %inital condition for kalman motor variance update
sigma_P = ones(1,numTrial);        %inital condition for kalman proprioceptive variance
delta1 = zeros(1,numTrial);     %inital condition for motor adaptation
delta2 = zeros(1,numTrial);     %inital contidion for proprioceptive adaptation
feedback1 = zeros(1,numTrial);
endPtAngle = zeros(numTrial,numSims);
arcSelect = zeros(numTrial,numSims);
sigma_d1 = 1;
sigma_d2 = 1;
tar = 0;

for sims = 1:numSims
    for jj = 1:numTrial
        perturb = ptb(jj);
        tarHat = tar-delta1(jj);
        endPtAngle(jj,sims) = (sigma_m+aimNoise(jj))*randn+tarHat;

        sensed = sigma_p*randn+endPtAngle(jj,sims);
        sensedHat = sensed  + delta2(jj);

        %distances of sensed enpoints from the target
        Rm = 1/sigma_mf1(jj)^2;
        Rp = 1/sigma_p^2;
        var_pos = 1/(Rp+Rm);
        mu_pos = (Rm/(Rp+Rm)).*tar + (Rp/(Rp+Rm)).*sensedHat;

        phit = normcdf(arcSize,abs(mu_pos),var_pos);
        gain = phit.*r;

        %selected circle size from the look up table
        arcSelect(jj,sims) = arcSize(find(gain == max(gain),1,'last'));

        feedback1(jj) = endPtAngle(jj,sims) + perturb;
        senErr = feedback1(jj) - sensed;

        %kalman update on motor
        delta1exp = alpha_m*delta1(jj);
        expVar1 = alpha_m^2*sigma_M(jj)^2+sigma_d1^2;
        kalman1 = expVar1/(expVar1+sigma_m^2);
        delta1(jj+1) = delta1exp + kalman1*((delta1(jj)+feedback1(jj))-delta1exp);
        sigma_M(jj+1) = sqrt((1-kalman1)*expVar1);

        %kalman update on propriocption
        delta2exp = alpha_p*delta2(jj);
        expVar2 = alpha_p^2*sigma_P(jj)^2+sigma_d2^2;
        kalman2 = expVar2/(expVar2+sigma_p^2);
        delta2(jj+1) = delta2exp + kalman2*(senErr-delta2exp);
        sigma_P(jj+1) = sqrt((1-kalman2)*expVar2);

        sigma_mf1(jj+1) = sqrt((1-alpha_mf)*sigma_mf1(jj)^2+alpha_mf*feedback1(jj)^2);

    end

    feedback(:,sims) = feedback1;

    AS = mean(arcSelect,2);
    ASsem = std(arcSelect')/sqrt(length(arcSelect));
    fb = mean(feedback,2);
    fbSem = std(feedback')/sqrt(length(feedback));

end
end