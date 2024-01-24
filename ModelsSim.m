%Script to simulate and test potential models for perturbation experiment.
%Started 6/15/23 Marissa Fassold

%Models to test:

%model 1 Standard delta update rule on motor plan, proprioceptive update
%uses a scalar value of the delta in the opposite direction of the
%adaptation.

%model 2 Two deltas are calculated, one based on target error for the motor
%plan, and another based on estimated endpoint error for the proprioceptive
%recalibration.

%model 3 Standard delta update on the motor plan, however update is not
%fully trusted and has associated noise. A Kalman filter is applied on the
%amount of shift as it updates noisily. Alpha equal to 1 for a true random
%walk or less than one for a process that has a driving force pushing bias
%back toward zero.

%model 4 Two Kalman filters for motor plan and proprioception
%updates.
load('model1LookUpTab.mat')

for model = 0:4
%% Setting up variables and parameters for trial simulation

%task specifics
tar = [0,0];        %target location
numTrial = 60;      %number of trials
perturb = [0,20];   %amount of perturbation

%set parameters
sigma_m = 10;        %motor noise
sigma_p = 15;       %proprioceptive noise
sigma_d1 = 3;       %motor adaptation error on delta1 (kalman)
sigma_d2 = 3;       %motor adaptation error on delta2 (kalman)
alpha_m = 1;       %0-1 learning rate for motor adaptation
alpha_p = 1;       %0-1 learning rate for proproceptive adaptation
alpha_mf = .5;
beta1 = .8;          %beta weight on delta1
beta2 = .5;          %beta weight on delta2

%initalizing variables
sigma_mf = 1;       %initial condition for percieved motor noise (VARIANCE)
sigma_M = 0;        %inital condition for kalman motor variance update
sigma_P = 0;        %inital condition for kalman proprioceptive variance
delta1 = [0 0];     %inital condition for motor adaptation
delta2 = [0 0];     %inital contidion for proprioceptive adaptation
tarErr = [0 0];     %inital taget error

%% Model 0
if model == 0

for jj = 1:numTrial
    if jj < 10
        perturb = [0 0];
    else
        perturb = [0 20];
    end
    tarHat(jj,:) = tar-delta1(jj,:);
    endPt(jj,:) = [sigma_m*randn+tarHat(jj,1),sigma_m*randn+tarHat(jj,2)];
    sensed = [0,0];
    sensedHat = [0,0];
    mu_pos = [0,0];
    
    radiusWac = linspace(0,69,150);
    r = [10*ones(1,5),linspace(10,0,length(6:150))];
    
    phit = raylcdf(0:length(radiusWac)-1,sigma_mf(jj));
    
    gain = phit.*r; %probability of a hit vs points possible at each distance
    
    %Radius point for each distance with the highest gain
    circSelect(jj) = radiusWac(max(find(gain == max(gain))));
    
    feedback(jj,:) = endPt(jj,:) + perturb;
    errDist(jj,:) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
    tarErr(jj+1,:) = feedback(jj,:) - tar;
    delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj+1,:); 
    
    vec = jj+1:-1:1;
    expVec = exppdf(vec,3)*3.2971;
    sigma_mf(jj+1) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
    %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));
    
end
end

%% Model 1
if model == 1
%load model1LookUpTab %look up table for model 1 (testing with metareach version for now)
[X, Y] = meshgrid(1:100,1:100);

for jj = 1:numTrial
    if jj < 10
        perturb = [0 0];
    else
        perturb = [0 20];
    end
    tarHat(jj,:) = tar-delta1(jj,:);
    endPt(jj,:) = [sigma_m*randn+tarHat(jj,1),sigma_m*randn+tarHat(jj,2)];
    sensed(jj,:) = [sigma_p*randn+endPt(jj,1),sigma_p*randn+endPt(jj,2)];
    sensedHat(jj,:) = sensed(jj,:) + alpha_p*delta1(jj,:);
    
    
    for ii = 1:length(fit1LookUpMat)
        circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj)); %max expected gain circle size for test variables
    end
    
    maxDist = 1:length(circSizes);
    
    %distances of sensed enpoints from the target
    Rm = 1/sigma_mf(jj)^2;
    Rp = 1/sigma_p^2;
    mu_pos(jj,:) = (Rm/(Rp+Rm)).*tar + (Rp/(Rp+Rm)).*sensedHat(jj,:);
    
    %Distance from posterior to target
    eucDistPos = sqrt((mu_pos(jj,1) - tar(1)).^2 + (mu_pos(jj,2)-tar(2)).^2);
    eucDistPos(eucDistPos < 1) = 1;
    
    %selected circle size from the look up table
    circSelect(jj) = interp1(maxDist,circSizes,eucDistPos);
    
    feedback(jj,:) = endPt(jj,:) + perturb;
    errDist(jj,:) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
    tarErr(jj,:) = feedback(jj,:) - tar;
    delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj,:); 
    
    vec = jj:-1:1;
    expVec = exppdf(vec,3)*3.2971;
    sigma_mf(jj+1) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
    %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));
    
end
end

%% Model 2
%This model adds 'delta2' which updates every trial 
if model == 2
%load model1LookUpTab %look up table for model 1 (testing with metareach version for now)
[X, Y] = meshgrid(1:100,1:100);

for jj = 1:numTrial
    if jj < 10
        perturb = [0 0];
    else
        perturb = [0 20];
    end
    tarHat(jj,:) = tar-delta1(jj,:);
    endPt(jj,:) = [sigma_m*randn+tarHat(jj,1),sigma_m*randn+tarHat(jj,2)];
    sensed(jj,:) = [sigma_p*randn+endPt(jj,1),sigma_p*randn+endPt(jj,2)];
    sensedHat(jj,:) = sensed(jj,:) + delta2(jj,:);
    
    
    for ii = 1:length(fit1LookUpMat)
        circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj)); %max expected gain circle size for test variables
    end
    
    maxDist = 1:length(circSizes);
    
    %distances of sensed enpoints from the target
    Rm = 1/sigma_mf(jj)^2;
    Rp = 1/sigma_p^2;
    mu_pos(jj,:) = (Rm/(Rp+Rm)).*tar + (Rp/(Rp+Rm)).*sensedHat(jj,:);
    
    %Distance from posterior to target
    eucDistPos = sqrt((mu_pos(jj,1) - tar(1)).^2 + (mu_pos(jj,2)-tar(2)).^2);
    eucDistPos(eucDistPos < 1) = 1;
    
    %selected circle size from the look up table
    circSelect(jj) = interp1(maxDist,circSizes,eucDistPos);
    
    feedback(jj,:) = endPt(jj,:) + perturb;
    errDist(jj,:) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
    tarErr(jj,:) = feedback(jj,:)-tar;
    senErr(jj,:) = feedback(jj,:) - sensed(jj,:);
    delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj,:); 
    delta2(jj+1,:) = beta2*delta2(jj,:) + alpha_p*senErr(jj,:);
    
    vec = jj:-1:1;
    expVec = exppdf(vec,3)*3.2971;
    sigma_mf(jj+1) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
    %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));
    
end
end
%% Model 3
if model == 3
%load model1LookUpTab %look up table for model 1 (testing with metareach version for now)
[X, Y] = meshgrid(1:100,1:100);

for jj = 1:numTrial
    if jj < 10
        perturb = [0 0];
    else
        perturb = [0 20];
    end
    tarHat(jj,:) = tar-delta1(jj,:);
    endPt(jj,:) = [sigma_m*randn+tarHat(jj,1),sigma_m*randn+tarHat(jj,2)];
    sensed(jj,:) = [sigma_p*randn+endPt(jj,1),sigma_p*randn+endPt(jj,2)];
    sensedHat(jj,:) = sensed(jj,:) + delta2(jj,:);
    
    
    for ii = 1:length(fit1LookUpMat)
        circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj)); %max expected gain circle size for test variables
    end
    
    maxDist = 1:length(circSizes);
    
    %distances of sensed enpoints from the target
    Rm = 1/sigma_mf(jj)^2;
    Rp = 1/sigma_p^2;
    mu_pos(jj,:) = (Rm/(Rp+Rm)).*tar + (Rp/(Rp+Rm)).*sensedHat(jj,:);
    
    %Distance from posterior to target
    eucDistPos = sqrt((mu_pos(jj,1) - tar(1)).^2 + (mu_pos(jj,2)-tar(2)).^2);
    eucDistPos(eucDistPos < 1) = 1;
    
    %selected circle size from the look up table
    circSelect(jj) = interp1(maxDist,circSizes,eucDistPos);
    
    feedback(jj,:) = endPt(jj,:) + perturb;
    errDist(jj,:) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
    tarErr(jj,:) = feedback(jj,:) - tar;
    senErr(jj,:) = feedback(jj,:) - sensed(jj,:);
    delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj,:);
    
    delta2exp = alpha_p*delta2(jj,:);
    expVar = alpha_p^2*sigma_P(jj)^2+sigma_d2^2;
    kalman = expVar/(expVar+sigma_p^2);
    delta2(jj+1,:) = delta2exp + kalman*(senErr(jj,:)-delta2exp);
    sigma_P(jj+1) = sqrt((1-kalman)*expVar);
    
    vec = jj:-1:1;
    expVec = exppdf(vec,3)*3.2971;
    sigma_mf(jj+1) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
    %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));
    
end
end
%% Model 4
if model == 4
%load model1LookUpTab %look up table for model 1 (testing with metareach version for now)
[X, Y] = meshgrid(1:100,1:100);

for jj = 1:numTrial
    if jj < 10
        perturb = [0 0];
    else
        perturb = [0 20];
    end
    tarHat(jj,:) = tar-delta1(jj,:);
    endPt(jj,:) = [sigma_m*randn+tarHat(jj,1),sigma_m*randn+tarHat(jj,2)];
    sensed(jj,:) = [sigma_p*randn+endPt(jj,1),sigma_p*randn+endPt(jj,2)];
    sensedHat(jj,:) = sensed(jj,:) + delta2(jj,:);
    
    
    for ii = 1:length(fit1LookUpMat)
        circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj)); %max expected gain circle size for test variables
    end
    
    maxDist = 1:length(circSizes);
    
    %distances of sensed enpoints from the target
    Rm = 1/sigma_mf(jj)^2;
    Rp = 1/sigma_p^2;
    mu_pos(jj,:) = (Rm/(Rp+Rm)).*tar + (Rp/(Rp+Rm)).*sensedHat(jj,:);
    
    %Distance from posterior to target
    eucDistPos = sqrt((mu_pos(jj,1) - tar(1)).^2 + (mu_pos(jj,2)-tar(2)).^2);
    eucDistPos(eucDistPos < 1) = 1;
    
    %selected circle size from the look up table
    circSelect(jj) = interp1(maxDist,circSizes,eucDistPos);
    
    feedback(jj,:) = endPt(jj,:) + perturb;
    errDist(jj,:) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
    tarErr(jj,:) = feedback(jj,:) - tar;
    senErr(jj,:) = feedback(jj,:) - sensed(jj,:);
    
    %kalman update on motor
    delta1exp = alpha_m*delta1(jj,:);
    expVar1 = alpha_m^2*sigma_M(jj)^2+sigma_d1^2;
    kalman1 = expVar1/(expVar1+sigma_m^2);
    delta1(jj+1,:) = delta1exp + kalman1*((delta1(jj,:)+tarErr(jj,:))-delta1exp);
    sigma_M(jj+1) = sqrt((1-kalman1)*expVar1);
    
    %kalman update on propriocption
    delta2exp = alpha_p*delta2(jj,:);
    expVar2 = alpha_p^2*sigma_P(jj)^2+sigma_d2^2;
    kalman2 = expVar2/(expVar2+sigma_p^2);
    delta2(jj+1,:) = delta2exp + kalman2*(senErr(jj,:)-delta2exp);
    sigma_P(jj+1) = sqrt((1-kalman2)*expVar2);
    
    vec = jj:-1:1;
    expVec = exppdf(vec,3)*3.2971;
    sigma_mf(jj+1) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
    %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));
    
end
end
%% Figure test check

figure
subplot(3,4,1)
scatter(tarHat(:,1),tarHat(:,2))
xline(0); yline(0)
title('tarHat')
xlim([-30 30])
ylim([-30 30])
xlabel('x')
ylabel('y')

subplot(3,4,2)
scatter(endPt(:,1),endPt(:,2))
xline(0); yline(0)
title('endPt')
xlim([-30 30])
ylim([-30 30])
xlabel('x')
ylabel('y')

subplot(3,4,3)
scatter(sensed(:,1),sensed(:,2))
xline(0); yline(0)
title('sensed')
xlim([-60 60])
ylim([-60 60])
xlabel('x')
ylabel('y')

subplot(3,4,4)
scatter(sensedHat(:,1),sensedHat(:,2))
xline(0); yline(0)
title('sensedHat')
xlim([-60 60])
ylim([-60 60])
xlabel('x')
ylabel('y')

subplot(3,4,5)
scatter(feedback(:,1),feedback(:,2))
xline(0); yline(0)
title('feedback')
xlim([-30 30])
ylim([-30 30])
xlabel('x')
ylabel('y')

subplot(3,4,6)
scatter(mu_pos(:,1),mu_pos(:,2))
xline(0); yline(0)
title('mu pos')
xlim([-30 30])
ylim([-30 30])
xlabel('x')
ylabel('y')

subplot(3,4,7)
plot(sigma_mf)
yline(sigma_m);
xline(10,'--')
title('sigma mf')
xlabel('trials')

subplot(3,4,8); hold on
plot(circSelect)
plot(errDist)
xline(10,'--')
title('Circle size vs Error')
xlabel('trials')

subplot(3,4,9)
plot(sigma_M)
xline(10,'--')
title('sigma M')
xlabel('trials')

subplot(3,4,10)
plot(sigma_P)
xline(10,'--')
title('sigma P')
xlabel('trials')

subplot(3,4,11)
plot(delta1)
xline(10,'--')
title('delta 1')
xlabel('trials')

subplot(3,4,12)
plot(delta2)
xline(10,'--')
title('delta 2')
xlabel('trials')
end