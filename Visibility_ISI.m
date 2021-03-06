% Visibility graph from ISIs
%
% P�rez-Ortega Jes�s E.
% Sep-2016
function A = Visibility_ISI(ISI)

    % Initializing visibility graph
    nodes=length(ISI);
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
                if(ISI(c)>=(ISI(b)+(ISI(a)-ISI(b))*((b-c)/(b-a))))
                    A(a,b)=0;
                    A(b,a)=0;
                    break;
                end
            end
        end
    end
end