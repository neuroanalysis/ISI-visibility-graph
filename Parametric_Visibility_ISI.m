% Parametric visibility graph from ISIs 
%
% Pérez-Ortega Jesús E.
% Dic-2016
function [alphas components] = Parametric_Visibility_ISI(A,ISI)
    nodes=length(A);
    i=1;
    components=[];
    % 45?:0.57?:135?
    %for alphas=pi/4:0.01:3*pi/4
    for alphas=0:(pi/180):pi
        Ac=A;
        for a=1:(nodes-1)
            idx=find(Ac(a,:));
            for b=idx
                alpha=atan((ISI(b)-ISI(a))/(b-a));
                if((alpha+pi/2)>=alphas)
                    Ac(a,b)=0;
                    Ac(b,a)=0;
                end
            end
        end
        components(i) = max(get_components(Ac));
        i=i+1;
    end
    components=components/nodes;
    %alphas=pi/4:0.01:3*pi/4;
    alphas=(0:(pi/180):pi)*180/pi;
end