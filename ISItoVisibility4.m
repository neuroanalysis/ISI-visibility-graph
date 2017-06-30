% ISI data for "Visibility graph" 4
% 
% To: Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

% 90 minimum spikes of all experiments 
% 100 minimum seconds of all experiments (CTR_5 y CTR_8 less than 20s)

N=50; type='seconds'; % limited
smooth=false; bin=0.1; % smooth
total_time=200; % simulated data
bin_net=10; % size of window

%{
% Regular spiking
isi=0.05;
ISI=ISI_regular(isi,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin,smooth);
REG = Plot_Visibility_bin(['a. Regular (isi=' num2str(isi) '[s])'],ISI,bin_net);
save REG
clear REG

% Regular spiking with burst
isi=0.01; ibi=1; burst_size=10;
ISI = ISI_regular_burst(isi,ibi,burst_size,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
BUR = Plot_Visibility_bin(['b. Regular bursting (isi=' num2str(isi) ' ibi=' num2str(ibi) ' [s])'],ISI,bin_net);
save BUR
clear BUR

for i=1:13
    % Irregular spiking - 1 poisson
    min_isi=0.01; mean_isi=0.1;
    ISI=ISI_poisson_1(min_isi,mean_isi,total_time);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    PO1(i) = Plot_Visibility_bin(['c' num2str(i) '. Poisson (min=' num2str(min_isi) ' mean=' num2str(mean_isi) ' [s])'],ISI,bin_net);
    close all
end
save PO1
clear PO1

for i=1:13
    % Irregular spiking - 2 poisson
    min_isi_1=0.01;mean_isi_1=0.1;percentage_1=0.3;min_isi_2=0.1;mean_isi_2=0.5;
    ISI = ISI_poisson_2(min_isi_1,mean_isi_1,percentage_1,min_isi_2,mean_isi_2,total_time);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    PO2(i) = Plot_Visibility_bin(['d' num2str(i) '. Poisson bursting: 1 (min_1=' num2str(min_isi_1) ' mean_1=' num2str(mean_isi_1) ' [s] - ' num2str(percentage_1*100) '%)'...
        '; 2 (min_2=' num2str(min_isi_2) ' mean_2=' num2str(mean_isi_2) ' [s] - ' num2str((1-percentage_1)*100) '%) '],ISI,bin_net);
    close all
end
save PO2
clear PO2
%}

% Real data
load ISI_All;
%{bin10

% CTR
for i=1:13
    ISI=eval(['ISI_CTR_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    CTR(i) = Plot_Visibility_bin(['e' num2str(i) '. Control'],ISI,bin_net);
    close all
end
save CTR
clear CTR

% PRK
for i=1:10
    ISI=eval(['ISI_PRK_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    PRK(i) = Plot_Visibility_bin(['f' num2str(i) '. 6-OHDA'],ISI,bin_net);
    close all
end
save PRK
clear PRK
%}
% ANT
for i=6:12
    ISI=eval(['ISI_ANT_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    ANT(i) = Plot_Visibility_bin(['g' num2str(i) '. SCH23390+sulpiride'],ISI,bin_net);
    close all
end
save ANT
clear ANT