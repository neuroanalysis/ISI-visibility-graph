% Pruebas

% PNVG Cartoon for Figure 7

times=[1 2 3 4 5 6 7 8;...
       1 2 3 4 5 6 7 8];
ISIs=[0 0 0 0 0 0 0 0;...
      3 4 2.5 8 5 4 7.5 3];

figure('Position',[0 0 800 150]);clf;
plot(times, ISIs,'k'); hold on;
plot(ISIs(2,:),'.k','markersize',30)

xlim([0 9])
ylim([0 max(ISIs(:))+1])

