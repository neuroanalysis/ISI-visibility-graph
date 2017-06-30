% Plot visibility graph from ISI
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function P = Plot_Visibility_bin(Name,ISI,bin)
    % Get spikes from ISI
    time=repmat(cumsum(ISI)',1,2);
    spikes_1=zeros(length(ISI),1);
    spikes_2=ones(length(ISI),1);
    spikes=[spikes_1 spikes_2];

    % Visibility graph
    tic
    A = Visibility_ISI_bin(ISI,bin);
    disp(['Building visibility network: ' num2str(toc)])

    % Graph properties
    tic
    P=SmallWorld(['SmallWorld propeties - ' Name],A);
    disp(['Calculating network properties: ' num2str(toc)])

    % Plot 
    tic
    h=Set_Figure(['Visibility graph - ' Name],[0 0 1200 800]);
    figure(h)

    % Spikes
    subplot(6,2,[1 2])
    plot(time',spikes','k')
    title(['Spikes = ' num2str(sum(spikes(:,2)))])
    xlabel('time [s]')
    set(gca,'ytick',[])

    % ISIs
    subplot(6,2,[3 4])
    plot(ISI,'k')
    xlabel('# ISI')
    ylabel('ISI [s]')

    % Adjacency matrix
    subplot(6,2,[5 7 9 11])
    imagesc(A)

    % Network
    subplot(6,2,[6 8 10 12])
    Plot_Network(A)
    set(gca,'xtick',[],'ytick',[]); box on
    disp(['Ploting: ' num2str(toc)])
    xlabel(['L=' num2str(P.L) '; E=' num2str(P.E) '; C=' num2str(P.C) '; /omega=' num2str(P.Omega) '; /gamma=' num2str(P.slope)])
    
    %{
    % Degree distribution
    links=sum(A);
    Set_Figure(['Distribution - ' Name],[0 0 500 600]);
    subplot(2,1,1)
    hist(links);
    title('P(k) - Degree distribution')
    
    % Hierarchical 
    subplot(2,1,2)
    links=sum(A);
    plot(links,Clocal,'ok');
    title('C(k) - Hierarchy')
    %}
    
    % Outputs
    P.A=A;
    
    % Save
    frame=getframe(gcf);
    imwrite(frame.cdata,[Name '.png']);
    
end




