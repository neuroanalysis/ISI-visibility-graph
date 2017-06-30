% ISIs poisson 1
%
% Pérez-Ortega Jesús E.
% Sep-2016
function ISI = ISI_poisson_1(min_isi, mean_isi, total_time)
    lambda=mean_isi/min_isi;
    ISI=[];
    i=1;
    while(sum(ISI)<total_time)
        isi=poissrnd(lambda)*min_isi;
        ISI(i)=isi;
        i=i+1;
    end
end