% Parametric visibility graph from ISIs (at specific degree)
%
% Pérez-Ortega Jesús E.
% Dic-2016
function [A components] = SingleParametric_Visibility_ISI(A,ISI,degree)
    degree=degree*pi/180;
    nodes=length(A);    
    for a=1:(nodes-1)
        idx=find(A(a,:));
        for b=idx
            alpha=atan((ISI(b)-ISI(a))/(b-a));
            if((alpha+pi/2)>=degree)
                A(a,b)=0;
                A(b,a)=0;
            end
        end
    end
    components = max(get_components(A))/nodes;    
end