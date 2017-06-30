% Plot Network
%
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function ISI=ISI_limited_by(ISI,N,type)
    
    switch(type)
        case 'spikes'
            if (length(ISI)>N)
                ISI=ISI(1:N);
            end
        case 'seconds'
            if (sum(ISI)>N)
                ISIsum=cumsum(ISI);
                id=find(ISIsum>N,1);
                ISI=ISI(1:id);
            end
    end
end