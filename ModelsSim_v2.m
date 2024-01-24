%Script to simulate and test potential models for perturbation experiment.
%Started 6/15/23 Marissa Fassold

%Models to test:

%model 0 no propriocpetion used, delta update on motor plan only

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

%task specifics
tar = [0,0];        %target location
numTrial = 64;      %number of trials
perturb = [0,20];   %amount of perturbation
numSims = 50;

%All possible parameter values
Beta1 = .8%.1:.3:1; %all models
Sigma_m = 20%15:3:24; %all models
Alpha_m = .3%.1:.3:1; %all models
Sigma_p = 30%22:4:34; %models 1 - 4
Alpha_p = .3%.1:.3:1; %models 1 - 4
Sigma_d2 = 1; %models 3 and 4
Sigma_d1 = 1; %model 4
Beta2 = .3; %model 2


matSize = [numTrial,length(Sigma_m),length(Sigma_p),length(Alpha_m),length(Alpha_p),length(Beta1),length(Sigma_d2),length(Sigma_d1),length(Beta2)];

mSig = nan(matSize);
SEMSig = nan(matSize);
mCirc = nan(matSize);
SEMCirc = nan(matSize);
mErr = nan(matSize);
SEMErr = nan(matSize);
m1X = nan(matSize);
SEM1X = nan(matSize);
m1Y = nan(matSize);
SEM1Y = nan(matSize);
m2X = nan(matSize);
m2Y = nan(matSize);
SEM2X = nan(matSize);
SEM2Y = nan(matSize);
sigM = nan(matSize);
sigP = nan(matSize);

tic
for model = 4%:4
    %% Setting up variables and parameters for trial simulation


    %set parameters
    for sm = 1:length(Sigma_m)
        sigma_m = Sigma_m(sm);        %motor noise
        for sp = 1:length(Sigma_p)
            sigma_p = Sigma_p(sp);       %proprioceptive noise
            for sd1 = 1:length(Sigma_d1)
                sigma_d1 = Sigma_d1(sd1);       %motor adaptation error on delta1 (kalman)
                for sd2 = 1:length(Sigma_d2)
                    sigma_d2 = Sigma_d2(sd2);       %motor adaptation error on delta2 (kalman)
                    for ap = 1:length(Alpha_p)
                        alpha_p = Alpha_p(ap);       %0-1 learning rate for proproceptive adaptation
                        for am = 1:length(Alpha_m)
                            alpha_m = Alpha_m(am);
                            for b1 = 1:length(Beta1)
                                beta1 = Beta1(b1);          %beta weight on delta1
                                for b2 = 1:length(Beta2)
                                    beta2 = Beta2(b2);          %beta weight on delta2

                                    for sims = 1:numSims
                                        %initalizing variables
                                        sigma_mf(1,sims) = 1;       %initial condition for percieved motor noise (VARIANCE)
                                        sigma_M = 0;        %inital condition for kalman motor variance update
                                        sigma_P = 0;        %inital condition for kalman proprioceptive variance
                                        delta1 = [0 0];     %inital condition for motor adaptation
                                        delta2 = [0 0];     %inital contidion for proprioceptive adaptation
                                        tarErr = [0 0];     %inital taget error
                                        %% Model 0 %does not use proprioception
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

                                                phit = raylcdf(0:length(radiusWac)-1,sigma_mf(jj,sims));

                                                gain = phit.*r; %probability of a hit vs points possible at each distance

                                                %Radius point for each distance with the highest gain
                                                circSelect(jj,sims) = radiusWac(max(find(gain == max(gain))));

                                                feedback(jj,:) = endPt(jj,:) + perturb;
                                                errDist(jj,sims) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
                                                tarErr(jj+1,:) = feedback(jj,:) - tar;
                                                delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj+1,:);

                                                vec = jj+1:-1:1;
                                                expVec = exppdf(vec,3)*3.2971;
                                                sigma_mf(jj+1,sims) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
                                                %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));

                                            end
                                            d1X(:,sims) = delta1(:,1);
                                            d1Y(:,sims) = delta1(:,2);
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
                                                    circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj,sims)); %max expected gain circle size for test variables
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
                                                circSelect(jj,sims) = interp1(maxDist,circSizes,eucDistPos);

                                                feedback(jj,:) = endPt(jj,:) + perturb;
                                                errDist(jj,sims) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
                                                tarErr(jj,:) = feedback(jj,:) - tar;
                                                delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj,:);

                                                vec = jj:-1:1;
                                                expVec = exppdf(vec,3)*3.2971;
                                                sigma_mf(jj+1,sims) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
                                                %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));

                                            end
                                            d1X(:,sims) = delta1(:,1);
                                            d1Y(:,sims) = delta1(:,2);
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
                                                    circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj,sims)); %max expected gain circle size for test variables
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
                                                circSelect(jj,sims) = interp1(maxDist,circSizes,eucDistPos);

                                                feedback(jj,:) = endPt(jj,:) + perturb;
                                                errDist(jj,sims) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
                                                tarErr(jj,:) = feedback(jj,:)-tar;
                                                senErr(jj,:) = feedback(jj,:) - sensed(jj,:);
                                                delta1(jj+1,:) = beta1*delta1(jj,:) + alpha_m*tarErr(jj,:);
                                                delta2(jj+1,:) = beta2*delta2(jj,:) + alpha_p*senErr(jj,:);

                                                vec = jj:-1:1;
                                                expVec = exppdf(vec,3)*3.2971;
                                                sigma_mf(jj+1,sims) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
                                                %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));

                                            end
                                            d1X(:,sims) = delta1(:,1);
                                            d1Y(:,sims) = delta1(:,2);

                                            d2X(:,sims) = delta2(:,1);
                                            d2Y(:,sims) = delta2(:,2);
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
                                                    circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj,sims)); %max expected gain circle size for test variables
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
                                                circSelect(jj,sims) = interp1(maxDist,circSizes,eucDistPos);

                                                feedback(jj,:) = endPt(jj,:) + perturb;
                                                errDist(jj,sims) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
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
                                                sigma_mf(jj+1,sims) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
                                                %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));

                                            end
                                            d1X(:,sims) = delta1(:,1);
                                            d1Y(:,sims) = delta1(:,2);

                                            d2X(:,sims) = delta2(:,1);
                                            d2Y(:,sims) = delta2(:,2);
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
                                                    circSizes(ii) = interp2(X,Y,squeeze(fit1LookUpMat(ii,:,:)),sigma_p,sigma_mf(jj,sims)); %max expected gain circle size for test variables
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
                                                circSelect(jj,sims) = interp1(maxDist,circSizes,eucDistPos);

                                                feedback(jj,:) = endPt(jj,:) + perturb;
                                                errDist(jj,sims) = sqrt((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2);
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
                                                sigma_mf(jj+1,sims) = sqrt((std(tarErr(:,1),expVec)^2+std(tarErr(:,2),expVec)^2)/2);
                                                %sigma_mf(jj+1) = sqrt(alpha_mf*sigma_mf(jj)^2 + (1-alpha_mf)*((feedback(jj,1) - tar(1)).^2 + (feedback(jj,2)-tar(2)).^2));

                                            end
                                            d1X(:,sims) = delta1(:,1);
                                            d1Y(:,sims) = delta1(:,2);

                                            d2X(:,sims) = delta2(:,1);
                                            d2Y(:,sims) = delta2(:,2);
                                        end
                                    end

                                    %% Saving output variables

                                    %sigma_mf
                                    mSig(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(sigma_mf(2:end,:),2);
                                    SEMSig(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(sigma_mf(2:end,:),0,2)/sqrt(size(sigma_mf(2:end,:),2));
                                    %confidence circle
                                    mCirc(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(circSelect,2);
                                    SEMCirc(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(circSelect,0,2)/sqrt(size(circSelect,2));
                                    %error distance
                                    mErr(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(errDist,2);
                                    SEMErr(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(errDist,0,2)/sqrt(size(errDist,2));
                                    %feedback
                                    mFeed(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(feedback,2);
                                    SEMFeed(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(feedback,0,2)/sqrt(size(feedback,2));
                                    %delta 1
                                    m1X(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(d1X(2:end,:),2);
                                    SEM1X(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(d1X(2:end,:),0,2)/sqrt(size(d1X(2:end,:),2));
                                    m1Y(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(d1Y(2:end,:),2);
                                    SEM1Y(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(d1Y(2:end,:),0,2)/sqrt(size(d1Y(2:end,:),2));
                                    %delta 2
                                    if model == 2 || model == 3 || model == 4
                                        m2X(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(d2X(2:end,:),2);
                                        m2Y(:,sm,sp,am,ap,b1,sd2,sd1,b2) = mean(d2Y(2:end,:),2);
                                        SEM2X(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(d2X(2:end,:),0,2)/sqrt(size(d2X(2:end,:),2));
                                        SEM2Y(:,sm,sp,am,ap,b1,sd2,sd1,b2) = std(d2Y(2:end,:),0,2)/sqrt(size(d2Y(2:end,:),2));
                                    end
                                    %Kalman sigma on Proproception
                                    %adaptation
                                    if model == 3 || model == 4
                                        sigP(:,sm,sp,am,ap,b1,sd2,sd1,b2) = sigma_P(2:end);
                                    end
                                    %Kalman sigma on Motor adaptation
                                    if model == 4
                                        sigM(:,sm,sp,am,ap,b1,sd2,sd1,b2) = sigma_M(2:end);
                                    end


                                    %% Figure test check
                                    %                                         figure
                                    %                                         tcl = tiledlayout(3,2);
                                    %                                         title(tcl,['s_m=' num2str(sigma_m) ' s_p=' num2str(sigma_p) ' s_d1=' num2str(sigma_d1) ' s_d2=' num2str(sigma_d2) ' a_m=' num2str(alpha_m) ' a_p=' num2str(alpha_p) ' a_mf=' num2str(alpha_mf) ' b1=' num2str(beta1) ' b2=' num2str(beta2)])
                                    %

                                    %                                         subplot(3,2,1); hold on
                                    %                                         plot(mSig,'g','LineWidth',2)
                                    %                                         plot(mSig-SEMSig,'g--')
                                    %                                         plot(mSig+SEMSig,'g--')
                                    %                                         yline(sigma_m);
                                    %                                         xline(10,'--')
                                    %                                         title('sigma mf')
                                    %                                         xlabel('trials')
                                    %

                                    %                                         subplot(3,2,2); hold on
                                    %                                         plot(mCirc,'m','LineWidth',2)
                                    %                                         plot(mCirc-SEMCirc,'m--')
                                    %                                         plot(mCirc+SEMCirc,'m--')
                                    %                                         plot(mErr,'c','LineWidth',2)
                                    %                                         plot(mErr-SEMErr,'c--')
                                    %                                         plot(mErr+SEMErr,'c--')
                                    %                                         xline(10,'--')
                                    %                                         title('Circle size vs Error')
                                    %                                         xlabel('trials')
                                    %
                                    %                                         subplot(3,2,3)
                                    %                                         plot(sigma_M)
                                    %                                         xline(10,'--')
                                    %                                         title('sigma M')
                                    %                                         xlabel('trials')
                                    %
                                    %                                         subplot(3,2,4)
                                    %                                         plot(sigma_P)
                                    %                                         xline(10,'--')
                                    %                                         title('sigma P')
                                    %                                         xlabel('trials')
                                    %
                                    %                                         subplot(3,2,5); hold on
                                    %                                         plot(m1X,'b','LineWidth',2)
                                    %                                         plot(m1X-SEM1X,'b--')
                                    %                                         plot(m1X+SEM1X,'b--')
                                    %                                         plot(m1Y,'k','LineWidth',2)
                                    %                                         plot(m1Y-SEM1Y,'k--')
                                    %                                         plot(m1Y+SEM1Y,'k--')
                                    %                                         xline(10,'--')
                                    %                                         title('delta 1')
                                    %                                         xlabel('trials')
                                    %
                                    %                                         subplot(3,2,6); hold on
                                    %                                         plot(m2X,'b','LineWidth',2)
                                    %                                         plot(m2X-SEM2X,'b--')
                                    %                                         plot(m2X+SEM2X,'b--')
                                    %                                         plot(m2Y,'k','LineWidth',2)
                                    %                                         plot(m2Y-SEM2Y,'k--')
                                    %                                         plot(m2Y+SEM2Y,'k--')
                                    %                                         xline(10,'--')
                                    %                                         title('delta 2')
                                    %                                         xlabel('trials')
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if model == 0
        save('perturbSim0.mat','mSig','SEMSig','mCirc','SEMCirc','mErr','SEMErr','m1X','SEM1X','m1Y','SEM1Y','mFeed','SEMFeed')
    end
    if model == 1
        save('perturbSim1.mat','mSig','SEMSig','mCirc','SEMCirc','mErr','SEMErr','m1X','SEM1X','m1Y','SEM1Y','mFeed','SEMFeed')
    end
    if model == 2
        save('perturbSim2.mat','mSig','SEMSig','mCirc','SEMCirc','mErr','SEMErr','m1X','SEM1X','m1Y','SEM1Y','m2X','m2Y','SEM2X','SEM2Y','mFeed','SEMFeed')
    end
    if model == 3
        save('perturbSim3.mat','mSig','SEMSig','mCirc','SEMCirc','mErr','SEMErr','m1X','SEM1X','m1Y','SEM1Y','m2X','m2Y','SEM2X','SEM2Y','sigP','mFeed','SEMFeed')
    end
    if model == 4
        save('perturbSim4.mat','mSig','SEMSig','mCirc','SEMCirc','mErr','SEMErr','m1X','SEM1X','m1Y','SEM1Y','m2X','m2Y','SEM2X','SEM2Y','sigM','sigP','mFeed','SEMFeed')
    end
end
toc

