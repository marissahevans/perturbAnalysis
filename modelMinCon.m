numTrial = 100;      %number of trials
numBlocks = 12;
ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];
figs = 0; %show figures in loop

tic
subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'},{'IJ'},{'AN'},{'SB'},{'VD'},{'GK'},{'PK'},{'RW'},{'SX'}];
for ss = 15%1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename])
    numSims = 300;
    for gg = 1
    for cv = 1:numBlocks
        samp = logical(zeros(1,numBlocks));
        samp(cv) = 1;
        testBlockfeed = feedbackErr(:,samp);
        feedbackErrmean = mean(feedbackErr(:,~samp),2);

        testBlockconf = conf(:,samp);
        confmean = mean(conf(:,~samp),2);


        %model 1
        sigma_m = minParam{1}(1);
        alpha_m = minParam{1}(3);
        sigma_aim = minParam{1}(6);
        alpha_mf = minParam{1}(7);

        x01 = [sigma_m,alpha_m,sigma_aim,alpha_mf];

        lb1 = [.1 0 .1 0];
        ub1 = [20 1 20 1];

        fun1 = @(var1) pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(2),var1(3),var1(4));
        [x1(cv,:), ls1(cv)] = fmincon(fun1,x01,[],[],[],[],lb1,ub1);
        [cvLS1(cv)]= pterbModel1(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x1(cv,1),x1(cv,2),x1(cv,3),x1(cv,4));

        %model 2
        sigma_m = minParam{2}(1);
        sigma_p = minParam{2}(2);
        alpha_m = minParam{2}(3);
        alpha_p = minParam{2}(4);
        sigma_aim = minParam{2}(6);

        x02 = [sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim];

        lb2 = [.1 .1 0 0 .1];
        ub2 = [20 20 1 1 20];

        fun2 = @(var2) pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var2(1),var2(2),var2(3),var2(4),var2(5));
        [x2(cv,:), ls2(cv)] = fmincon(fun2,x02,[],[],[],[],lb2,ub2)
        [cvLS2(cv)]= pterbModel2(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x2(cv,1),x2(cv,2),x2(cv,3),x2(cv,4),x2(cv,5));

        %model 3
        sigma_m = minParam{3}(1);
        sigma_p = minParam{3}(2);
        alpha_m = minParam{3}(3);
        alpha_p = minParam{3}(4);
        sigma_aim = minParam{3}(6);
        alpha_mf = minParam{3}(7);

        x03 = [sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim,alpha_mf];

        lb3 = [.1 .1 0 0 .1 0];
        ub3 = [20 20 1 1 20 1];

        fun3 = @(var3) pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var3(1),var3(2),var3(3),var3(4),var3(5),var3(6));
        [x3(cv,:), ls3(cv)] = fmincon(fun3,x03,[],[],[],[],lb3,ub3)
        [cvLS3(cv)]= pterbModel3(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x3(cv,1),x3(cv,2),x3(cv,3),x3(cv,4),x3(cv,5),x3(cv,6));

        %model 4
        sigma_m = minParam{4}(1);
        sigma_p = minParam{4}(2);
        alpha_m = minParam{4}(3);
        alpha_p = minParam{4}(4);
        sigma_aim = minParam{4}(6);
        alpha_mf = minParam{4}(7);

        x04 = [sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim,alpha_mf];

        lb4 = [.1 .1 0 0 .1 0];
        ub4 = [20 20 1 1 20 1];

        fun4 = @(var4) pterbModel4(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var4(1),var4(2),var4(3),var4(4),var4(5),var4(6));
        [x4(cv,:), ls4(cv)] = fmincon(fun4,x04,[],[],[],[],lb4,ub4)
        [cvLS4(cv)]= pterbModel4(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x4(cv,1),x4(cv,2),x4(cv,3),x4(cv,4),x4(cv,5),x4(cv,6));
    end

    % feedbackErrmean = mean(feedbackErr,2);
    % confmean = mean(conf,2);
    % numSims = 1000;
    % 
    % var1 = mean(x1);
    % [lsTot1, AS1, fb1, ASsem1, fbSem1] = pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(2),var1(3),var1(4));
    % 
    % var2 = mean(x2);
    % [lsTot2, AS2, fb2, ASsem2, fbSem2] = pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var2(1),var2(2),var2(3),var2(4),var2(5));
    % 
    % var3 = mean(x3);
    % [lsTot3, AS3, fb3, ASsem3, fbSem3] = pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var3(1),var3(2),var3(3),var3(4),var3(5),var3(6));
    % 
    % var4 = mean(x4);
    % [lsTot4, AS4, fb4, ASsem4, fbSem4] = pterbModel4(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var4(1),var4(2),var4(3),var4(4),var4(5),var4(6));
    % 
    % lsAll(ss,:) = [lsTot1 lsTot2 lsTot3 lsTot4];
    % lsMin = min(lsAll(ss,:));
    % lsDiff = lsAll(ss,:) - lsMin;
    % 
    % cvAll(ss,:) = [sum(cvLS1) sum(cvLS2) sum(cvLS3) sum(cvLS4)];
    % cvmin(ss) = min(cvAll(ss,:));
    % cvDiff(ss,:) =  cvAll(ss,:) - cvmin(ss);
    % 
    % allVar1(ss,:) = var1;
    % allVar2(ss,:) = var2;
    % allVar3(ss,:) = var3;
    % allVar4(ss,:) = var4;

    cvAll = [sum(cvLS1) sum(cvLS2) sum(cvLS3) sum(cvLS4)];
    cvmin = min(cvAll);
    cvDiff=  cvAll - cvmin;
    winner(gg) = find(cvDiff==0);

    filename2 = sprintf('%s_fMinOutput_%d.mat',subj,gg);
    save(fullfile(path,filename2), 'x1','x2','x3','x4','cvLS1','cvLS2','cvLS3','cvLS4','cvDiff') %,'AS1','AS2','AS3','AS4','ASsem1','ASsem2','ASsem3','ASsem4','fb1','fb2','fb3','fb4','fbSem1','fbSem2','fbSem3','fbSem4','lsAll','lsDiff','var1','var2','var3','var4','feedbackErrmean','confmean')
    end 

    filename3 = sprintf('%s_winningModel.mat',subj);
    save(fullfile(path,filename3), 'winner');
    
    if figs == 1
        x = 1:100;
        figure
        subplot(1,4,1); hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(x,AS1,'k','LineWidth',2)
        plot(AS1-ASsem1','k--','HandleVisibility','off')
        plot(AS1+ASsem1','k--','HandleVisibility','off')
        plot(x,-AS1,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS1-ASsem1','k--','HandleVisibility','off')
        plot(-AS1+ASsem1','k--','HandleVisibility','off')
        plot(x,fb1,'b','LineWidth',2)
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
        title(['Model 1, cvLS diff= ' num2str(cvDiff(ss,1))])
        ylim([-30 30])

        subplot(1,4,2); hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(x,AS2,'k','LineWidth',2)
        plot(AS2-ASsem2','k--','HandleVisibility','off')
        plot(AS2+ASsem2','k--','HandleVisibility','off')
        plot(x,-AS2,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS2-ASsem2','k--','HandleVisibility','off')
        plot(-AS2+ASsem2','k--','HandleVisibility','off')
        plot(x,fb2,'b','LineWidth',2)
        plot(fb2-fbSem2','b--','HandleVisibility','off')
        plot(fb2+fbSem2','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        %legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
        ylabel('angle (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title(['Model 2, cvLS diff= ' num2str(cvDiff(ss,2))])
        ylim([-30 30])

        subplot(1,4,3); hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(x,AS3,'k','LineWidth',2)
        plot(AS3-ASsem3','k--','HandleVisibility','off')
        plot(AS3+ASsem3','k--','HandleVisibility','off')
        plot(x,-AS3,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS3-ASsem3','k--','HandleVisibility','off')
        plot(-AS3+ASsem3','k--','HandleVisibility','off')
        plot(x,fb1,'b','LineWidth',2)
        plot(fb3-fbSem3','b--','HandleVisibility','off')
        plot(fb3+fbSem3','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        %legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
        ylabel('angle (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title(['Model 3, cvLS diff= ' num2str(cvDiff(ss,3))])
        ylim([-30 30])

        subplot(1,4,4); hold on
        plot(feedbackErrmean,'r','LineWidth',2)
        plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
        plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
        plot(confmean,'m','LineWidth',2)
        plot(-confmean,'m','LineWidth',2,'HandleVisibility','off')
        plot(confmean-confsem','m--','HandleVisibility','off')
        plot(confmean+confsem','m--','HandleVisibility','off')
        plot(-confmean-confsem','m--','HandleVisibility','off')
        plot(-confmean+confsem','m--','HandleVisibility','off')
        plot(x,AS4,'k','LineWidth',2)
        plot(AS4-ASsem4','k--','HandleVisibility','off')
        plot(AS4+ASsem4','k--','HandleVisibility','off')
        plot(x,-AS4,'k','LineWidth',2,'HandleVisibility','off')
        plot(-AS4-ASsem4','k--','HandleVisibility','off')
        plot(-AS4+ASsem4','k--','HandleVisibility','off')
        plot(x,fb4,'b','LineWidth',2)
        plot(fb4-fbSem4','b--','HandleVisibility','off')
        plot(fb4+fbSem4','b--','HandleVisibility','off')
        yline(mean(confmean(1:19)),'--','HandleVisibility','off');
        yline(-(mean(confmean(1:19))),'--','HandleVisibility','off');
        yline(0,'HandleVisibility','off');
        %legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
        ylabel('angle (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
        title(['Model 4, cvLS diff= ' num2str(cvDiff(ss,4))])
        ylim([-30 30])
    end


end
toc



% figure
% for ii = 1:16
%     subplot(4,4,ii)
%     bar(cvDiff(ii,:))
%     ylim([0 1000])
%     xlabel('model')
%     ylabel('cv diff')
%     title(['CV subj ' num2str(ii)])
% end

