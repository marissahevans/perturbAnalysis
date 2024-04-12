subjAll = [{'FM'},{'ET'},{'GK'},{'HP'},{'MP'},{'NA'},{'PL'},{'AN'},{'VD'},{'RW'},{'BY'},{'SM'},{'IJ'},{'SB'},{'PK'},{'SX'}];
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput.mat',subj);
    load([path '/' filename])

    cvAll = [sum(cvLS1,2) sum(cvLS2,2) sum(cvLS3,2) sum(cvLS4,2)];
    cvmin = min(cvAll');
    cvDiff =  cvAll' - cvmin;
    for ii = 1:20
        winnerAll(ii,ss) = find(cvDiff(:,ii)==0);
    end
end

for ii = 1:16
    winnerCounts(ii,:) = [sum(winnerAll(:,ii) == 1),sum(winnerAll(:,ii) == 2),sum(winnerAll(:,ii) == 3),sum(winnerAll(:,ii) == 4)];
end
for ii = 1:16
    winningMod(ii) = find(winnerCounts(ii,:) == max(winnerCounts(ii,:)));
end


figure
heatmap(winnerCounts)

figure
for ii = 1:16
    subplot(4,4,ii)
    histogram(winnerAll(:,ii))
    xlim([0,5])
end

%% Box plots comparing best fit parameters for each model (from simualtions)

m1sigM = squeeze(x2(:,1,:));
m2sigM = squeeze(x3(:,1,:));
m3sigM = squeeze(x3(:,1,:));
m4sigM = squeeze(x4(:,1,:));

m2sigP = squeeze(x3(:,2,:));
m3sigP = squeeze(x3(:,2,:));
m4sigP = squeeze(x4(:,2,:));

m1alphaM = squeeze(x2(:,2,:));
m2alphaM = squeeze(x3(:,3,:));
m3alphaM = squeeze(x3(:,3,:));
m4alphaM = squeeze(x4(:,3,:));

m2alphaP = squeeze(x3(:,4,:));
m3alphaP = squeeze(x3(:,4,:));
m4alphaP = squeeze(x4(:,4,:));

m1sigA = squeeze(x2(:,3,:));
m2sigA = squeeze(x3(:,5,:));
m3sigA = squeeze(x3(:,5,:));
m4sigA = squeeze(x4(:,5,:));

m1alphaF = squeeze(x2(:,4,:));
m3alphaF = squeeze(x3(:,6,:));
m4alphaF = squeeze(x4(:,6,:));

figure
subplot(2,3,1)
boxchart([m1sigM(:),m2sigM(:),m3sigM(:),m4sigM(:)])
title('Motor Error')
xlabel('Model')
ylabel('Degrees')
subplot(2,3,2)
boxchart([NaN(size(m2sigP(:))),m2sigP(:),m3sigP(:),m4sigP(:)])
title('Proprioceptive Error')
xlabel('Model')
ylabel('Degrees')
subplot(2,3,3)
boxchart([m1alphaM(:),m2alphaM(:),m3alphaM(:),m4alphaM(:)])
title('Motor Alpha')
xlabel('Model')
subplot(2,3,4)
boxchart([NaN(size(m2alphaP(:))),m2alphaP(:),m3alphaP(:),m4alphaP(:)])
title('Proprioceptive Alpha')
xlabel('Model')
subplot(2,3,5)
boxchart([m1sigA(:),m2sigA(:),m3sigA(:),m4sigA(:)])
title('Aiming Error')
xlabel('Model')
ylabel('Degrees')
subplot(2,3,6)
boxchart([m1alphaF(:),NaN(size(m1alphaF(:))),m3alphaF(:),m4alphaF(:)])
title('Feedback Learning')
xlabel('Model')

%% Time course plots compared to model simualtions

numTrial = 100;      %number of trials
numBlocks = 12;
numSims = 1000;
ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];
figs = 0; %show figures in loop

for ss = 13%:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput.mat',subj);
    load([path '/' filename])
    filename2 = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename2])

    subset = winnerAll(:,ss) == winningMod(ss);

    if winningMod(ss) == 1
        params = x2(:,:,subset);
        bestVals = mean(mean(params,3));
        [lsTot1, AS1, fb1, ASsem1, fbSem1] = pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4));
        
        figure; hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(AS1,'k','LineWidth',2)
        plot(AS1-ASsem1','k--','HandleVisibility','off')
        plot(AS1+ASsem1','k--','HandleVisibility','off')
        plot(-AS1,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS1-ASsem1','k--','HandleVisibility','off')
        plot(-AS1+ASsem1','k--','HandleVisibility','off')
        plot(fb1,'b','LineWidth',2)
        plot(fb1-fbSem1','b--','HandleVisibility','off')
        plot(fb1+fbSem1','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle +/- SEM','Confidence Angle +/- SEM','Model Confidence +/- SEM','Model Feedback +/- SEM','location','best')
        ylabel('angle (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Model 1')
        ylim([-30 30])

    elseif winningMod(ss) == 2
        params = x3(:,:,subset);
        bestVals = mean(mean(params,3));
        [lsTot2, AS2, fb2, ASsem2, fbSem2] = pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5));
        
        figure; hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(AS2,'k','LineWidth',2)
        plot(AS2-ASsem2','k--','HandleVisibility','off')
        plot(AS2+ASsem2','k--','HandleVisibility','off')
        plot(-AS2,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS2-ASsem2','k--','HandleVisibility','off')
        plot(-AS2+ASsem2','k--','HandleVisibility','off')
        plot(fb2,'b','LineWidth',2)
        plot(fb2-fbSem2','b--','HandleVisibility','off')
        plot(fb2+fbSem2','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
        ylabel('angle (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Model 2')
        ylim([-30 30])

    elseif winningMod(ss) == 3
        params = x3(:,:,subset);
        %bestVals = mean(mean(params,3));
        bestVals = params(5,:,3);
        [lsTot3, AS3, fb3, ASsem3, fbSem3] = pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5),bestVals(6));
        
        figure; hold on
        %plot(feedbackErrmean,'m','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','m--')
        plot(feedbackErrmean+feedbackErrsem','m--','HandleVisibility','off')
        %plot(confmean,'g','LineWidth',2)
        %plot(-confmean,'g','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','g--')
        plot(confmean+confsem','g--','HandleVisibility','off')
        plot(-confmean-confsem','g--','HandleVisibility','off')
        plot(-confmean+confsem','g--','HandleVisibility','off')
        plot(AS3,'k','LineWidth',2)
        %plot(AS3-ASsem3','k--','HandleVisibility','off')
        %plot(AS3+ASsem3','k--','HandleVisibility','off')
        plot(-AS3,'k','LineWidth',2,'HandleVisibility','off')
        %plot(-AS3-ASsem3','k--','HandleVisibility','off')
        %plot(-AS3+ASsem3','k--','HandleVisibility','off')
        plot(fb3,'b','LineWidth',2)
        %plot(fb3-fbSem3','b--','HandleVisibility','off')
        %plot(fb3+fbSem3','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle','Confidence Angle','Model Confidence','Model Feedback','location','best')
        ylabel('Angle (degrees)')
        xlabel('Trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Model 3')
        ylim([-20 20])

    else
        params = x4(:,:,subset);
        bestVals = mean(mean(params,3));
        [lsTot4, AS4, fb4, ASsem4, fbSem4] = pterbModel4(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5),bestVals(6));
        
        figure; hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(AS4,'k','LineWidth',2)
        plot(AS4-ASsem4','k--','HandleVisibility','off')
        plot(AS4+ASsem4','k--','HandleVisibility','off')
        plot(-AS4,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS4-ASsem4','k--','HandleVisibility','off')
        plot(-AS4+ASsem4','k--','HandleVisibility','off')
        plot(fb4,'b','LineWidth',2)
        plot(fb4-fbSem4','b--','HandleVisibility','off')
        plot(fb4+fbSem4','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
        ylabel('angle (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Model 4')
        ylim([-30 30])
    end
end

%% Poly fit of trials with perturbation on or off

for ss = 13%:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput.mat',subj);
    load([path '/' filename])
    filename2 = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename2])

    range1 = 1:19;
    range2 = 20:69;
    range3 = 70:100;
    order = 2;
    %Feedback Fit
    fbPtb1 = feedbackErrmean(range1);
    fbPtb2 = feedbackErrmean(range2);
    fbPtb3 = feedbackErrmean(range3);
    x1 = 1:length(fbPtb1);
    x2 = 1:length(fbPtb2);
    x3 = 1:length(fbPtb3);
    c1 = polyfit(x1,fbPtb1,1);
    c2 = polyfit(x2,fbPtb2,order);
    c3 = polyfit(x3,fbPtb3,order);
    y_est1 = polyval(c1,x1);
    y_est2 = polyval(c2,x2);
    y_est3 = polyval(c3,x3);

    %Confidence fit
    confPtb1 = confmean(range1);
    confPtb2 = confmean(range2);
    confPtb3 = confmean(range3);
    c4 = polyfit(x1,confPtb1,1);
    c5 = polyfit(x2,confPtb2,order);
    c6 = polyfit(x3,confPtb3,order);
    y_est4 = polyval(c4,x1);
    y_est5 = polyval(c5,x2);
    y_est6 = polyval(c6,x3);

    figure
    subplot(1,3,1); hold on
    plot(x1,feedbackErrmean(range1)-feedbackErrsem(range1)','m--','HandleVisibility','off')
    plot(x1,feedbackErrmean(range1)+feedbackErrsem(range1)','m--','HandleVisibility','off')
    plot(x1,confmean(range1)-confsem(range1)','g--','HandleVisibility','off')
    plot(x1,confmean(range1)+confsem(range1)','g--','HandleVisibility','off')
    plot(x1,-confmean(range1)-confsem(range1)','g--','HandleVisibility','off')
    plot(x1,-confmean(range1)+confsem(range1)','g--','HandleVisibility','off')
    plot(x1,y_est1,'LineWidth',2)
    plot(x1,y_est4,'LineWidth',2)
    plot(x1,-y_est4,'LineWidth',2,'HandleVisibility','off')
    yline(0,'--','HandleVisibility','off')
    yline(mean(confmean(1:19)),'--','HandleVisibility','off');
    yline(mean(-confmean(1:19)),'--','HandleVisibility','off');
    legend('motor','confidence')
    title('Pre-Perturbation')
    ylabel('Angle, degrees')
    xlabel('Trial')
    xticks([0 10 20])
    xticklabels({'1', '10', '20'})
    ylim([-20, 20])
    set(gca, 'TickDir', 'out', 'FontSize', 18)
    set(gcf,'color','w')

    subplot(1,3,2); hold on
    plot(x2,feedbackErrmean(range2)-feedbackErrsem(range2)','m--','HandleVisibility','off')
    plot(x2,feedbackErrmean(range2)+feedbackErrsem(range2)','m--','HandleVisibility','off')
    plot(x2,confmean(range2)-confsem(range2)','g--','HandleVisibility','off')
    plot(x2,confmean(range2)+confsem(range2)','g--','HandleVisibility','off')
    plot(x2,-confmean(range2)-confsem(range2)','g--','HandleVisibility','off')
    plot(x2,-confmean(range2)+confsem(range2)','g--','HandleVisibility','off')
    plot(x2,y_est2,'LineWidth',2)
    plot(x2,y_est5,'LineWidth',2)
    plot(x2,-y_est5,'LineWidth',2,'HandleVisibility','off')
    yline(0,'--','HandleVisibility','off')
    yline(mean(confmean(1:19)),'--','HandleVisibility','off');
    yline(mean(-confmean(1:19)),'--','HandleVisibility','off');
    legend('motor','confidence')
    title('Perturbation ON')
    ylabel('Angle, degrees')
    xlabel('Trial')
    xticks([0 10 20 30 40 50])
    xticklabels({'20', '30', '40','50','60','70'})
    ylim([-20, 20])
    set(gca, 'TickDir', 'out', 'FontSize', 18)
    set(gcf,'color','w')

    subplot(1,3,3); hold on
    plot(x3,feedbackErrmean(range3)-feedbackErrsem(range3)','m--','HandleVisibility','off')
    plot(x3,feedbackErrmean(range3)+feedbackErrsem(range3)','m--','HandleVisibility','off')
    plot(x3,confmean(range3)-confsem(range3)','g--','HandleVisibility','off')
    plot(x3,confmean(range3)+confsem(range3)','g--','HandleVisibility','off')
    plot(x3,-confmean(range3)-confsem(range3)','g--','HandleVisibility','off')
    plot(x3,-confmean(range3)+confsem(range3)','g--','HandleVisibility','off')
    plot(x3,y_est3,'LineWidth',2)
    plot(x3,y_est6,'LineWidth',2)
    plot(x3,-y_est6,'LineWidth',2,'HandleVisibility','off')
    yline(0,'--','HandleVisibility','off')
    yline(mean(confmean(1:19)),'--','HandleVisibility','off');
    yline(mean(-confmean(1:19)),'--','HandleVisibility','off');
    legend('motor','confidence')
    title('Perturbation OFF')
    ylabel('Angle, degrees')
    xlabel('Trial')
     xticks([0 10 20 30])
    xticklabels({'70', '80', '90','100'})
    ylim([-20, 20])
    set(gca, 'TickDir', 'out', 'FontSize', 18)
    set(gcf,'color','w')
end

%% Trial sequence NO model predictions
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput.mat',subj);
    load([path '/' filename])
    filename2 = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename2])

    figure; hold on
    %plot(feedbackErrmean,'m','LineWidth',2)
    plot(feedbackErrmean-feedbackErrsem','m--','HandleVisibility','off')
    plot(feedbackErrmean+feedbackErrsem','m--','HandleVisibility','off')
    %plot(confmean,'g','LineWidth',2)
    %plot(-confmean,'g','LineWidth',2,'HandleVisibility','off')
    plot(confmean-confsem','g--','HandleVisibility','off')
    plot(confmean+confsem','g--','HandleVisibility','off')
    plot(-confmean-confsem','g--','HandleVisibility','off')
    plot(-confmean+confsem','g--','HandleVisibility','off')
    xline(20,'LineWidth',2,'HandleVisibility','off');
    xline(70,'LineWidth',2,'HandleVisibility','off');
    yline(0,'--','HandleVisibility','off')
    yline(mean(confmean(1:19)),'--','HandleVisibility','off');
    yline(mean(-confmean(1:19)),'--','HandleVisibility','off');
    set(gca, 'TickDir', 'out', 'FontSize', 18)
    set(gcf,'color','w')
    xlabel('Trials')
    ylabel('Angle, degrees')
end

