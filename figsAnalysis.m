subjAll = [{'PL'},{'GK'},{'SB'},{'AN'},{'PK'},{'RW'},{'ET'},{'VD'},{'HP'},{'SM'},{'IJ'},{'NA'},{'FM'},{'BY'},{'SX'},{'MP'}];

for ss = 1%:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput2.mat',subj);
    load(sprintf('%s_LSoutput.mat',subj))
    load(sprintf('%s_fMinOutput_1.mat',subj))
    load(sprintf('%s_contExpFit.mat',subj))
    load([path '/' filename])

    % cvAll = [sum(cvLS1,2) sum(cvLS2,2) sum(cvLS3,2) sum(cvLS4,2)];
    % cvmin = min(cvAll');
    % cvDiff =  cvAll' - cvmin;
    % for ii = 1:20
    %     winnerAll(ii,ss) = find(cvDiff(:,ii)==0);
    % end
    winnerAll(ss,:) = winner;
end

for ii = 1:16
    winnerCounts(ii,:) = [sum(winnerAll(ii,:) == 1),sum(winnerAll(ii,:) == 2),sum(winnerAll(ii,:) == 3)];
end
for ii = 1:16
    topMod = find(winnerCounts(ii,:) == max(winnerCounts(ii,:)));
    winningMod(ii) = topMod(1);
end


figure
set(gcf,'Color','white')
heatmap(1:16,{'Prospective','Retrospective','Full'},winnerCounts')
ylabel('Model')
xlabel('Participant')
set(gca,'FontSize',18)


% figure
% for ii = 1:16
%     subplot(4,4,ii)
%     histogram(winnerAll(:,ii))
%     xlim([0,5])
% end

%% Box plots comparing best fit parameters for each model (from simualtions)


m1sigM = squeeze(x1(:,1,:));
m2sigM = squeeze(x2(:,1,:));
m3sigM = squeeze(x3(:,1,:));
m4sigM = squeeze(x4(:,1,:));

m2sigP = squeeze(x2(:,2,:));
m3sigP = squeeze(x3(:,2,:));
m4sigP = squeeze(x4(:,2,:));

m1alphaM = squeeze(x1(:,2,:));
m2alphaM = squeeze(x2(:,3,:));
m3alphaM = squeeze(x3(:,3,:));
m4alphaM = squeeze(x4(:,3,:));

m2alphaP = squeeze(x2(:,4,:));
m3alphaP = squeeze(x3(:,4,:));
m4alphaP = squeeze(x4(:,4,:));

m1sigA = squeeze(x1(:,3,:));
m2sigA = squeeze(x2(:,5,:));
m3sigA = squeeze(x3(:,5,:));
m4sigA = squeeze(x4(:,5,:));

m1alphaF = squeeze(x1(:,4,:));
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

%%
subjAll = [{'FM'},{'GK'},{'SM'},{'AN'},{'PK'},{'RW'},{'ET'},{'VD'},{'HP'},{'SB'},{'IJ'},{'NA'},{'PL'},{'BY'},{'SX'},{'MP'}];
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput2.mat',subj);
    load(sprintf('%s_contExpFit.mat',subj))
    sigM(ss) = sigMmarg;
    sigP(ss) = sigPmarg;
end

figure; hold on
set(gcf,'color','w');
plot([0:10],[0:10], 'k--')
scatter(sigM(1:5),sigP(1:5),100,'r','filled')
%text(sigMmarg(1:6),sigPmarg(1:6),{' P1',' P2',' P3',' P4',' P5',' P6'},'FontSize',14)
scatter(sigM(6:13),sigP(6:13),100,'b','filled')
%text(sigMmarg(7:14),sigPmarg(7:14),{' P7',' P8',' P9',' P10',' P11',' P12',' P13',' P14',},'FontSize',14)
scatter(sigM(14:16),sigP(14:16),100,'g','filled')
%text(sigMmarg(15:16),sigPmarg(15:16),{' P15',' P16'},'FontSize',14)
ylim([0 10])
xlim([0 6])
%axis equal
box off
yticks([0:2:10])
xticks([0:2:10])
set(gca, 'TickDir', 'out', 'FontSize', 18)
ylabel('proprioceptive error sigma (deg)','FontSize', 18)
xlabel('motor error sigma (deg)','FontSize', 18)
legend('Equality line','Best fit Prospective','Best fit Retrospective','Best fit Full','Location','best')
%% Boxplots for all participants 

%subjAll = [{'GK'},{'MP'},{'PL'},{'AN'},{'SB'},{'PK'},{'FM'},{'SM'},{'HP'},{'NA'},{'VD'},{'RW'},{'IJ'},{'ET'},{'BY'},{'SX'}];
subjAll = [{'PL'},{'GK'},{'SB'},{'AN'},{'PK'},{'RW'},{'ET'},{'VD'},{'HP'},{'SM'},{'IJ'},{'NA'},{'FM'},{'BY'},{'SX'},{'MP'}];

sigMBest = NaN(length(subjAll),240);
sigPBest = NaN(length(subjAll),240);
alphaMBest = NaN(length(subjAll),240);
alphaPBest = NaN(length(subjAll),240);
sigABest = NaN(length(subjAll),240);
alphaFBest = NaN(length(subjAll),240);
bestVals = NaN(length(subjAll),6);

for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput2.mat',subj);
    load(sprintf('%s_LSoutput.mat',subj))
    load(sprintf('%s_fMinOutput_1.mat',subj))
    load(sprintf('%s_contExpFit.mat',subj))
    load([path '/' filename])

    if winningMod(ss) == 1
        subset = winnerAll(:,ss) == 1;
        params = x1(:,:,subset);
        leastSQ = find(cvAll(subset,1) == min(cvAll(subset,1)));
        bestVals(ss,[1,3,5,6]) = params(1,:,leastSQ);

        x = squeeze(x1(:,1,winnerAll(ss,:)==1));
        sigMBest(ss,1:length(x(:))) = x(:);
        % sigPBest(ss,:) = nan;
        x = squeeze(x1(:,2,winnerAll(ss,:)==1));
        alphaMBest(ss,1:length(x(:))) = x(:);
        %alphaPBest(ss,:) = nan;
        x = squeeze(x1(:,3,winnerAll(ss,:)==1));
        sigABest(ss,1:length(x(:))) = x(:);
        x = squeeze(x1(:,4,winnerAll(ss,:)==1));
        alphaFBest(ss,1:length(x(:))) = x(:);
    
    elseif winningMod(ss) == 2
        subset = winnerAll(:,ss) == 2;
        params = x2(:,:,subset);
        leastSQ = find(cvAll(subset,2) == min(cvAll(subset,2)));
        bestVals(ss,1:5) = params(1,:,leastSQ);

        x = squeeze(x2(:,1,winnerAll(ss,:)==2));
        sigMBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x2(:,2,winnerAll(ss,:)==2));
        sigPBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x2(:,3,winnerAll(ss,:)==2));
        alphaMBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x2(:,4,winnerAll(ss,:)==2));
        alphaPBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x2(:,5,winnerAll(ss,:)==2));
        sigABest(ss,1:length(x(:))) = x(:);
    
    else
        subset = winnerAll(:,ss) == 3;
        params = x3(:,:,subset);
        leastSQ = find(cvAll(subset,3) == min(cvAll(subset,3)));
        bestVals(ss,:) = params(1,:,leastSQ);

        x = squeeze(x3(:,1,winnerAll(ss,:)==3));
        sigMBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x3(:,2,winnerAll(ss,:)==3));
        sigPBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x3(:,3,winnerAll(ss,:)==3));
        alphaMBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x3(:,4,winnerAll(ss,:)==3));
        alphaPBest(ss,1:length(x(:))) = x(:);
        x = squeeze(x3(:,5,winnerAll(ss,:)==3));
        sigABest(ss,1:length(x(:))) = x(:);
        x = squeeze(x3(:,6,winnerAll(ss,:)==3));
        alphaFBest(ss,1:length(x(:))) = x(:);
    end

end

figure
set(gcf,'Color','white')
subplot(2,3,1); hold on
boxchart(sigMBest','MarkerStyle','.','JitterOutliers','on','BoxFaceColor','black','MarkerColor','black')
scatter(1:16,sigM,50,'red','filled')
scatter(1:16,bestVals(:,1),50,'cyan','filled')
xline([5.5,13.5],'--')
title('Motor Error')
xlabel('Participant')
ylabel('Degrees')
set(gca, 'tickdir','out','FontSize',18)

subplot(2,3,2); hold on
boxchart(sigPBest','MarkerStyle','.','JitterOutliers','on','BoxFaceColor','black','MarkerColor','black')
scatter(1:16,sigP,50,'red','filled')
scatter(1:16,bestVals(:,2),50,'cyan','filled')
xline([5.5,13.5],'--')
title('Proprioceptive Error')
xlabel('Participant')
ylabel('Degrees')
set(gca, 'tickdir','out','FontSize',18)

subplot(2,3,3); hold on
boxchart(alphaMBest','MarkerStyle','.','JitterOutliers','on','BoxFaceColor','black','MarkerColor','black')
scatter(1:16,bestVals(:,3),50,'cyan','filled')
xline([5.5,13.5],'--')
title('Motor Alpha')
xlabel('Participant')
set(gca, 'tickdir','out','FontSize',18)

subplot(2,3,4); hold on
boxchart(alphaPBest','MarkerStyle','.','JitterOutliers','on','BoxFaceColor','black','MarkerColor','black')
scatter(1:16,bestVals(:,4),50,'cyan','filled')
xline([5.5,13.5],'--')
title('Proprioceptive Alpha')
xlabel('Participant')
set(gca, 'tickdir','out','FontSize',18)

subplot(2,3,5); hold on
boxchart(sigABest','MarkerStyle','.','JitterOutliers','on','BoxFaceColor','black','MarkerColor','black')
scatter(1:16,bestVals(:,5),50,'cyan','filled')
xline([5.5,13.5],'--')
title('Aiming Error')
xlabel('Participant')
ylabel('Degrees')
set(gca, 'tickdir','out','FontSize',18)

subplot(2,3,6); hold on
boxchart(alphaFBest','MarkerStyle','.','JitterOutliers','on','BoxFaceColor','black','MarkerColor','black')
scatter(1:16,bestVals(:,6),50,'cyan','filled')
xline([5.5,13.5],'--')
title('Feedback Learning')
xlabel('Participant')
set(gca, 'tickdir','out','FontSize',18)
%% Time course plots compared to model simualtions
subjAll = [{'PL'},{'GK'},{'SB'},{'AN'},{'PK'},{'RW'},{'ET'},{'VD'},{'HP'},{'SM'},{'IJ'},{'NA'},{'FM'},{'BY'},{'SX'},{'MP'}];

numTrial = 70;      %number of trials
numBlocks = 12;
numSims = 1000;
ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];
figs = 0; %show figures in loop

for ss = 1:16%:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput2.mat',subj);
    load([path '/' filename])
    filename2 = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename2])

    subset = winnerAll(:,ss) == winningMod(ss);
    cvAll = [sum(cvLS1,2), sum(cvLS2,2), sum(cvLS3,2)];

    if winningMod(ss) == 1
        params = x1(:,:,subset);
        leastSQ = find(cvAll(subset,1) == min(cvAll(subset,1)));
        bestVals = params(1,:,leastSQ);
        %bestVals = mean(mean(params,3));
        [lsTot1, AS1, fb1, ASsem1, fbSem1] = pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4));
        
        figure; hold on
        plot(feedbackErrmean-feedbackErrsem','m--')
        plot(feedbackErrmean+feedbackErrsem','m--','HandleVisibility','off')
        plot(confmean-confsem','g--')
        plot(confmean+confsem','g--','HandleVisibility','off')
        plot(-confmean-confsem','g--','HandleVisibility','off')
        plot(-confmean+confsem','g--','HandleVisibility','off')
        plot(AS1,'k','LineWidth',2)
        plot(-AS1,'k','LineWidth',2,'HandleVisibility','off')
        plot(fb1,'b','LineWidth',2)
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle','Confidence Angle','Model Confidence','Model Feedback','location','best')
        ylabel('Angle (degrees)')
        xlabel('Trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Prospective Model')
        ylim([-20 20])

    elseif winningMod(ss) == 2
        params = x2(:,:,subset);
        leastSQ = find(cvAll(subset,2) == min(cvAll(subset,2)));
        bestVals = params(1,:,leastSQ);
        %bestVals = mean(mean(params,3));
        [lsTot2, AS2, fb2, ASsem2, fbSem2] = pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5));
        
        figure; hold on
        plot(feedbackErrmean-feedbackErrsem','m--')
        plot(feedbackErrmean+feedbackErrsem','m--','HandleVisibility','off')
        plot(confmean-confsem','g--')
        plot(confmean+confsem','g--','HandleVisibility','off')
        plot(-confmean-confsem','g--','HandleVisibility','off')
        plot(-confmean+confsem','g--','HandleVisibility','off')
        plot(AS2,'k','LineWidth',2)
        plot(-AS2,'k','LineWidth',2,'HandleVisibility','off')
        plot(fb2,'b','LineWidth',2)
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle','Confidence Angle','Model Confidence','Model Feedback','location','best')
        ylabel('Angle (degrees)')
        xlabel('Trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Retrospective Model')
        ylim([-20 20])

    elseif winningMod(ss) == 3
        params = x3(:,:,subset);
        leastSQ = find(cvAll(subset,3) == min(cvAll(subset,3)));
        %bestVals = params(1,:,leastSQ);
        bestVals = mean(mean(params,3));
        [lsTot3, AS3, fb3, ASsem3, fbSem3] = pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5),bestVals(6));
        
        figure; hold on
        plot(feedbackErrmean-feedbackErrsem','m--')
        plot(feedbackErrmean+feedbackErrsem','m--','HandleVisibility','off')
        plot(confmean-confsem','g--')
        plot(confmean+confsem','g--','HandleVisibility','off')
        plot(-confmean-confsem','g--','HandleVisibility','off')
        plot(-confmean+confsem','g--','HandleVisibility','off')
        plot(AS3,'k','LineWidth',2)
        plot(-AS3,'k','LineWidth',2,'HandleVisibility','off')
        plot(fb3,'b','LineWidth',2)
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        legend('Feedback Angle','Confidence Angle','Model Confidence','Model Feedback','location','best')
        ylabel('Angle (degrees)')
        xlabel('Trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title('Full Model')
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


%% Trial sequence NO model predictions
for ss = [5,12,15]
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
    ylim([-20,20])
    xlabel('trials')
    ylabel('angle, degrees')
    title(['Participant ', num2str(ss)])
end

%%
%best fit parameter histogram plots
for ss = 7:16%length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput2.mat',subj);
    load([path '/' filename])
    filename2 = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename2])

    subset = winnerAll(:,ss) == winningMod(ss);

    if winningMod(ss) == 1
        params = x1(:,:,subset);

        figure
        subplot(1,4,1)
        histogram(params(:,1,:))
        title('sigma m)')
        xlim([0,20])
        subplot(1,4,2)
        histogram(params(:,2,:))
        title('alpha m')
        xlim([0,1])
        subplot(1,4,3)
        histogram(params(:,3,:))
        title('sigma aim')
        xlim([0,20])
        subplot(1,4,4)
        histogram(params(:,4,:))
        title('alpha est. m')
        xlim([0,1])
    
    elseif winningMod(ss) == 2
        params = x2(:,:,subset);

        figure
        subplot(1,5,1)
        histogram(params(:,1,:))
        title('sigma m)')
        xlim([0,20])
        subplot(1,5,2)
        histogram(params(:,2,:))
        title('sigma p')
        xlim([0,20])
        subplot(1,5,3)
        histogram(params(:,3,:))
        title('alpha m')
        xlim([0,1])
        subplot(1,5,4)
        histogram(params(:,4,:))
        title('alpha p')
        xlim([0,1])
        subplot(1,5,5)
        histogram(params(:,5,:))
        title('sigma aim')
        xlim([0,20])
    
    elseif winningMod(ss) == 3
        params = x3(:,:,subset);

        figure
        subplot(1,6,1)
        histogram(params(:,1,:))
        title('sigma m)')
        xlim([0,20])
        subplot(1,6,2)
        histogram(params(:,2,:))
        title('sigma p')
        xlim([0,20])
        subplot(1,6,3)
        histogram(params(:,3,:))
        title('alpha m')
        xlim([0,1])
        subplot(1,6,4)
        histogram(params(:,4,:))
        title('alpha p')
        xlim([0,1])
        subplot(1,6,5)
        histogram(params(:,5,:))
        title('sigma aim')
        xlim([0,20])
        subplot(1,6,6)
        histogram(params(:,6,:))
        title('alpha est. m')
        xlim([0,1])
    end

   
end

%% Time course plots compared to model simualtions
subjAll = [{'PL'},{'GK'},{'SB'},{'AN'},{'PK'},{'RW'},{'ET'},{'VD'},{'HP'},{'SM'},{'IJ'},{'NA'},{'FM'},{'BY'},{'SX'},{'MP'}];

numTrial = 70;      %number of trials
numBlocks = 12;
numSims = 1000;
ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];


for ss = [4 6 14]%:length(subjAll)
    figure
    sgtitle(['Participant ',num2str(ss)])
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_badsMinOutput2.mat',subj);
    load([path '/' filename])
    filename2 = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename2])

    
    cvAll = [sum(cvLS1,2), sum(cvLS2,2), sum(cvLS3,2)];

    %PROSPECTIVE
    subset = winnerAll(:,ss) == 1;
    params = x1(:,:,subset);
    leastSQ = find(cvAll(subset,1) == min(cvAll(subset,1)));
    bestVals = params(1,:,leastSQ);
    %bestVals = mean(mean(params,3));
    [lsTot1, AS1, fb1, ASsem1, fbSem1] = pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4));

    subplot(1,3,1); hold on
    patch([20:70, fliplr(20:70)], [-10*ones(1,51), fliplr(25*ones(1,51))],'K', 'FaceAlpha',0.1,'HandleVisibility','off',EdgeColor='none');
    patch([1:70, fliplr(1:70)], [feedbackErrmean(1:70)'-feedbackErrsem(1:70), fliplr(feedbackErrmean(1:70)'+feedbackErrsem(1:70))],[0.4940 0.1840 0.5560], 'FaceAlpha',0.5,EdgeColor='none');
    plot(feedbackErrmean(1:70),'Color',[0.4940 0.1840 0.5560],'HandleVisibility','off')
    patch([1:70, fliplr(1:70)], [confmean(1:70)'-confsem(1:70), fliplr(confmean(1:70)'+confsem(1:70))],[0.8500 0.3250 0.0980], 'FaceAlpha',0.5,EdgeColor='none');
    plot(confmean(1:70),'Color',[0.8500 0.3250 0.0980],'HandleVisibility','off')
    plot(AS1,'r','LineWidth',3)
    plot(fb1,'b','LineWidth',3)
    yline(0);
    ylim([-10 25])
    xlim([1 70])
    xticks([20 70])
    xlabel('trial')
    ylabel('directional error (deg)')
    title('Prospective Model')
    box off
    set(gca,'TickDir','out','FontSize',18)
    set(gcf,'Color','white','position',[0,0,1600,500])

    %RETROSPECTIVE
    subset = winnerAll(:,ss) == 2;
    params = x2(:,:,subset);
    leastSQ = find(cvAll(subset,2) == min(cvAll(subset,2)));
    bestVals = params(1,:,leastSQ);
    %bestVals = mean(mean(params,3));
    [lsTot2, AS2, fb2, ASsem2, fbSem2] = pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5));

    subplot(1,3,2); hold on
    patch([20:70, fliplr(20:70)], [-10*ones(1,51), fliplr(25*ones(1,51))],'K', 'FaceAlpha',0.1,'HandleVisibility','off',EdgeColor='none');
    patch([1:70, fliplr(1:70)], [feedbackErrmean(1:70)'-feedbackErrsem(1:70), fliplr(feedbackErrmean(1:70)'+feedbackErrsem(1:70))],[0.4940 0.1840 0.5560], 'FaceAlpha',0.5,EdgeColor='none');
    plot(feedbackErrmean(1:70),'Color',[0.4940 0.1840 0.5560],'HandleVisibility','off')
    patch([1:70, fliplr(1:70)], [confmean(1:70)'-confsem(1:70), fliplr(confmean(1:70)'+confsem(1:70))],[0.8500 0.3250 0.0980], 'FaceAlpha',0.5,EdgeColor='none');
    plot(confmean(1:70),'Color',[0.8500 0.3250 0.0980],'HandleVisibility','off')
    plot(AS2,'r','LineWidth',3)
    plot(fb2,'b','LineWidth',3)
    yline(0);
    ylim([-10 25])
    xlim([1 70])
    xticks([20 70])
    xlabel('trial')
    ylabel('directional error (deg)')
    title('Retrospective Model')
    box off
    set(gca,'TickDir','out','FontSize',18)
    set(gcf,'Color','white','position',[0,0,1600,500])

    %FULL 
    subset = winnerAll(:,ss) == 3;
    params = x3(:,:,subset);
    leastSQ = find(cvAll(subset,3) == min(cvAll(subset,3)));
    bestVals = params(1,:,leastSQ);
    %bestVals = mean(mean(params,3));
    [lsTot3, AS3, fb3, ASsem3, fbSem3] = pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,bestVals(1),bestVals(2),bestVals(3),bestVals(4),bestVals(5),bestVals(6));

    subplot(1,3,3); hold on
    patch([20:70, fliplr(20:70)], [-10*ones(1,51), fliplr(25*ones(1,51))],'K', 'FaceAlpha',0.1,'HandleVisibility','off',EdgeColor='none');
    patch([1:70, fliplr(1:70)], [feedbackErrmean(1:70)'-feedbackErrsem(1:70), fliplr(feedbackErrmean(1:70)'+feedbackErrsem(1:70))],[0.4940 0.1840 0.5560], 'FaceAlpha',0.5,EdgeColor='none');
    plot(feedbackErrmean(1:70),'Color',[0.4940 0.1840 0.5560],'HandleVisibility','off')
    patch([1:70, fliplr(1:70)], [confmean(1:70)'-confsem(1:70), fliplr(confmean(1:70)'+confsem(1:70))],[0.8500 0.3250 0.0980], 'FaceAlpha',0.5,EdgeColor='none');
    plot(confmean(1:70),'Color',[0.8500 0.3250 0.0980],'HandleVisibility','off')
    plot(AS3,'r','LineWidth',3)
    plot(fb3,'b','LineWidth',3)
    yline(0);
    ylim([-10 25])
    xlim([1 70])
    xticks([20 70])
    xlabel('trial')
    ylabel('directional error (deg)')
    title('Full Model')
    box off
    set(gca,'TickDir','out','FontSize',18)
    set(gcf,'Color','white','position',[0,0,1600,500])
    if ss == 14
        legend('feedback','confidence','model confidence','model feedback','location','northeast')
    end


end