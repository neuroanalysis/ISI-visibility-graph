% ISI data for "Visibility graph" 3
% 
% To: Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

% 90 minimum spikes of all experiments 
% 100 minimum seconds of all experiments (CTR_5 y CTR_8 less than 20s)

N=90; type='spikes'; % limited
smooth=true; bin=0.1; % smooth
total_time=200; % simulated data

% ENTROPY

%
% Regular spiking
isi=0.05;
ISI=ISI_regular(isi,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin,smooth);
A = Visibility_ISI(ISI);
H_REG = Entropy_Network(A,['a. Regular (isi=' num2str(isi) '[s])']);

% Regular spiking with burst
isi=0.01; ibi=1; burst_size=10;
ISI = ISI_regular_burst(isi,ibi,burst_size,total_time)';
ISI=ISI_limited_by(ISI,N,type);
ISI=ISI_smooth(ISI, bin, smooth);
A = Visibility_ISI(ISI);
H_BUR = Entropy_Network(A,['b. Regular bursting (isi=' num2str(isi) ' ibi=' num2str(ibi) ' [s])']);

for i=1:13
    % Irregular spiking - 1 poisson
    min_isi=0.01; mean_isi=0.1;
    ISI=ISI_poisson_1(min_isi,mean_isi,total_time);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    A = Visibility_ISI(ISI);
    H_PO1(i) = Entropy_Network(A,['c' num2str(i) '. Poisson (min=' num2str(min_isi) ' mean=' num2str(mean_isi) ' [s])']);
end
close all

for i=1:13
    % Irregular spiking - 2 poisson
    min_isi_1=0.01;mean_isi_1=0.1;percentage_1=0.3;min_isi_2=0.1;mean_isi_2=0.5;
    ISI = ISI_poisson_2(min_isi_1,mean_isi_1,percentage_1,min_isi_2,mean_isi_2,total_time);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    A = Visibility_ISI(ISI);
    H_PO2(i) = Entropy_Network(A,['d' num2str(i) '. Poisson bursting: 1 (min_1=' num2str(min_isi_1) ' mean_1=' num2str(mean_isi_1) ' [s] - ' num2str(percentage_1*100) '%)'...
        '; 2 (min_2=' num2str(min_isi_2) ' mean_2=' num2str(mean_isi_2) ' [s] - ' num2str((1-percentage_1)*100) '%) ']);
end
close all 
%}
%{
% Real data
load ISI_All;

% CTR
for i=1:13
    ISI=eval(['ISI_CTR_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    A = Visibility_ISI(ISI);
    H_CTR(i) = Entropy_Network(A,['e' num2str(i) '. Control']);
end
close all 

% PRK
for i=1:10
    ISI=eval(['ISI_PRK_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    A = Visibility_ISI(ISI);
    H_PRK(i) = Entropy_Network(A,['f' num2str(i) '. 6-OHDA']);
end
close all 

% ANT
for i=1:12
    ISI=eval(['ISI_ANT_' num2str(i)]);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth(ISI, bin, smooth);
    A = Visibility_ISI(ISI);
    H_ANT(i) = Entropy_Network(A,['g' num2str(i) '. SCH23390+sulpiride']);
end
close all 

figure(1)
plot(H_REG,'or'); hold on
plot(H_BUR,'og')
plot(H_PO1,'b')
plot(H_PO2,'c')
plot(H_CTR,'m')
plot(H_PRK,'y')
plot(H_ANT,'k')
title('Entropy of Degree Distribution')
xlabel('# experiment')
ylabel('# bits')
legend({'Regular','Bursting','Poisson 1','Poisson 2','Control','Parkinsonian','Antagonists'})
%}