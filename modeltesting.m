numTrial = 100;      %number of trials
numSims = 100;
ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];

subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'}]; %,{'IJ'},{'AMN'},{'SB'}];
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);
    filename = sprintf('%s_LSoutput.mat',subj);
    load([path '/' filename])

%model 1  
sigma_m = minParam{1}(1);
sigma_p = minParam{1}(2);
alpha_m = minParam{1}(3);
alpha_p = minParam{1}(4);
bias = minParam{1}(5);
sigma_aim = minParam{1}(6);
alpha_mf = minParam{1}(7);

x01 = [sigma_m,alpha_m,bias,sigma_aim,alpha_mf];

lb1 = [.1 0 -20 .1 0];
ub1 = [20 1 20 20 1];

fun1 = @(var1) pterbModel5(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(2),var1(3),var1(4),var1(5));
[x1, ls1] = fmincon(fun1,x01,[],[],[],[],lb1,ub1)

var1 = x1;
[lsTot1, AS1, fb1] = pterbModel5(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(2),var1(3),var1(4),var1(5));

x = 1:100;
figure
hold on
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
title(['Model 1, LS= ' num2str(lsTot1)])
ylim([-30 30])
end
