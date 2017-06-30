% Spikes from ISI
% 
% To: Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

N=90; type='spikes'; % limited
smooth=true; bin=0.2; % smooth

% Real data
load ISI_All;
load SomeResults;

[a idx]=sort(L_CTR,'descend');

%
% CTR
figure(100);clf
for i=1:13
    subplot(13,1,i)
    name=['ISI_CTR_' num2str(idx(i))];
    ISI=eval(name);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    Get_Spikes_From_ISI(ISI);
    ylabel(num2str(idx(i)))
    set(gca,'xtick',[])
end

figure(200);clf
for i=1:13
    subplot(13,1,i)
    name=['ISI_CTR_' num2str(idx(i))];
    ISI=eval(name);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    plot(ISI);
    ylabel(num2str(idx(i)))
    set(gca,'xtick',[])
    %ylim([0 10])
end




[a idx]=sort(L_ANT,'descend');

%
% ANT
figure(101);clf
for i=1:12
    subplot(13,1,i)
    name=['ISI_ANT_' num2str(idx(i))];
    ISI=eval(name);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    Get_Spikes_From_ISI(ISI);
    ylabel(num2str(idx(i)))
    set(gca,'xtick',[])
end

figure(201);clf
for i=1:12
    subplot(13,1,i)
    name=['ISI_ANT_' num2str(idx(i))];
    ISI=eval(name);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    plot(ISI);
    ylabel(num2str(idx(i)))
    set(gca,'xtick',[])
    %ylim([0 10])
end





[a idx]=sort(L_PRK,'descend');

%
% PRK
figure(102);clf
for i=1:10
    subplot(13,1,i)
    name=['ISI_PRK_' num2str(idx(i))];
    ISI=eval(name);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    Get_Spikes_From_ISI(ISI);
    ylabel(num2str(idx(i)))
    set(gca,'xtick',[])
end

figure(202);clf
for i=1:10
    subplot(13,1,i)
    name=['ISI_PRK_' num2str(idx(i))];
    ISI=eval(name);
    ISI=ISI_limited_by(ISI,N,type);
    ISI=ISI_smooth_exp(ISI, bin, smooth);
    plot(ISI);
    ylabel(num2str(idx(i)))
    set(gca,'xtick',[])
    %ylim([0 10])
end



figure(2);clf
semilogy(C_CTR,L_CTR,'bx');hold on
semilogy(C_ANT,L_ANT,'gx')
semilogy(C_PRK,L_PRK,'rx')


