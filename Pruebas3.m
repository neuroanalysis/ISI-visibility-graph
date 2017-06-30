% Pruebas "Visibility graph" 3
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

% 90 minimum spikes of all experiments 
% 100 minimum seconds of all experiments (CTR_5 y CTR_8 less than 20s)

N=90; type='spikes'; % limited
smooth=true; bin=0.1; % smooth
total_time=200; % simulated data

% Regular spiking
ISI=ISI_regular(0.05,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin,smooth);
Output = Plot_Visibility('a. Regular',ISI);
% Regular spiking with burst
%
%isi=0.130; ibi=8; burst_size=5; % real 6-HODA
%isi=0.130; ibi=8; burst_size=5; % real Antagonists
%isi=0.027; ibi=15; burst_size=5; % real Control
isi=0.01; ibi=1; burst_size=10;
ISI = ISI_regular_burst(isi,ibi,burst_size,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility('b. Regular bursting',ISI);

% Irregular spiking - random (uniform)
min_isi=0.01; max_isi=0.2;
ISI=ISI_random(min_isi,max_isi,total_time);
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility(['c. Random uniform (' num2str(min_isi) ' - ' num2str(max_isi) ' [s])'],ISI);

% Irregular spiking - 1 poisson
min_isi=0.01; mean_isi=0.1;
ISI=ISI_poisson_1(min_isi,mean_isi,total_time);
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility(['d. Poisson (min=' num2str(min_isi) ' mean=' num2str(mean_isi) ' [s])'],ISI);

% Irregular spiking - 2 poisson
min_isi_1=0.01;mean_isi_1=0.1;percentage_1=0.3;min_isi_2=0.1;mean_isi_2=0.5;
ISI = ISI_poisson_2(min_isi_1,mean_isi_1,percentage_1,min_isi_2,mean_isi_2,total_time);
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility(['e. Poisson 1 (min_1=' num2str(min_isi_1) ' mean_1=' num2str(mean_isi_1) ' [s] - ' num2str(percentage_1*100) '%) '...
    'Poisson 2 (min_2=' num2str(min_isi_2) ' mean_2=' num2str(mean_isi_2) ' [s] - ' num2str((1-percentage_1)*100) '%) '],ISI);

% Real data
%
load ISI_All;

% CTR
ISI=ISI_CTR_1;
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility('f. Control',ISI);
% PRK
ISI=ISI_PRK_1;
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility('g. 6-OHDA',ISI);
% ANT
ISI=ISI_ANT_1;
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
Output = Plot_Visibility('h. SCH23390+sulpiride',ISI);
%}
