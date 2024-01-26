figure
subjAll = [{'BY'},{'FM'},{'HP'},{'MP'},{'NA'},{'PL'},{'SM'},{'ET'}]; %,{'IJ'},{'AMN'},{'SB'}];
for ss = 1:length(subjAll)
    subj = subjAll{ss};
    path = sprintf('/Users/mhe229/Documents/Landy Lab/perturbExperiment/data_perturb/%s',subj);

    if subj == 'BY'
        R1 = load(sprintf('%s',path,'/BY_perturb_exp_S1_2023-11-15_12-29_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/BY_perturb_exp_S1_2023-11-15_12-29_dispInfo.mat'));

    elseif subj == 'ET'
        R1 = load(sprintf('%s',path,'/ET_perturb_exp_S1_2023-11-02_11-00_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/ET_perturb_exp_S1_2023-11-02_11-00_dispInfo.mat'));

    elseif subj == 'FM'
        R1 = load(sprintf('%s',path,'/FM_perturb_exp_S1_2023-11-02_16-54_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/FM_perturb_exp_S1_2023-11-02_16-54_dispInfo.mat'));

    elseif subj == 'HP'
        R1 = load(sprintf('%s',path,'/HP_perturb_exp_S1_2023-11-06_16-03_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/HP_perturb_exp_S1_2023-11-06_16-03_dispInfo.mat'));

    elseif subj == 'MP'
        R1 = load(sprintf('%s',path,'/MP_perturb_exp_S1_2023-10-31_14-47_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/MP_perturb_exp_S1_2023-10-31_14-47_dispInfo.mat'));

    elseif subj == 'NA'
        R1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-06_controlresults.mat'));
        R11 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-40_controlresults.mat')); %NEEDS TO BE JOINED WITH ABOVE
        D1 = load(sprintf('%s',path,'/NA_perturb_exp_S1_2023-11-27_15-40_dispInfo.mat'));

    elseif subj == 'PL'
        R1 = load(sprintf('%s',path,'/PL_perturb_exp_S1_2023-11-29_10-55_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/PL_perturb_exp_S1_2023-11-29_10-55_dispInfo.mat'));

    elseif subj == 'SM'
        R1 = load(sprintf('%s',path,'/SM_perturb_exp_S1_2023-11-17_16-07_controlresults.mat'));
        D1 = load(sprintf('%s',path,'/SM_perturb_exp_S1_2023-11-17_16-07_dispInfo.mat'));


    end

    if subj == 'NA'
        epAngle1 = [R1.contResultsMat.endPtAngle - 90,R11.contResultsMat.endPtAngle - 90 ];
        rpAngle1 = [R1.contResultsMat.reportAngle - 90, R11.contResultsMat.reportAngle - 90];
    else
        epAngle1 = R1.contResultsMat.endPtAngle - 90;
        rpAngle1 = R1.contResultsMat.reportAngle - 90;
    end

    p_vec = .1:.1:40;      % vector of possible proprioceptive noise values
    m_vec = .1:.1:10;      % vector of possible motor noise values
    N = length(epAngle1);

    % Simultaneously estimate sigma_m and sigma_p by ML

    LL=zeros(length(m_vec),length(p_vec));
    LLigivene=zeros(length(m_vec),length(p_vec));
    LLe=zeros(length(m_vec),1);

    for vv = 1:length(m_vec)        %loop over all sigma_m options
        RmTemp = 1/m_vec(vv)^2;

        % log likelihood of sigma_m given target and endpoint:
        LLe(vv) = -N*log(2*pi) - 2*N*log(m_vec(vv)) - (sum(epAngle1.^2)/(2*m_vec(vv)^2));
        for jj = 1:length(p_vec)    %loop over all sigma_p options
            RpTemp = 1/p_vec(jj)^2;
            meanigivene = (RpTemp/(RpTemp+RmTemp))*epAngle1 + ...
                (RmTemp/(RpTemp+RmTemp))*0;
            SDigivene = (RpTemp/(RpTemp+RmTemp))*p_vec(jj);

            % log likelihood of sigma_p given sensed location and endpoint:
            LLigivene(vv,jj) = -N*log(2*pi) - 2*N*log(SDigivene) - (sum((rpAngle1-meanigivene).^2)/(2*SDigivene^2));

            % log likelihood of the sigma_p/sigma_m pair:
            LL(vv,jj) = LLe(vv) + LLigivene(vv,jj);
        end
    end

    % treat LL like a log posterior (i.e., treat prior as flat over the grid)
    % and calculate marginals. First add a constant to all LL values so that
    % the maximum is one (to minimize underflows) and normalize afterward.

    NormPost = exp(LL - max(LL(:)));

    %Motor Error Marginal
    mmarg = sum(NormPost,2);
    mmarg = mmarg/sum(mmarg);
    sigMmarg(ss) = m_vec(find(mmarg == max(mmarg)));

    %Proprioception Marginal
    pmarg = sum(NormPost,1);
    pmarg = pmarg/sum(pmarg);
    sigPmarg(ss) = p_vec(find(pmarg == max(pmarg)));

    subplot(2,4,ss)
    scatter(epAngle1,rpAngle1)
    xlim([-40 40])
    ylim([-20 20])

end


sigMmarg
sigPmarg