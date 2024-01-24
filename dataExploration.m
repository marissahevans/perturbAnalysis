
subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'}]; %,{'IJ'},{'AMN'},{'SB'}];
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);

    if subj == 'AN'
        R1 = ' ';
        D1 = ' ';
        R2 = load(sprintf('%s',path,'/AN_perturb_exp_S2_2023-11-22_13-22_results.mat'));
        D2 = load(sprintf('%s',path,'/AN_perturb_exp_S2_2023-11-22_13-22_dispInfo.mat'));
        R3 = ' ';
        D3 = ' ';
        R4 = ' ';
        D4 = ' ';

    elseif subj == 'BY'
        R1 = load(sprintf('%s',path,'/BY_perturb_exp_S1_2023-11-15_12-29_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/BY_perturb_exp_S1_2023-11-15_12-29_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/BY_perturb_exp_S2_2023-11-16_14-11_results.mat'));
        D2 = load(sprintf('%s',path,'/BY_perturb_exp_S2_2023-11-16_14-11_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/BY_perturb_exp_S3_2023-11-17_13-01_results.mat'));
        D3 = load(sprintf('%s',path,'/BY_perturb_exp_S3_2023-11-17_13-01_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/BY_perturb_exp_S4_2023-11-20_16-58_results.mat'));
        D4 = load(sprintf('%s',path,'/BY_perturb_exp_S4_2023-11-20_16-58_dispInfo.mat'));

    elseif subj == 'ET'
        R1 = load(sprintf('%s',path,'/ET_perturb_exp_S1_2023-11-02_11-00_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/ET_perturb_exp_S1_2023-11-02_11-00_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/ET_perturb_exp_S2_2023-11-28_13-54_results.mat'));
        D2 = load(sprintf('%s',path,'/ET_perturb_exp_S2_2023-11-28_13-54_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/ET_perturb_exp_S3_2023-11-29_10-13_results.mat'));
        D3 = load(sprintf('%s',path,'/ET_perturb_exp_S3_2023-11-29_10-13_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/ET_perturb_exp_S4_2023-11-30_11-07_results.mat'));
        D4 = load(sprintf('%s',path,'/ET_perturb_exp_S4_2023-11-30_11-07_dispInfo.mat'));

    elseif subj == 'FM'
        R1 = load(sprintf('%s',path,'/FM_perturb_exp_S1_2023-11-02_16-54_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/FM_perturb_exp_S1_2023-11-02_16-54_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/FM_perturb_exp_S2_2023-11-14_17-10_results.mat'));
        D2 = load(sprintf('%s',path,'/FM_perturb_exp_S2_2023-11-14_17-10_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/FM_perturb_exp_S3_2023-11-16_17-23_results.mat'));
        D3 = load(sprintf('%s',path,'/FM_perturb_exp_S3_2023-11-16_17-23_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/FM_perturb_exp_S4_2023-11-21_16-54_results.mat'));
        D4 = load(sprintf('%s',path,'/FM_perturb_exp_S4_2023-11-21_16-54_dispInfo.mat'));

    elseif subj == 'HP'
        R1 = load(sprintf('%s',path,'/HP_perturb_exp_S1_2023-11-06_16-03_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/HP_perturb_exp_S1_2023-11-06_16-03_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/HP_perturb_exp_S2_2023-11-14_16-08_results.mat'));
        D2 = load(sprintf('%s',path,'/HP_perturb_exp_S2_2023-11-14_16-08_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/HP_perturb_exp_S3_2023-11-15_10-03_results.mat'));
        D3 = load(sprintf('%s',path,'/HP_perturb_exp_S3_2023-11-15_10-03_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/HP_perturb_exp_S4_2023-11-16_10-02_results.mat'));
        D4 = load(sprintf('%s',path,'/HP_perturb_exp_S4_2023-11-16_10-02_dispInfo.mat'));

    elseif subj == 'IJ'
        R1 = ' ';
        D1 = ' ';
        R2 = load(sprintf('%s',path,'/IJ_perturb_exp_S2_2023-11-13_18-16_results.mat'));
        D2 = load(sprintf('%s',path,'/IJ_perturb_exp_S2_2023-11-13_18-16_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/IJ_perturb_exp_S3_2023-11-20_18-07_results.mat'));
        D3 = load(sprintf('%s',path,'/IJ_perturb_exp_S3_2023-11-20_18-07_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/IJ_perturb_exp_S4_2023-11-27_18-04_results.mat'));
        D4 = load(sprintf('%s',path,'/IJ_perturb_exp_S4_2023-11-27_18-04_dispInfo.mat'));

    elseif subj == 'MP'
        R1 = load(sprintf('%s',path,'/MP_perturb_exp_S1_2023-10-31_14-47_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/MP_perturb_exp_S1_2023-10-31_14-47_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/MP_perturb_exp_S2_2023-11-21_10-00_results.mat'));
        D2 = load(sprintf('%s',path,'/MP_perturb_exp_S2_2023-11-21_10-00_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/MP_perturb_exp_S3_2023-11-27_13-52_results.mat'));
        D3 = load(sprintf('%s',path,'/MP_perturb_exp_S3_2023-11-27_13-52_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/MP_perturb_exp_S4_2023-11-28_10-05_results.mat'));
        D4 = load(sprintf('%s',path,'/MP_perturb_exp_S4_2023-11-28_10-05_dispInfo.mat'));

    elseif subj == 'NA'
        R1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-06_controlresults.mat'));
        R1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-40_controlresults.mat')); %NEEDS TO BE JOINED WITH ABOVE
        D1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-40_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/NA_perturb_exp_S2_2023-11-13_16-57_results.mat'));
        D2 = load(sprintf('%s',path,'/NA_perturb_exp_S2_2023-11-13_16-57_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/NA_perturb_exp_S3_2023-11-15_17-16_results.mat'));
        D3 = load(sprintf('%s',path,'/NA_perturb_exp_S3_2023-11-15_17-16_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/NA_perturb_exp_S4_2023-11-21_15-50_results.mat'));
        D4 = load(sprintf('%s',path,'/NA_perturb_exp_S4_2023-11-21_15-50_dispInfo.mat'));

    elseif subj == 'PL'
        R1 = load(sprintf('%s',path,'/PL_perturb_exp_S1_2023-11-29_10-55_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/PL_perturb_exp_S1_2023-11-29_10-55_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/PL_perturb_exp_S2_2023-11-14_15-05_results.mat'));
        D2 = load(sprintf('%s',path,'/PL_perturb_exp_S2_2023-11-14_15-05_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/PL_perturb_exp_S3_2023-11-15_11-08_results.mat'));
        D3 = load(sprintf('%s',path,'/PL_perturb_exp_S3_2023-11-15_11-08_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/PL_perturb_exp_S4_2023-11-16_11-17_results.mat'));
        D4 = load(sprintf('%s',path,'/PL_perturb_exp_S4_2023-11-16_11-17_dispInfo.mat'));

    elseif subj == 'SB'
        R1 = ' ';
        D1 = ' ';
        R2 = load(sprintf('%s',path,'/SB_perturb_exp_S2_2023-11-27_17-02_results.mat'));
        D2 = load(sprintf('%s',path,'/SB_perturb_exp_S2_2023-11-27_17-02_dispInfo.mat'));
        R3 = ' ';
        D3 = ' ';
        R4 = ' ';
        D4 = ' ';

    elseif subj == 'SM'
        R1 = load(sprintf('%s',path,'/SM_perturb_exp_S1_2023-11-17_16-07_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/SM_perturb_exp_S1_2023-11-17_16-07_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/SM_perturb_exp_S2_2023-11-20_09-59_results.mat'));
        D2 = load(sprintf('%s',path,'/SM_perturb_exp_S2_2023-11-20_09-59_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/SM_perturb_exp_S3_2023-11-21_15-00_results.mat'));
        D3 = load(sprintf('%s',path,'/SM_perturb_exp_S3_2023-11-21_15-00_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/SM_perturb_exp_S4_2023-11-27_11-58_results.mat'));
        D4 = load(sprintf('%s',path,'/SM_perturb_exp_S4_2023-11-27_11-58_dispInfo.mat'));

    elseif subj == ' '
        R1 = ' ';
        D1 = ' ';
        R2 = ' ';
        D2 = ' ';
        R3 = ' ';
        D3 = ' ';
        R4 = ' ';
        D4 = ' ';

    elseif subj == ' '
        R1 = ' ';
        D1 = ' ';
        R2 = ' ';
        D2 = ' ';
        R3 = ' ';
        D3 = ' ';
        R4 = ' ';
        D4 = ' ';

    elseif subj == ' '
        R1 = ' ';
        D1 = ' ';
        R2 = ' ';
        D2 = ' ';
        R3 = ' ';
        D3 = ' ';
        R4 = ' ';
        D4 = ' ';
    end

    %control exp
    epAngle1 = R1.contResultsMat.endPtAngle - 90;
    rpAngle1 = R1.contResultsMat.reportAngle - 90;
    fbAngle = [R2.resultsMat.feedbackAngle; R3.resultsMat.feedbackAngle; R4.resultsMat.feedbackAngle];
    tAngle = [R2.resultsMat.tarAngle'; R3.resultsMat.tarAngle'; R4.resultsMat.tarAngle'];
    eAngle = [R2.resultsMat.endPtAngle; R3.resultsMat.endPtAngle; R4.resultsMat.endPtAngle];
    arcSz = [R2.resultsMat.arcSize'; R3.resultsMat.arcSize'; R4.resultsMat.arcSize'];
    respErr = [R2.resultsMat.respErrorAngle; R3.resultsMat.respErrorAngle; R4.resultsMat.respErrorAngle];
    ptsEarn = [R2.resultsMat.pointsEarned; R3.resultsMat.pointsEarned; R4.resultsMat.pointsEarned];

    score(ss) = R2.resultsMat.runningScore(4) + R3.resultsMat.runningScore(4) + R4.resultsMat.runningScore(4);

    z = length(respErr)/100;

    feedbackAngle = reshape(fbAngle,[100,z]); %endpoint location out of 360 degrees
    tarAngle = reshape(tAngle,[100,z]); %target location out of 360 degrees
    errAngle = reshape(eAngle,[100,z]); %feedback location out of 360 degrees
    conf = reshape(abs(arcSz),[100 z]);
    errorfb = reshape(respErr,[100 z]);
    ptsEarn = reshape(ptsEarn,[100 z]);

    feedbackErr = (tarAngle-feedbackAngle).*[-1 1 -1 1 -1 1 -1 1 -1 1 -1 1];
    feedbackErr(feedbackErr>100) = 360-feedbackErr(feedbackErr>100);
    feedbackErr(feedbackErr<-100) = 360+feedbackErr(feedbackErr<-100);
    handAngle =(tarAngle-errAngle).*[-1 1 -1 1 -1 1 -1 1 -1 1 -1 1];
    handAngle(handAngle>100) = 360-handAngle(handAngle>100);
    handAngle(handAngle<-100) = 360+handAngle(handAngle<-100);

    confmean = mean(conf,2); %angle away from target in one direction
    confsem = std(conf')/sqrt(length(conf));
    handAnglemean = mean(handAngle,2); %hand angle away from target
    handAnglesem = std(handAngle')/sqrt(length(handAngle));
    feedbackErrmean = mean(feedbackErr,2); %feedback error away from target
    feedbackErrsem = std(feedbackErr')/sqrt(length(feedbackErr));

% figure; hold on
% scatter(R2.resultsMat.pointsEarned,R2.resultsMat.pointsPossible)
% 
% figure; hold on
% scatter(tarAngle(20:70,:),ptsEarn(20:70,:),'r')
% scatter(tarAngle(71:100,:),ptsEarn(71:100,:),'g')
% scatter(tarAngle(1:19,:),ptsEarn(1:19,:),'b')
% 
% figure; hold on
% scatter(tarAngle(20:70,:),conf(20:70,:),'r')
% scatter(tarAngle(71:100,:),conf(71:100,:),'g')
% scatter(tarAngle(1:19,:),conf(1:19,:),'b')

% figure
% scatter(winning,score)
% 
% figure
% scatter(winning,sigMmarg)

%confidence
confPtb = conf(20:70,:);
confBase(ss) = mean(confmean(1:19));
allconfPtb(ss,:) = confPtb(:);
x = 1:612;
%c = polyfit(x,confPtb(:),2);
%y_est = polyval(c,x);
yPrime = log(confPtb(:));
pPrime = polyfit(x,yPrime,1);
aPrime = pPrime(2); bPrime = pPrime(1);
y_est = exp(aPrime)*exp(x*bPrime);


figure(1)
subplot(2,4,ss); hold on
scatter(x,confPtb(:))
plot(x,y_est,'LineWidth',2)
yline(confBase(ss),'LineWidth',2);
ylim([-10 30])
text(10,0,['y = ' num2str(c(1)) '*x + ' num2str(c(2))])
xline(0:51:612,'--','HandleVisibility','off')
xlabel('number of trials with perturbation')
ylabel('confidence')
legend('confidence','curve fit','location','best')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title(['subj ' num2str(ss)])

%feedback
%fbPtb = abs(feedbackErr(20:70,:));
fbPtb = feedbackErr(20:70,:);
fbBase(ss) = mean(abs(feedbackErrmean(1:19)));
allfbPtb(ss,:) = fbPtb(:);
x = 1:612;
c = polyfit(x,fbPtb(:),2);
y_est = polyval(c,x);
% yPrime = log(fbPtb(:));
% pPrime = polyfit(x,yPrime,1);
% aPrime = pPrime(2); bPrime = pPrime(1);
% y_est = exp(aPrime)*exp(x*bPrime);


figure(2)
subplot(2,4,ss); hold on
scatter(x,fbPtb(:))
plot(x,y_est,'LineWidth',2)
ylim([-30 70])
text(10,0,['y = ' num2str(c(1)) '*x + ' num2str(c(2))])
xline(0:51:612,'--','HandleVisibility','off')
xlabel('number of trials with perturbation')
ylabel('error')
legend('error','curve fit','location','best')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title(['subj ' num2str(ss)])

end

% figure; hold on
% plot(fbPtb(:))
% plot(confPtb(:))
% plot(confPtb(:)./fbPtb(:))
% plot(fbPtb(:)./fbPtb(:))
% xline(0:51:612,'--')

%avg confidence
propconfall = allconfPtb./confBase';
stndconfall = mean(propconfall)-1;
% c1 = polyfit(x,stndconfall,2);
% y_est1 = polyval(c1,x);
yPrime = log(stndconfall);
pPrime = polyfit(x,yPrime,1);
aPrime = pPrime(2); bPrime = pPrime(1);
y_est = exp(aPrime)*exp(x1*bPrime);

%avg error
propfball = allfbPtb./fbBase';
stndfball = mean(propfball)-1;
c2 = polyfit(x,stndfball,2);
y_est2 = polyval(c2,x);
% yPrime = log(stndfball);
% pPrime = polyfit(x,yPrime,1);
% aPrime = pPrime(2); bPrime = pPrime(1);
% y_est = exp(aPrime)*exp(x1*bPrime);

figure
subplot(1,2,1); hold on
scatter(x,stndconfall-y_est1);
plot(x,y_est1,'LineWidth',2)
yline(0);
yline(mean(y_est1));
text(300,.8,['y = ' num2str(c1(2)) '*x + ' num2str(c1(3))],'FontSize',12)
xlabel('number of trials with perturbation')
ylabel('proportion confidence change')
legend('confidence','curve fit')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title('Average Participant Confidence')
xline(0:51:612,'--','HandleVisibility','off')

subplot(1,2,2); hold on
scatter(x,stndfball-y_est2);
plot(x,y_est2,'LineWidth',2)
yline(0);
text(300,6,['y = ' num2str(c2(2)) '*x + ' num2str(c2(3))],'FontSize',12)
xlabel('number of trials with perturbation')
ylabel('proportion error change')
legend('Error','curve fit')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title('Average Participant abs. Error')
xline(0:51:612,'--','HandleVisibility','off')


