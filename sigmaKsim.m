%Simulation of the sigma update for Kalman filter

alpha = .6:.1:1; %0 to 1
sigma_d = 1:5;
sigma_m = 5:5:25;
sigma_k = 0; %initalize

for aa = 1:5 %loop over alpha values
    figure
    for bb = 1:5 %loop over sigma d values
        subplot(1,5,bb); hold on
        title(['sigma_d = ' num2str(sigma_d(bb))])
        ylim([0 10])
        for cc = 1:5 %loop over sigma m values
            for jj = 1:60 %loop over trials 
                expVar = alpha(aa)^2*sigma_k(jj)^2+sigma_d(bb)^2;
                kalman = expVar/(expVar+sigma_m(cc)^2);
                sigma_k(jj+1) = sqrt((1-kalman)*expVar);
            end
            plot(sigma_k)
        end
    end
end
