% Visibility graph from ISIs
%
% Pérez-Ortega Jesús E.
% Nov-2016
function [f kmean] = Visibility_ISI_Horizontal_filter(ISI,filter_step,times)
    
    % Initializing visibility graph
    nodes=length(ISI);
    
    i=1;
    final=times*filter_step;
    for f=0:filter_step:final
        
        A=zeros(nodes);
        % Defaults connections
        for a=1:(nodes-1)
            A(a,a+1)=1;
            A(a+1,a)=1;
        end

        % Visibility criterion
        for a=1:(nodes-2)
            for b=(a+2):nodes
                A(a,b)=1;
                A(b,a)=1;
                for c=(a+1):(b-1)
                    if((ISI(c)+f)>=ISI(a) || (ISI(c)+f)>=ISI(b))
                        A(a,b)=0;
                        A(b,a)=0;
                        break;
                    end
                end
            end
        end
        kmean(i)=sum(A(:))/nodes;
        i=i+1;
    end
    f=0:filter_step:final;  
    plot(f,kmean,'or')
end