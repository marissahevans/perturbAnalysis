%Perterbation project - Comparing preprocessed data to data with learning
%rate removed. Check done for manuscript 7/31/24


plot0 = 0; %1 if showing raw data before adjustment
plot1 = 0; %1 if showing average data before adjustment
plot2 = 0; %1 if showing raw data plot after adjustment
plot3 = 0; %1 if showing average block plot
plot4 = 1; %1 if showing learning rate accross perturbation trials

%%
tic
winMod = [];

subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'},{'IJ'},{'AN'},{'SB'},{'VD'},{'GK'},{'PK'},{'RW'},{'SX'}];
for ss = 1: length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);

    if subj == 'AN'
        R1 = load(sprintf('%s',path,'/AN_perturb_exp_S1_2023-12-03_14-55_controlresults.mat'));
        %R1 = load(sprintf('%s',path,'/AN_perturb_exp_S1_2023-12-03_15-52_controlresults.mat')); %Needs to be joined with above
        D1 = load(sprintf('%s',path,'/AN_perturb_exp_S1_2023-12-03_15-52_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/AN_perturb_exp_S2_2023-11-22_13-22_results.mat'));
        D2 = load(sprintf('%s',path,'/AN_perturb_exp_S2_2023-11-22_13-22_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/AN_perturb_exp_S3_2023-11-29_18-27_results.mat'));
        D3 = load(sprintf('%s',path,'/AN_perturb_exp_S3_2023-11-29_18-27_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/AN_perturb_exp_S4_2023-12-03_14-00_results.mat'));
        D4 = load(sprintf('%s',path,'/AN_perturb_exp_S4_2023-12-03_14-00_dispInfo.mat'));

    elseif subj == 'BY'
        R1 = load(sprintf('%s',path,'/BY_perturb_exp_S1_2023-11-15_12-29_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/BY_perturb_exp_S1_2023-11-15_12-29_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/BY_perturb_exp_S2_2023-11-16_14-11_results.mat'));
        D2 = load(sprintf('%s',path,'/BY_perturb_exp_S2_2023-11-16_14-11_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/BY_perturb_exp_S3_2023-11-17_13-01_results.mat'));
        D3 = load(sprintf('%s',path,'/BY_perturb_exp_S3_2023-11-17_13-01_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/BY_perturb_exp_S4_2023-11-20_16-58_results.mat'));
        D4 = load(sprintf('%s',path,'/BY_perturb_exp_S4_2023-11-20_16-58_dispInfo.mat'));

    elseif subj == 'ET'
        R1 = load(sprintf('%s',path,'/ET_perturb_exp_S1_2023-11-02_11-00_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/ET_perturb_exp_S1_2023-11-02_11-00_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/ET_perturb_exp_S2_2023-11-28_13-54_results.mat'));
        D2 = load(sprintf('%s',path,'/ET_perturb_exp_S2_2023-11-28_13-54_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/ET_perturb_exp_S3_2023-11-29_10-13_results.mat'));
        D3 = load(sprintf('%s',path,'/ET_perturb_exp_S3_2023-11-29_10-13_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/ET_perturb_exp_S4_2023-11-30_11-07_results.mat'));
        D4 = load(sprintf('%s',path,'/ET_perturb_exp_S4_2023-11-30_11-07_dispInfo.mat'));

    elseif subj == 'FM'
        R1 = load(sprintf('%s',path,'/FM_perturb_exp_S1_2023-11-02_16-54_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/FM_perturb_exp_S1_2023-11-02_16-54_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/FM_perturb_exp_S2_2023-11-14_17-10_results.mat'));
        D2 = load(sprintf('%s',path,'/FM_perturb_exp_S2_2023-11-14_17-10_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/FM_perturb_exp_S3_2023-11-16_17-23_results.mat'));
        D3 = load(sprintf('%s',path,'/FM_perturb_exp_S3_2023-11-16_17-23_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/FM_perturb_exp_S4_2023-11-21_16-54_results.mat'));
        D4 = load(sprintf('%s',path,'/FM_perturb_exp_S4_2023-11-21_16-54_dispInfo.mat'));

    elseif subj == 'GK'
        R1 = load(sprintf('%s',path,'/GK_perturb_exp_S1_2023-12-15_12-36_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/GK_perturb_exp_S1_2023-12-15_12-36_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/GK_perturb_exp_S2_2023-12-04_15-54_results.mat'));
        D2 = load(sprintf('%s',path,'/GK_perturb_exp_S2_2023-12-04_15-54_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/GK_perturb_exp_S3_2023-12-13_14-28_results.mat'));
        D3 = load(sprintf('%s',path,'/GK_perturb_exp_S3_2023-12-13_14-28_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/GK_perturb_exp_S4_2023-12-15_11-31_results.mat'));
        D4 = load(sprintf('%s',path,'/GK_perturb_exp_S4_2023-12-15_11-31_dispInfo.mat'));

    elseif subj == 'HP'
        R1 = load(sprintf('%s',path,'/HP_perturb_exp_S1_2023-11-06_16-03_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/HP_perturb_exp_S1_2023-11-06_16-03_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/HP_perturb_exp_S2_2023-11-14_16-08_results.mat'));
        D2 = load(sprintf('%s',path,'/HP_perturb_exp_S2_2023-11-14_16-08_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/HP_perturb_exp_S3_2023-11-15_10-03_results.mat'));
        D3 = load(sprintf('%s',path,'/HP_perturb_exp_S3_2023-11-15_10-03_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/HP_perturb_exp_S4_2023-11-16_10-02_results.mat'));
        D4 = load(sprintf('%s',path,'/HP_perturb_exp_S4_2023-11-16_10-02_dispInfo.mat'));

    elseif subj == 'IJ'
        R1 = load(sprintf('%s',path,'/IJ_perturb_exp_S1_2023-12-15_15-02_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/IJ_perturb_exp_S1_2023-12-15_15-02_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/IJ_perturb_exp_S2_2023-11-13_18-16_results.mat'));
        D2 = load(sprintf('%s',path,'/IJ_perturb_exp_S2_2023-11-13_18-16_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/IJ_perturb_exp_S3_2023-11-20_18-07_results.mat'));
        D3 = load(sprintf('%s',path,'/IJ_perturb_exp_S3_2023-11-20_18-07_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/IJ_perturb_exp_S4_2023-11-27_18-04_results.mat'));
        D4 = load(sprintf('%s',path,'/IJ_perturb_exp_S4_2023-11-27_18-04_dispInfo.mat'));

    elseif subj == 'MP'
        R1 = load(sprintf('%s',path,'/MP_perturb_exp_S1_2023-10-31_14-47_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/MP_perturb_exp_S1_2023-10-31_14-47_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/MP_perturb_exp_S2_2023-11-21_10-00_results.mat'));
        D2 = load(sprintf('%s',path,'/MP_perturb_exp_S2_2023-11-21_10-00_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/MP_perturb_exp_S3_2023-11-27_13-52_results.mat'));
        D3 = load(sprintf('%s',path,'/MP_perturb_exp_S3_2023-11-27_13-52_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/MP_perturb_exp_S4_2023-11-28_10-05_results.mat'));
        D4 = load(sprintf('%s',path,'/MP_perturb_exp_S4_2023-11-28_10-05_dispInfo.mat'));

    elseif subj == 'NA'
        R1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-06_controlresults.mat'));
        %R1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-40_controlresults.mat')); %NEEDS TO BE JOINED WITH ABOVE
        D1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-40_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/NA_perturb_exp_S2_2023-11-13_16-57_results.mat'));
        D2 = load(sprintf('%s',path,'/NA_perturb_exp_S2_2023-11-13_16-57_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/NA_perturb_exp_S3_2023-11-15_17-16_results.mat'));
        D3 = load(sprintf('%s',path,'/NA_perturb_exp_S3_2023-11-15_17-16_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/NA_perturb_exp_S4_2023-11-21_15-50_results.mat'));
        D4 = load(sprintf('%s',path,'/NA_perturb_exp_S4_2023-11-21_15-50_dispInfo.mat'));

    elseif subj == 'PL'
        R1 = load(sprintf('%s',path,'/PL_perturb_exp_S1_2023-11-29_10-55_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/PL_perturb_exp_S1_2023-11-29_10-55_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/PL_perturb_exp_S2_2023-11-14_15-05_results.mat'));
        D2 = load(sprintf('%s',path,'/PL_perturb_exp_S2_2023-11-14_15-05_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/PL_perturb_exp_S3_2023-11-15_11-08_results.mat'));
        D3 = load(sprintf('%s',path,'/PL_perturb_exp_S3_2023-11-15_11-08_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/PL_perturb_exp_S4_2023-11-16_11-17_results.mat'));
        D4 = load(sprintf('%s',path,'/PL_perturb_exp_S4_2023-11-16_11-17_dispInfo.mat'));

    elseif subj == 'PK'
        R1 = load(sprintf('%s',path,'/PK_perturb_exp_S1_2023-12-06_19-11_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/PK_perturb_exp_S1_2023-12-06_19-11_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/PK_perturb_exp_S2_2023-11-29_17-05_results.mat'));
        D2 = load(sprintf('%s',path,'/PK_perturb_exp_S2_2023-11-29_17-05_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/PK_perturb_exp_S3_2023-12-01_14-46_results.mat'));
        D3 = load(sprintf('%s',path,'/PK_perturb_exp_S3_2023-12-01_14-46_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/PK_perturb_exp_S4_2023-12-05_19-06_results.mat'));
        D4 = load(sprintf('%s',path,'/PK_perturb_exp_S4_2023-12-05_19-06_dispInfo.mat'));

    elseif subj == 'SB'
        R1 = load(sprintf('%s',path,'/SB_perturb_exp_S1_2023-12-04_17-11_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/SB_perturb_exp_S1_2023-12-04_17-11_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/SB_perturb_exp_S2_2023-11-27_17-02_results.mat'));
        D2 = load(sprintf('%s',path,'/SB_perturb_exp_S2_2023-11-27_17-02_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/SB_perturb_exp_S3_2023-12-01_13-07_results.mat'));
        D3 = load(sprintf('%s',path,'/SB_perturb_exp_S3_2023-12-01_13-07_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/SB_perturb_exp_S4_2023-12-03_16-22_results.mat'));
        D4 = load(sprintf('%s',path,'/SB_perturb_exp_S4_2023-12-03_16-22_dispInfo.mat'));

    elseif subj == 'SM'
        R1 = load(sprintf('%s',path,'/SM_perturb_exp_S1_2023-11-17_16-07_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/SM_perturb_exp_S1_2023-11-17_16-07_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/SM_perturb_exp_S2_2023-11-20_09-59_results.mat'));
        D2 = load(sprintf('%s',path,'/SM_perturb_exp_S2_2023-11-20_09-59_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/SM_perturb_exp_S3_2023-11-21_15-00_results.mat'));
        D3 = load(sprintf('%s',path,'/SM_perturb_exp_S3_2023-11-21_15-00_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/SM_perturb_exp_S4_2023-11-27_11-58_results.mat'));
        D4 = load(sprintf('%s',path,'/SM_perturb_exp_S4_2023-11-27_11-58_dispInfo.mat'));

    elseif subj == 'VD'
        R1 = load(sprintf('%s',path,'/VD_perturb_exp_S1_2023-12-15_13-47_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/VD_perturb_exp_S1_2023-12-15_13-47_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/VD_perturb_exp_S2_2023-11-29_20-06_results.mat'));
        D2 = load(sprintf('%s',path,'/VD_perturb_exp_S2_2023-11-29_20-06_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/VD_perturb_exp_S3_2023-12-06_17-03_results.mat'));
        D3 = load(sprintf('%s',path,'/VD_perturb_exp_S3_2023-12-06_17-03_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/VD_perturb_exp_S4_2023-12-08_13-01_results.mat'));
        D4 = load(sprintf('%s',path,'/VD_perturb_exp_S4_2023-12-08_13-01_dispInfo.mat'));

    elseif subj == 'RW'
        R1 = load(sprintf('%s',path,'/RW_perturb_exp_S1_2024-02-26_14-10_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/RW_perturb_exp_S1_2024-02-26_14-10_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/RW_perturb_exp_S2_2024-03-01_13-06_results.mat'));
        D2 = load(sprintf('%s',path,'/RW_perturb_exp_S2_2024-03-01_13-06_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/RW_perturb_exp_S3_2024-03-06_11-59_results.mat'));
        D3 = load(sprintf('%s',path,'/RW_perturb_exp_S3_2024-03-06_11-59_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/RW_perturb_exp_S4_2024-03-15_15-59_results.mat'));
        D4 = load(sprintf('%s',path,'/RW_perturb_exp_S4_2024-03-15_15-59_dispInfo.mat'));

    elseif subj == 'SX'
        R1 = load(sprintf('%s',path,'/SX_perturb_exp_S1_2024-03-15_14-54_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/SX_perturb_exp_S1_2024-03-15_14-54_dispInfo.mat'));
        R2 = load(sprintf('%s',path,'/SX_perturb_exp_S2_2024-03-04_14-08_results.mat'));
        D2 = load(sprintf('%s',path,'/SX_perturb_exp_S2_2024-03-04_14-08_dispInfo.mat'));
        R3 = load(sprintf('%s',path,'/SX_perturb_exp_S3_2024-03-06_13-15_results.mat'));
        D3 = load(sprintf('%s',path,'/SX_perturb_exp_S3_2024-03-06_13-15_dispInfo.mat'));
        R4 = load(sprintf('%s',path,'/SX_perturb_exp_S4_2024-03-08_14-52_results.mat'));
        D4 = load(sprintf('%s',path,'/SX_perturb_exp_S4_2024-03-08_14-52_dispInfo.mat'));
    end

    %control exp
    % epAngle1 = R1.contResultsMat.endPtAngle - 90;
    % rpAngle1 = R1.contResultsMat.reportAngle - 90;

    %main exp
    fbAngle = [R2.resultsMat.feedbackAngle; R3.resultsMat.feedbackAngle; R4.resultsMat.feedbackAngle];
    tAngle = [R2.resultsMat.tarAngle'; R3.resultsMat.tarAngle'; R4.resultsMat.tarAngle'];
    eAngle = [R2.resultsMat.endPtAngle; R3.resultsMat.endPtAngle; R4.resultsMat.endPtAngle];
    arcSz = [R2.resultsMat.arcSize'; R3.resultsMat.arcSize'; R4.resultsMat.arcSize'];
    respErr = [R2.resultsMat.respErrorAngle; R3.resultsMat.respErrorAngle; R4.resultsMat.respErrorAngle];

    z = length(respErr)/100;

    feedbackAngle = reshape(fbAngle,[100,z]); %endpoint location out of 360 degrees
    tarAngle = reshape(tAngle,[100,z]); %target location out of 360 degrees
    errAngle = reshape(eAngle,[100,z]); %feedback location out of 360 degrees
    conf = reshape(abs(arcSz),[100 z]);
    errorfb = reshape(respErr,[100 z]);

    feedbackErr = (tarAngle-feedbackAngle).*[-1 1 -1 1 -1 1 -1 1 -1 1 -1 1];
    feedbackErr(feedbackErr>100) = 360-feedbackErr(feedbackErr>100);
    feedbackErr(feedbackErr<-100) = 360+feedbackErr(feedbackErr<-100);
    handAngle =(tarAngle-errAngle).*[-1 1 -1 1 -1 1 -1 1 -1 1 -1 1];
    handAngle(handAngle>100) = 360-handAngle(handAngle>100);
    handAngle(handAngle<-100) = 360+handAngle(handAngle<-100);

    %taking the means and SD of raw data
    confmean = mean(conf,2); %angle away from target in one direction
    confsem = std(conf')/sqrt(length(conf));
    handAnglemean = mean(handAngle,2); %hand angle away from target
    handAnglesem = std(handAngle')/sqrt(length(handAngle));
    feedbackErrmean = mean(feedbackErr,2); %feedback error away from target
    feedbackErrsem = std(feedbackErr')/sqrt(length(feedbackErr));

    if plot0 == 1
        %plotting raw trials
        figure; hold on
        plot(feedbackErr(:))
        plot(conf(:))
        yline(0,'HandleVisibility','off');
        xline(100:100:1100,'HandleVisibility','off');
        ylabel('direction degrees')
        xlabel('trial')
        title('raw trials before shift')
        legend('Feedback Angle','Confidence Angle')
    end
    if plot3 == 1
        %Plotting means across blocks
        figure; hold on
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
        %yline(-20,'--','HandleVisibility','off');
        title('average block before shift')
        legend('Feedback Angle','Confidence Angle','location','best')
        ylabel('direction (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
    end
    %% Adjusting for learning rates

    %correction for learning error
    fbPtb = feedbackErr(20:70,:);
    x = 1:612;
    c = polyfit(x,fbPtb(:),2);
    y_est = polyval(c,x);
    y_est = reshape(y_est,[51,12]);
    feedbackErr(20:70,:) = feedbackErr(20:70,:)-y_est;

    %correction for confidence learning
    confPtb = conf(20:70,:);
    confPtb(confPtb<1) = 1;
    x = 1:612;
    yPrime = log(confPtb(:));
    pPrime = polyfit(x,yPrime,1);
    aPrime = pPrime(2); bPrime = pPrime(1);
    y_est = exp(aPrime)*exp(x*bPrime);
    y_est = reshape(y_est,[51,12]);
    conf(20:70,:) = conf(20:70,:)-(y_est- mean(mean(conf(1:19,:))));

    %taking means and SD of adjusted data
    confmean = mean(conf,2); %angle away from target in one direction
    confsem = std(conf')/sqrt(length(conf));
    handAnglemean = mean(handAngle,2); %hand angle away from target
    handAnglesem = std(handAngle')/sqrt(length(handAngle));
    feedbackErrmean = mean(feedbackErr,2); %feedback error away from target
    feedbackErrsem = std(feedbackErr')/sqrt(length(feedbackErr));

    if plot2 == 1
        %plotting raw trials
        figure; hold on
        plot(feedbackErr(:))
        plot(conf(:))
        yline(0,'HandleVisibility','off');
        xline(100:100:1100,'HandleVisibility','off');
        ylabel('direction degrees')
        xlabel('trial')
        title('raw trials, adjusted')
        legend('Feedback Angle','Confidence Angle')
    end
    if plot3 == 1
        %Plotting means across blocks
        figure; hold on
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
        %yline(-20,'--','HandleVisibility','off');
        title('average block, adjusted')
        legend('Feedback Angle','Confidence Angle','location','best')
        ylabel('direction (degrees)')
        xlabel('trial')
        set(gca, 'TickDir', 'out', 'FontSize', 18)
        set(gcf,'color','w')
    end
    if plot4 == 1
        temp = conf(20:70,:);
        yPrime = log(temp(:));
        pPrime = polyfit(x,yPrime,1);
        aPrime = pPrime(2); bPrime = pPrime(1);
        y_est2 = exp(aPrime)*exp(x*bPrime);
        
        figure; hold on
        plot(confPtb(:))
        plot(temp(:))
        plot(x,y_est(:),'LineWidth',2)
        plot(x,y_est2,'LineWidth',2)
        xline(51:51:612,'--');

        %yline(0,'HandleVisibility','off');
        %xline(100:100:1100,'HandleVisibility','off');
        ylabel('direction degrees')
        xlabel('trial')
        title('raw trials, adjusted')
        %legend('Feedback Angle','Confidence Angle')
    end
end