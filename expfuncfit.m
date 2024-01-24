function [leastSq] = expfuncfit(lambda1,lambda2,lambda3,peak1,peak2,peak3,lag,bias,baseline,weight,feedback,confArc)
%

%Compares exponential functions to feedback postion and a convolution of
%two exponentials to the confidence judgments. 

%trials in a block 
x1 = 1:20; %before perturbation
x2 = 1:50; %during perturbation
x3 = 1:30; %after perturbation

%feedback
expfunc1 = [zeros(1,length(x1)),peak1*exp(-lambda1*x2),peak2*-exp(-lambda2*x3)];
expfunc2 = [zeros(1,length(x1)),bias*ones(1,length(x2)),zeros(1,length(x3))];
expfunc = weight*expfunc1 + (1-weight)*expfunc2;

%confidence
conffunc = [zeros(1,round(lag)), peak3*exp(-lambda3*x1)];
confidence = conv(abs(expfunc),conffunc)+baseline;

%least squares
lsFeed = sum((expfunc - feedback').^2);
lsConf = sum((confidence(1:100) - confArc').^2);
leastSq = lsFeed;



end