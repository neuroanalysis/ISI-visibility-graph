% ISIs random
%
% Pérez-Ortega Jesús E.
% Sep-2016
function ISI = ISI_random(min_isi, max_isi, total_time)
    range_isi=round(max_isi/min_isi);
    ISI=[];
    i=1;
    while(sum(ISI)<total_time)
        isi=randi([1 range_isi])*min_isi;
        ISI(i)=isi;
        i=i+1;
    end
end