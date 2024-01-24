
numTrial = 100;      %number of trials
numSims = 1000;
ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];
allParam1 = [];
allParam2 = [];
allParam3 = [];
allParam4 = [];

subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'}]; %,{'IJ'},{'AMN'},{'SB'}];
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename])

    var1 = minParam{1};
    [err1, AS1,fb1] = pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(3),var1(5),var1(6),var1(7));

    var2 = minParam{2};
    [err2, AS2,fb2] = pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var2(1),var2(2),var2(3),var2(4),var2(5),var2(6));

    var3 = minParam{3};
    [err3, AS3,fb3] = pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var3(1),var3(2),var3(3),var3(4),var3(5),var3(6),var3(7));

    var4 = minParam{4};
    [err4, AS4,fb4] = pterbModel4(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var4(1),var4(2),var4(3),var4(4),var4(6),var4(7));

    allParam1 = [allParam1;var1];
    allParam2 = [allParam2;var2];
    allParam3 = [allParam3;var3];
    allParam4 = [allParam4;var4];

%end
x = 1:100;
figure

subplot(1,4,1); hold on
plot(feedbackErrmean,'r','LineWidth',2)
plot(confmean,'y','LineWidth',2)
plot(x,AS1,'c','LineWidth',2)
plot(x,fb1,'m','LineWidth',2)
yline(mean(confmean(1:19)),'--','HandleVisibility','off');
yline(0,'HandleVisibility','off');
legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
ylabel('angle (degrees)')
xlabel('trial')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title(['Model 1 ' num2str(LSquares(1))])
ylim([-30 30])

subplot(1,4,2); hold on
plot(feedbackErrmean,'r','LineWidth',2)
plot(confmean,'y','LineWidth',2)
plot(x,AS2,'c','LineWidth',2)
plot(x,fb3,'m','LineWidth',2)
yline(mean(confmean(1:19)),'--','HandleVisibility','off');
yline(0,'HandleVisibility','off');
legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
ylabel('angle (degrees)')
xlabel('trial')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title(['Model 2 ' num2str(LSquares(2))])
ylim([-30 30])

subplot(1,4,3); hold on
plot(feedbackErrmean,'r','LineWidth',2)
plot(confmean,'y','LineWidth',2)
plot(x,AS3,'c','LineWidth',2)
plot(x,fb3,'m','LineWidth',2)
yline(mean(confmean(1:19)),'--','HandleVisibility','off');
yline(0,'HandleVisibility','off');
legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
ylabel('angle (degrees)')
xlabel('trial')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title(['Model 3 ' num2str(LSquares(3))])
ylim([-30 30])

subplot(1,4,4); hold on
plot(feedbackErrmean,'r','LineWidth',2)
plot(confmean,'y','LineWidth',2)
plot(x,AS4,'c','LineWidth',2)
plot(x,fb4,'m','LineWidth',2)
yline(mean(confmean(1:19)),'--','HandleVisibility','off');
yline(0,'HandleVisibility','off');
legend('Feedback Angle','Confidence Angle','model Conf','model Feed','location','best')
ylabel('angle (degrees)')
xlabel('trial')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title(['Model 4 ' num2str(LSquares(4))])
ylim([-30 30])

end




%sm,sp,am,ap,b1,saim,amf
%numTrial,numSims,ptb,sigma_m,sigma_p,alpha_m,alpha_p,bias,sigma_aim,alpha_mf