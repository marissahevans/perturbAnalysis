feedbackErrmean = mean(feedbackErr,2);
confmean = mean(conf,2);
numSims = 1000;

var1 = mean(x1);
[lsTot1, AS1, fb1, ASsem1, fbSem1] = pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(2),var1(3),var1(4));

var2 = mean(x2);
[lsTot2, AS2, fb2, ASsem2, fbSem2] = pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var2(1),var2(2),var2(3),var2(4),var2(5));

var3 = mean(x3);
[lsTot3, AS3, fb3, ASsem3, fbSem3] = pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var3(1),var3(2),var3(3),var3(4),var3(5),var3(6));

var4 = mean(x4);
[lsTot4, AS4, fb4, ASsem4, fbSem4] = pterbModel4(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var4(1),var4(2),var4(3),var4(4),var4(5),var4(6));

lsAll(ss,:) = [lsTot1 lsTot2 lsTot3 lsTot4];
lsMin = min(lsAll(ss,:));
lsDiff = lsAll(ss,:) - lsMin;

cvAll(ss,:) = [sum(cvLS1) sum(cvLS2) sum(cvLS3) sum(cvLS4)];
cvmin(ss) = min(cvAll(ss,:));
cvDiff(ss,:) =  cvAll(ss,:) - cvmin(ss);

allVar1(ss,:) = var1;
allVar2(ss,:) = var2;
allVar3(ss,:) = var3;
allVar4(ss,:) = var4;



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
