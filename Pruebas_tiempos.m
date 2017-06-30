% Pruebas "Visibility graph" 5
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

load ISI_All;


% Minimum times
times=[];

% CTR
for i=1:13
    ISI=eval(['ISI_CTR_' num2str(i)]);
    times1(i)=sum(ISI);
end
    
% ANT
for i=1:9
    ISI=eval(['ISI_ANT_' num2str(i)]);
    times2(i)=sum(ISI);
end

% PRK
for i=1:9
    ISI=eval(['ISI_PRK_' num2str(i)]);
    times3(i)=sum(ISI);
end
times=[times1 times2 times3];
figure(1);clf
plot(times,'o-r')
disp(min(times))
disp(max(times))

% min 100s (only 2 CTR are less than 20s CTR_5 y CTR_8)