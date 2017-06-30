% Plot visibility graph from ISI
%
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function ISI = ISI_smooth(ISI, bin, smooth)
    if(smooth)
        max_ISI=max(ISI);
        ISIsmooth=ones(1,length(ISI));
        for i=bin:bin:max_ISI
            idx=find(ISI>i);
            ISIsmooth(idx)=ISIsmooth(idx)+1;
        end
        ISI=ISIsmooth;
    end
end