% Plot Network Multilevel
%
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function Plot_Network_Multilevel(Adjacency,ISI)
    
    Adjacency=double(Adjacency>0);
    
    % Get circular coordinates
    radio=1;
    N=length(Adjacency);
    links=sum(Adjacency);
    XY=[cos(2*pi*[1:N]'/N) sin(2*pi*[1:N]'/N)].*radio;
    
    % Modify coordinates by links (multilevels)
    for i=1:N
        hub=ISI(i);
        XY(i,:)=XY(i,:).*(1-(hub-1)*0.25);
        1-(hub-1)*0.25
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
            k=round(n_colors*k/max_k)+1;
            color=colors(k,:);
        end
        color=colors(k,:);
        plot(XY(i,1),XY(i,2),'.k','MarkerSize',35)
        plot(XY(i,1),XY(i,2),'.','color',color,'MarkerSize',23)
        text(XY(i,1)*1.1,XY(i,2)*1.1,num2str(i),'HorizontalAlignment','Center')
    end
    
    xlim([-1.25 1.25])
    ylim([-1.25 1.25])
    
end