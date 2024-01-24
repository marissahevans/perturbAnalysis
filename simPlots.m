x = 1:100;
figure
subplot(1,2,1); hold on
plot(handAnglemean,'b','LineWidth',2)
plot(handAnglemean-handAnglesem','b--','HandleVisibility','off')
plot(handAnglemean+handAnglesem','b--','HandleVisibility','off')
plot(feedbackErrmean,'r','LineWidth',2)
plot(feedbackErrmean-feedbackErrsem','r--','HandleVisibility','off')
plot(feedbackErrmean+feedbackErrsem','r--','HandleVisibility','off')
plot(confmean,'y','LineWidth',2)
plot(-confmean,'y','LineWidth',2)
plot(confmean-confsem','y--','HandleVisibility','off')
plot(confmean+confsem','y--','HandleVisibility','off')
plot(-confmean-confsem','y--','HandleVisibility','off')
plot(-confmean+confsem','y--','HandleVisibility','off')
yline(mean(confmean(1:19)),'--','HandleVisibility','off');
yline(-mean(confmean(1:19)),'--','HandleVisibility','off');
yline(0,'HandleVisibility','off');
%yline(20,'HandleVisibility','off');
yline(-20,'--','HandleVisibility','off');
%title('average block')
legend('Hand Angle','Feedback Angle','Confidence Angle','location','best')
ylabel('hand angle (degrees)')
xlabel('trial')
set(gca, 'TickDir', 'out', 'FontSize', 18)
set(gcf,'color','w')
title('Participant data')
ylim([-30 30])

subplot(1,2,2); hold on
plot(x,AS3,'y','LineWidth',2)
plot(x,-AS3,'y','LineWidth',2,'HandleVisibility','off')
plot(x,err3,'b','LineWidth',2)
plot(x,fb3,'r','LineWidth',2)

plot(err3-err3SEM','b--','HandleVisibility','off')
plot(err3+err3SEM','b--','HandleVisibility','off')
plot(fb3-fb3SEM','r--','HandleVisibility','off')
plot(fb3+fb3SEM','r--','HandleVisibility','off')
plot(AS3-AS3SEM','y--','HandleVisibility','off')
plot(AS3+AS3SEM','y--','HandleVisibility','off')
plot(-AS3-AS3SEM','y--','HandleVisibility','off')
plot(-AS3+AS3SEM','y--','HandleVisibility','off')

title('sim M3 - Ideal')
ylim([-30 30])
legend('arc3','error','feed')

%% 

x = 1:100;
y = 1;
figure
subplot(1,4,1); hold on
for i = 1:y

plot(x,AS1,'y','LineWidth',2)
plot(x,-AS1,'y','LineWidth',2,'HandleVisibility','off')
plot(x,err1,'b','LineWidth',2)
plot(x,fb1,'r','LineWidth',2)

plot(err1-err1SEM','b--','HandleVisibility','off')
plot(err1+err1SEM','b--','HandleVisibility','off')
plot(fb1-fb1SEM','r--','HandleVisibility','off')
plot(fb1+fb1SEM','r--','HandleVisibility','off')
plot(AS1-AS1SEM','y--','HandleVisibility','off')
plot(AS1+AS1SEM','y--','HandleVisibility','off')
plot(-AS1-AS1SEM','y--','HandleVisibility','off')
plot(-AS1+AS1SEM','y--','HandleVisibility','off')

%plot(x,sensed)
%plot(x,sensedHat)

end
title('M1 - Prospective')
ylim([-30 30])
legend('arc1','error','feed')

subplot(1,4,2); hold on
for i = 1:y

plot(x,AS2,'y','LineWidth',2)
plot(x,-AS2,'y','LineWidth',2,'HandleVisibility','off')
plot(x,err2,'b','LineWidth',2)
plot(x,fb2,'r','LineWidth',2)
%plot(x,-sensed)
%plot(x,-sensedHat)

plot(err2-err2SEM','b--','HandleVisibility','off')
plot(err2+err2SEM','b--','HandleVisibility','off')
plot(fb2-fb2SEM','r--','HandleVisibility','off')
plot(fb2+fb2SEM','r--','HandleVisibility','off')
plot(AS2-AS2SEM','y--','HandleVisibility','off')
plot(AS2+AS2SEM','y--','HandleVisibility','off')
plot(-AS2-AS2SEM','y--','HandleVisibility','off')
plot(-AS2+AS2SEM','y--','HandleVisibility','off')

end
title('M2 - Retro')
ylim([-30 30])
legend('arc2','error','feed')

subplot(1,4,3); hold on
for i = 1:y

plot(x,AS3,'y','LineWidth',2)
plot(x,-AS3,'y','LineWidth',2,'HandleVisibility','off')
plot(x,err3,'b','LineWidth',2)
plot(x,fb3,'r','LineWidth',2)
%plot(x,sensed)
%plot(x,sensedHat)

plot(err3-err3SEM','b--','HandleVisibility','off')
plot(err3+err3SEM','b--','HandleVisibility','off')
plot(fb3-fb3SEM','r--','HandleVisibility','off')
plot(fb3+fb3SEM','r--','HandleVisibility','off')
plot(AS3-AS3SEM','y--','HandleVisibility','off')
plot(AS3+AS3SEM','y--','HandleVisibility','off')
plot(-AS3-AS3SEM','y--','HandleVisibility','off')
plot(-AS3+AS3SEM','y--','HandleVisibility','off')

end
title('M3 - Ideal')
ylim([-30 30])
legend('arc3','error','feed')

subplot(1,4,4); hold on
for i = 1:y

plot(x,AS4,'y','LineWidth',2)
plot(x,-AS4,'y','LineWidth',2,'HandleVisibility','off')
plot(x,err4,'b','LineWidth',2)
plot(x,fb4,'r','LineWidth',2)
%plot(x,sensed)
%plot(x,sensedHat)

plot(err4-err4SEM','b--','HandleVisibility','off')
plot(err4+err4SEM','b--','HandleVisibility','off')
plot(fb4-fb4SEM','r--','HandleVisibility','off')
plot(fb4+fb4SEM','r--','HandleVisibility','off')
plot(AS4-AS4SEM','y--','HandleVisibility','off')
plot(AS4+AS4SEM','y--','HandleVisibility','off')
plot(-AS4-AS4SEM','y--','HandleVisibility','off')
plot(-AS4+AS4SEM','y--','HandleVisibility','off')

end
title('M4 - Ideal Kalman')
ylim([-30 30])
legend('arc4','error','feed')

%% 
figure
subplot(1,3,1); hold on
for i = 1:y
plot(x,mSig(:,1,1,1,1,1,1,1,1,1))
end
title('sigma_mf')
%ylim([-10 10])

subplot(1,3,2); hold on
for i = 1:y
plot(x,m1(:,1,1,1,1,1,1,1,1,1))
end
title('delta1')
%ylim([-10 10])

subplot(1,3,3); hold on
for i = 1:y
plot(x,m2(:,1,1,1,1,1,1,1,1,1))
end
title('delta2')
%ylim([-10 10])


%% figure


X= .1:.1:13;
Y= .1:.1:13;
Z = 10:45;

temp = squeeze(lookUpMat(15,:,:));
figure
surf(X,Y,temp)
xlabel('sigma_m')
ylabel('sigma_p')
zlabel('arc size')

temp = squeeze(lookUpMat(3,:,:));
figure
surf(X,Y,temp)
xlabel('sigma_m')
ylabel('sigma_p')
zlabel('arc size')


%%
figure; hold on
surf(X,Y,squeeze(lookUpMat1(ii,:,:)))
xlabel('sigP')
ylabel('sigM')
zlabel('dist')
xticks(1:130)
yticks(1:130)
xticklabels(.1:.1:13)
yticklabels(.1:.1:13)

%%
figure; hold on
plot(sigma_P)
plot(sigma_M)
