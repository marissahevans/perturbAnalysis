%PARPOOL VERSION OF MODEL FITS USING BADS - PERTERBATION PROJECT

numTrial = 100;      %number of trials
numBlocks = 12;
numIts = 20;
numSims = 1000;

ptb = zeros(1,numTrial);
ptb(20:70) = 20;
arcSize = 0:45; %possible arc angles
r = [10,linspace(10,0,length(2:length(arcSize)))];
parpool = 1;


%subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'},{'IJ'},{'AN'},{'SB'},{'VD'},{'GK'},{'PK'},{'RW'},{'SX'}];


subj = 'BY';
load(sprintf('%s_LSoutput.mat',subj));


parfor gg = 1:numIts %number of full simulation sets
    x1 = zeros(numBlocks,4,numIts);
    ls1 = zeros(numIts, numBlocks);

    x2 = zeros(numBlocks,5,numIts);
    ls2 = zeros(numIts, numBlocks);

    x3 = zeros(numBlocks,6,numIts);
    ls3 = zeros(numIts, numBlocks);

    x4 = zeros(numBlocks,6,numIts);
    ls4 = zeros(numIts, numBlocks);

    cvLS1 = zeros(numIts,numBlocks);
    cvLS2 = zeros(numIts,numBlocks);
    cvLS3 = zeros(numIts,numBlocks);
    cvLS4 = zeros(numIts,numBlocks);

    for cv = 1:numBlocks
        samp = logical(zeros(1,numBlocks));
        samp(cv) = 1;
        testBlockfeed = feedbackErr(:,samp);
        feedbackErrmean = mean(feedbackErr(:,~samp),2);

        testBlockconf = conf(:,samp);
        confmean = mean(conf(:,~samp),2);


        %model 1
        sigma_m = minParam{1}(1);
        alpha_m = minParam{1}(3);
        sigma_aim = minParam{1}(6);
        alpha_mf = minParam{1}(7);

        x01 = [sigma_m,alpha_m,sigma_aim,alpha_mf];

        lb1 = [.1 0 .1 0];
        ub1 = [20 1 20 1];

        fun1 = @(var1) pterbModel1(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var1(1),var1(2),var1(3),var1(4));
        [x1(cv,:,gg), ls1(gg,cv)] = bads(fun1,x01,lb1,ub1)
        [cvLS1(gg,cv)]= pterbModel1(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x1(cv,1),x1(cv,2),x1(cv,3),x1(cv,4));

        %model 2
        sigma_m = minParam{2}(1);
        sigma_p = minParam{2}(2);
        alpha_m = minParam{2}(3);
        alpha_p = minParam{2}(4);
        sigma_aim = minParam{2}(6);

        x02 = [sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim];

        lb2 = [.1 .1 0 0 .1];
        ub2 = [20 20 1 1 20];

        fun2 = @(var2) pterbModel2(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var2(1),var2(2),var2(3),var2(4),var2(5));
        [x2(cv,:,gg), ls2(gg,cv)] = bads(fun2,x02,lb2,ub2)
        [cvLS2(gg,cv)]= pterbModel2(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x2(cv,1),x2(cv,2),x2(cv,3),x2(cv,4),x2(cv,5));

        %model 3
        sigma_m = minParam{3}(1);
        sigma_p = minParam{3}(2);
        alpha_m = minParam{3}(3);
        alpha_p = minParam{3}(4);
        sigma_aim = minParam{3}(6);
        alpha_mf = minParam{3}(7);

        x03 = [sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim,alpha_mf];

        lb3 = [.1 .1 0 0 .1 0];
        ub3 = [20 20 1 1 20 1];

        fun3 = @(var3) pterbModel3(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var3(1),var3(2),var3(3),var3(4),var3(5),var3(6));
        [x3(cv,:,gg), ls3(gg,cv)] = bads(fun3,x03,lb3,ub3)
        [cvLS3(gg,cv)]= pterbModel3(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x3(cv,1),x3(cv,2),x3(cv,3),x3(cv,4),x3(cv,5),x3(cv,6));

        %model 4
        sigma_m = minParam{4}(1);
        sigma_p = minParam{4}(2);
        alpha_m = minParam{4}(3);
        alpha_p = minParam{4}(4);
        sigma_aim = minParam{4}(6);
        alpha_mf = minParam{4}(7);

        x04 = [sigma_m,sigma_p,alpha_m,alpha_p,sigma_aim,alpha_mf];

        lb4 = [.1 .1 0 0 .1 0];
        ub4 = [20 20 1 1 20 1];

        fun4 = @(var4) pterbModel4(feedbackErrmean,confmean,numTrial,numSims,r,ptb,arcSize,var4(1),var4(2),var4(3),var4(4),var4(5),var4(6));
        [x4(cv,:,gg), ls4(gg,cv)] = bads(fun4,x04,lb4,ub4)
        [cvLS4(gg,cv)]= pterbModel4(testBlockfeed,testBlockconf,numTrial,numSims,r,ptb,arcSize,x4(cv,1),x4(cv,2),x4(cv,3),x4(cv,4),x4(cv,5),x4(cv,6));
    end
    cvAll = [sum(cvLS1(gg,:)) sum(cvLS2(gg,:)) sum(cvLS3(gg,:)) sum(cvLS4(gg,:))];
    cvmin = min(cvAll);
    cvDiff(gg,:) =  cvAll - cvmin;
    winner(gg) = find(cvDiff(gg,:)==0);
end



filename = sprintf('%s_fMinOutput.mat',subj);
save(filename, 'x1','x2','x3','x4','cvLS1','cvLS2','cvLS3','cvLS4','cvDiff','winner');






