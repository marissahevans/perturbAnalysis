function [outputArg1,outputArg2] = untitled(sigma_m, sigma_p, sigma_aim, epAngle1,rpAngle1,handAngle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;

%Likelihood for Control Experiment
LLe = -N*log(2*pi) - 2*N*log(sigma_m) - (sum(epAngle1(:).^2)/(2*sigma_m^2));
RmTemp = 1/sigma_m^2;
RpTemp = 1/sigma_p^2;
SDigivene = (RpTemp/(RpTemp+RmTemp))*sigma_p;

% log likelihood of sigma_p given sensed location and endpoint:
LLigivene = -N*log(2*pi) - 2*N*log(SDigivene) - (sum(rpAngle1(:).^2)/(2*SDigivene^2));

% log likelihood of the sigma_p/sigma_m pair:
LL = LLe + LLigivene;

%Likelihood for endpoints
temp1 = handAngle(1:19,:);
probEndPts1 = normpdf(temp1(:),0,sigma_m);



end