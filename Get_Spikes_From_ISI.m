% Spikes from ISI
% 
% To: Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function Get_Spikes_From_ISI(ISI)

    % Get spikes from ISI
    time=repmat(cumsum(ISI)',1,2);
    spikes_1=zeros(length(ISI),1);
    spikes_2=ones(length(ISI),1);
    spikes=[spikes_1 spikes_2];
    
    % plot
    plot(time',spikes','k')
    set(gca,'ytick',[])
end