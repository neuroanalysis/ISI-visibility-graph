% ISI data for "Visibility graph"
% 
% To: Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

% 90 minimum spikes of all experiments 
% 100 minimum seconds of all experiments (CTR_5 y CTR_8 less than 20s)

N=90; type='spikes'; % limited
smooth=true; bin=0.1; % smooth
total_time=5000; % simulated data

%{
% Regular spiking
isi=0.1;
ISI=ISI_regular(isi,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth_exp(ISI, bin,smooth);
REG = Plot_Visibility(['a. Regular (isi=' num2str(isi) '[s])'],ISI);

%}

%{
% Regular spiking with burst
isi=0.5; ibi=10; burst_size=14;
ISI = ISI_regular_burst(isi,ibi,burst_size,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
BUR = Plot_Visibility(['b. Regular bursting (isi=' num2str(isi) ' ibi=' num2str(ibi) ' [s])'],ISI);

%
%{
for i=1:1
    % Irregular spiking - 1 poisson
    min_isi=1; mean_isi=5;
    ISI=ISI_poisson_1(min_isi,mean_isi,total_time);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    %close all
end
%}
%{
for i=1:1
    % Irregular spiking - 2 poisson
    min_isi_1=0.01;mean_isi_1=0.5;percentage_1=0.5;min_isi_2=.5;mean_isi_2=5;
    ISI = ISI_poisson_2(min_isi_1,mean_isi_1,percentage_1,min_isi_2,mean_isi_2,total_time);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    PO2(i) = Plot_Visibility(['d' num2str(i) '. Poisson bursting: 1 (min_1=' num2str(min_isi_1) ' mean_1=' num2str(mean_isi_1) ' [s] - ' num2str(percentage_1*100) '%)'...
        '; 2 (min_2=' num2str(min_isi_2) ' mean_2=' num2str(mean_isi_2) ' [s] - ' num2str((1-percentage_1)*100) '%) '],ISI);
    %close all
end

%}

%}
% Real data
load ISI_All;
%{
% CTR
for i=1:13
    ISI=eval(['ISI_CTR_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    CTR(i) = Plot_Visibility(['e' num2str(i) '. Control'],ISI);
    
    %close all
end
%}
%{
% PRK
for i=1:10
    ISI=eval(['ISI_PRK_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    PRK(i) = Plot_Visibility(['f' num2str(i) '. 6-OHDA'],ISI);
    %close all
end
%}
%
% ANT
for i=1:12
    ISI=eval(['ISI_ANT_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    ANT(i) = Plot_Visibility(['g' num2str(i) '. SCH23390+sulpiride'],ISI);
    %close all
end
%}