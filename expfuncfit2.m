function [leastSq] = expfuncfit2(lambda3,peak3,lag,baseline,expfunc,confArc)
%

%Compares exponential functions to feedback postion and a convolution of
%two exponentials to the confidence judgments. 

%trials in a block 
x1 = 1:19; %before perturbation

%confidence
conffunc = [zeros(1,round(lag)), peak3*exp(-lambda3*x1)];
confidence = conv(abs(expfunc),conffunc)+baseline;

%least squares
lsConf = sum((confidence(1:100) - confArc').^2);
leastSq = lsConf;

end