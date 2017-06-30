% Plot visibility graph from ISI
%
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function ISI = ISI_smooth_exp(ISI, bin, smooth)
    if(smooth)
        ISIsmooth=ones(1,length(ISI));
        
        i=bin;
        idx=find(ISI>i);
        ISIsmooth(idx)=ISIsmooth(idx)+1;
        
        i=bin*10;
        idx=find(ISI>i);
        ISIsmooth(idx)=ISIsmooth(idx)+1;
        
        i=bin*100;
        idx=find(ISI>i);
        ISIsmooth(idx)=ISIsmooth(idx)+1;
        
        ISI=ISIsmooth;
    end
end