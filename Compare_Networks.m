% Compare network properties
%
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

load ALL_H_log

G={'CTR','CTR','CTR','CTR','CTR','CTR','CTR','CTR','CTR','CTR','CTR','CTR','CTR',...
   'ANT','ANT','ANT','ANT','ANT','ANT','ANT','ANT','ANT','ANT','ANT','ANT',...
   'PRK','PRK','PRK','PRK','PRK','PRK','PRK','PRK','PRK','PRK'};
colors=[0 0 0.5; 0 0.5 0; 0.5 0 0];

%
% L
for i=1:13
    L_CTR(i)=CTR(i).L;
end
for i=1:12
    L_ANT(i)=ANT(i).L;
end
for i=1:10
    L_PRK(i)=PRK(i).L;
end
L=[L_CTR L_ANT L_PRK];
figure(1);clf
plot(ones(1,13),L_CTR,'xb'); hold on
plot(ones(1,12)*2,L_ANT,'xg')
plot(ones(1,10)*3,L_PRK,'xr')

%
boxplot(L,G,'Colors',colors);
p_ca=ranksum(L_CTR,L_ANT);
p_cp=ranksum(L_CTR,L_PRK);
p_ap=ranksum(L_ANT,L_PRK);
ylabel('L - characteristic path length')
title(['P_CA=' num2str(p_ca) 'P_CP=' num2str(p_cp) 'P_AP=' num2str(p_ap)])
%}

%
% C
for i=1:13
    C_CTR(i)=CTR(i).C;
end
C_CTR=C_CTR()
for i=1:12
    C_ANT(i)=ANT(i).C;
end
for i=1:10
    C_PRK(i)=PRK(i).C;
end
C=[C_CTR C_ANT C_PRK];
figure(2);clf
plot(ones(1,13),C_CTR,'xb'); hold on
plot(ones(1,12)*2,C_ANT,'xg')
plot(ones(1,10)*3,C_PRK,'xr')
boxplot(C,G,'Colors',colors);
p_ca=ranksum(C_CTR,C_ANT);
p_cp=ranksum(C_CTR,C_PRK);
p_ap=ranksum(C_ANT,C_PRK);
ylabel('C - clustering coefficient')
title(['P_CA=' num2str(p_ca) 'P_CP=' num2str(p_cp) 'P_AP=' num2str(p_ap)])

% rho
for i=1:13
    R_CTR(i)=CTR(i).Rho;
end
for i=1:12
    R_ANT(i)=ANT(i).Rho;
end
for i=1:10
    R_PRK(i)=PRK(i).Rho;
end
Rho=[R_CTR R_ANT R_PRK];
figure(3);clf
plot(ones(1,13),R_CTR,'xb'); hold on
plot(ones(1,12)*2,R_ANT,'xg')
plot(ones(1,10)*3,R_PRK,'xr')
boxplot(Rho,G,'Colors',colors);
p_ca=ranksum(R_CTR,R_ANT);
p_cp=ranksum(R_CTR,R_PRK);
p_ap=ranksum(R_ANT,R_PRK);
ylabel('Density')
title(['P_CA=' num2str(p_ca) 'P_CP=' num2str(p_cp) 'P_AP=' num2str(p_ap)])
%}

%{
% Same that rho
% <k>
N=90;%spikes
for i=1:13
    K_CTR(i)=CTR(i).K/N;
end
for i=1:12
    K_ANT(i)=ANT(i).K/N;
end
for i=1:10
    K_PRK(i)=PRK(i).K/N;
end
K=[K_CTR K_ANT K_PRK];
figure(4);clf
plot(ones(1,13),K_CTR,'xb'); hold on
plot(ones(1,12)*2,K_ANT,'xg')
plot(ones(1,10)*3,K_PRK,'xr')
boxplot(K,G,'Colors',colors);
p_ca=ranksum(K_CTR,K_ANT);
p_cp=ranksum(K_CTR,K_PRK);
p_ap=ranksum(K_ANT,K_PRK);
ylabel('<k>')
title(['P_CA=' num2str(p_ca) 'P_CP=' num2str(p_cp) 'P_AP=' num2str(p_ap)])
%}
