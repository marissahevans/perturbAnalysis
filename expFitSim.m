%trials in a block 
x1 = 1:20; %before perturbation
x2 = 1:50; %during perturbation
x3 = 1:30; %after perturbation

lambda1 =               0.172230883906158    ;
lambda2 =               0.218902035046518  ;
peak1 =                12.799512163434837  ;
peak2 =                39.999995163023989  ;
bias =                 19.999996659679699 ;
weight =                0.580036331145045 ;

lambda3 =              6.225729191787507  ;
peak3 =                39.977037391907871  ;
lag =                  10.004958888522282 ;
baseline =              7.835148367103338 ;



%feedback
expfunc1 = [zeros(1,length(x1)),peak1*exp(-lambda1*x2),peak2*-exp(-lambda2*x3)];
expfunc2 = [zeros(1,length(x1)),bias*ones(1,length(x2)),zeros(1,length(x3))];
expfunc = weight*expfunc1 + (1-weight)*expfunc2;

%confidence
conffunc = [zeros(1,round(lag)), peak3*exp(-lambda3*x1)];
confidence = conv(abs(expfunc),conffunc)+baseline;

ls = sum((expfunc-feedbackErrmean').^2) + sum((confidence(1:100) - confmean').^2)

figure
hold on 
plot(1:100,expfunc,'LineWidth',2)
plot(confidence,'LineWidth',2) 
plot(feedbackErrmean)
plot(confmean)
yline(0);






% lambda1 =    0.1            ;
% lambda2 =    0.5167         ;
% lambda3 =    0.8894         ;
% peak1 =     26.0000         ;
% peak2 =     40.6855         ;
% peak3 =      0.4356         ;
% bias =       10             ;
% weight =     .9             ;
% lag =       2               ;
% baseline =   11             ;