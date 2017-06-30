% ISIs poisson 2
%
% Pérez-Ortega Jesús E.
% Sep-2016
function ISI = ISI_poisson_2(min_isi_1,mean_isi_1,percentage_1,min_isi_2,mean_isi_2,total_time)

    ISI=[];
    i=1;

    % first poisson
    lambda=mean_isi_1/min_isi_1;
    while(sum(ISI)<(total_time*percentage_1))
        isi=poissrnd(lambda)*min_isi_1;
        ISI(i)=isi;
        i=i+1;
    end

    % second poisson
    lambda=mean_isi_2/min_isi_2;
    while(sum(ISI)<total_time)
        isi=poissrnd(lambda)*min_isi_2;
        ISI(i)=isi;
        i=i+1;
    end

    % permuted
    ISI(randperm(length(ISI)))=ISI;
end