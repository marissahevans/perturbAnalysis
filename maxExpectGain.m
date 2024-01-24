%% PARAMETERS USED BY ALL MODELS

arcSize = 0:.5:45; %angle in degrees
t = 0;
r = [10,linspace(10,0,length(2:91))]; %points earned for each circle size
sigPmax = .1:.1:13;                           %vector of test sigma_p values in angle
sigMmax = .1:.1:13;                           %vector of test sigma_m values in angle

maxAngleAll = 0:90; %range of distance to max distance on the tablet.

%% CIRCLE LOOK UP TABLE FOR MODEL #1 - IDEAL MODEL - USES BOTH SIGMA_M AND SIGMA_P

lookUpMat1 = nan(length(maxAngleAll),length(sigPmax),length(sigMmax)); %initalize variable for lookup table

L1 = length(maxAngleAll); %Parpool looping variable for angle
P1 = length(sigPmax); %Parpool looping variable for sigma_p
M1 = length(sigMmax);%Parpool looping variable for sigma_m

for pp = 1:P1                            %Looping through all test values of sigma_p
    Rp = 1/sigPmax(pp)^2;
    for mm = 1:M1                           %Looping through all test values of sigma_m
        Rm = 1/sigMmax(mm)^2;
        var_pos = 1/(Rp+Rm);
        for angle = 1:L1                      %loop over all distances
            
            mu_pos1(angle,pp,mm) = (Rm/(Rp+Rm))*t + (Rp/(Rp+Rm))*maxAngleAll(angle);
            
            phit = normcdf(maxAngleAll,mu_pos1(angle,pp,mm),var_pos);
            gain = phit.*r;  %probability of a hit vs points possible at each distance
            
            %Radius point for each distance with the highest gain
             
           lookUpMat1(angle,pp,mm) = arcSize(max(find(gain == max(gain))));
  
        end %angle
        
    end %mm
end %pp

save lookUpTab1.mat lookUpMat1 mu_pos1


%%

lookUpMat2 = nan(length(maxAngleAll),length(sigPmax)); %initalize variable for lookup table

for angle = 1:L1                  %loop over all x axis points
        for pp = 1:P1          %loop through all possible values of sigma_p
            
            
            phit = normcdf(maxAngleAll,angle,sigPmax(pp)^2);
            gain = phit.*r; %probability of a hit vs points possible at each distance
            
            %Radius point for each distance with the highest gain
            lookUpMat2(angle,pp) = arcSize(max(find(gain == max(gain))));
            
        end %pp
    
end %angle

save lookUpTab2.mat lookUpMat2