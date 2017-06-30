% Pruebas "Visibility graph"  horizontal with filter
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% DIC 2016

load ALL_areas_comps

% CTR
for i=1:9
    figure(1)
    plot(CTR_comps(:,i),'color',[0.8 0.8 1]); hold on; % Control (blue)
end
plot(CTR_comps(:,3),'color',[0 0 0]);
plot(median(CTR_comps'),'color',[0 0 1]) % Control (blue))
% save figure
frame=getframe(gcf);
imwrite(frame.cdata,['CTR_comps.png']);


% PRK
for i=1:8
    figure(2)
    plot(PRK_comps(:,i),'color',[1 0.8 1]);hold on % 6-OHDA (purple)
end
plot(PRK_comps(:,5),'color',[0 0 0]);
plot(median(PRK_comps'),'color',[1 0 1]); % 6-OHDA (purple)
% save figure
frame=getframe(gcf);
imwrite(frame.cdata,['PRK_comps.png']);

% ANT
for i=1:11
    figure(3)
    plot(ANT_comps(:,i),'color',[1 1 0.8]);hold on; % Antagonist (orange)
end
plot(ANT_comps(:,7),'color',[0 0 0]);
plot(median(ANT_comps'),'color',[1 0.5 0]); % Antagonist (orange)
% save figure
frame=getframe(gcf);
imwrite(frame.cdata,['ANT_comps.png']);
