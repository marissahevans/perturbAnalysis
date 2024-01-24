function [lsTot, AS, fb] = pterbModel5(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,sigma_m,alpha_m,bias,sigma_aim,alpha_mf)
%Perturb project model #1, only uses motor priors and learning from prior
%feedback to determine circle size. Does not incorporate trial to trial
%proproiceiton. 

%initalizing variables
aimNoise = zeros(1,numTrial);
aimNoise(20:70) = sigma_aim;
rotBias = zeros(1,numTrial);
rotBias(20:70) = bias;
sigma_mf1 = zeros(1,numTrial);       %initial condition for percieved motor noise (VARIANCE)
sigma_mf1(1) = sigma_m;
delta1 = zeros(1,numTrial);     %inital condition for motor adaptation
feedback1 = zeros(1,numTrial);
endPtAngle = zeros(numTrial,numSims);
arcSelect = zeros(numTrial,numSims);
tar = 0;

for sims = 1:numSims
    for jj = 1:numTrial
        perturb = ptb(jj);
        tarHat = ((tar-delta1(jj))+aimNoise(jj)*randn) + rotBias(jj);
        endPtAngle(jj,sims) = sigma_m*randn+tarHat;

        phit = normcdf(arcSize,0,sigma_mf1(jj));

        gain = phit.*r; %probability of a hit vs points possible at each distance

        %Radius point for each distance with the highest gain
        arcSelect(jj,sims) = arcSize(find(gain == max(gain),1,'last'));

        feedback1(jj) = endPtAngle(jj,sims) + perturb;

        delta1(jj+1) = delta1(jj) + alpha_m*feedback1(jj);

        sigma_mf1(jj+1) = sqrt((1-alpha_mf)*sigma_mf1(jj)^2+alpha_mf*feedback1(jj)^2);

    end
    feedback(:,sims) = feedback1;

    %For independent testing:
    %err1 = mean(endPtAngle,2);
    %err1SEM = std(endPtAngle')/sqrt(length(endPtAngle));
    %fb1SEM = std(feedback')/sqrt(length(feedback));
    %AS1SEM = std(arcSelect')/sqrt(length(arcSelect));
    AS = mean(arcSelect,2);
    fb = mean(feedback,2);
    lsFeed = sum((fb - feedbackErrmean).^2);
    lsConf = sum((AS - confmean).^2);
    lsTot = lsFeed + lsConf;

end
end