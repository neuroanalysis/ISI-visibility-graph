% ISIs regular with burst
%
% Pérez-Ortega Jesús E.
% Sep-2016
function ISI = ISI_regular_burst(isi,ibi,burst_size,total_time)

    ISI=isi*ones(round(total_time/isi),1);
    
    N=length(ISI);
    
    for i=burst_size:burst_size:N
        ISI(i)=ibi;
    end
    
    if(sum(ISI)>total_time)
        ISIsum=cumsum(ISI);
        id=find(ISIsum>total_time)-1;
        ISI=ISI(1:id);
    end
end