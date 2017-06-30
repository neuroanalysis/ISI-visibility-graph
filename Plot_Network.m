% Plot Network
%
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function XY=Plot_Network(Adjacency,XY)
    
    if isempty(XY)
       noXY = true;
    else
       noXY = false;
    end
    
    Adjacency=double(Adjacency>0);
    
    % Get circular coordinates
    radio=1;
    N=length(Adjacency);
    links=sum(Adjacency);
    if(noXY)
        XY=[cos(2*pi*[1:N]'/N) sin(2*pi*[1:N]'/N)].*radio;
    end
    % Modify coordinates by links MULTILEVEL
    %{
    for i=1:N
        XY(i,:)=XY(i,:)./links(i);
    end
    %}
    
    % Modify coordinates by links (2 levels)
    %
    if(noXY)
        for i=1:N
            %th=median(links);
            %th=mean(links)+std(links);
            th=N/6;
            if (links(i)>th)
                XY(i,:)=XY(i,:)./2;
            end
        end
    end
    %}
    % Plot edges
    width=1;
    color=[0 0 0];    
    hold on
    for a=1:N-1
        for b=a+1:N
            if (Adjacency(a,b))
                plot(XY([a b],1),XY([a b],2),'color',color,'LineWidth',width);
            end
        end
    end

    % Plot nodes
    max_k=max(links);
    colors=colormap('jet');
    n_colors=size(colors,1)-1;
    for i=1:N
        k=links(i);
        if (max_k>n_colors)
            k=round(n_colors*k/max_k);
            color=colors(k,:);
        end
        color=colors(k+1,:);
        plot(XY(i,1),XY(i,2),'.k','MarkerSize',35)
        plot(XY(i,1),XY(i,2),'.','color',color,'MarkerSize',23)
        text(XY(i,1)*1.1,XY(i,2)*1.1,num2str(i),'HorizontalAlignment','Center')
    end
    
    xlim([-1.25 1.25])
    ylim([-1.25 1.25])
    
end