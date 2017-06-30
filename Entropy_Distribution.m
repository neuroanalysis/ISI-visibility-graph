% Entropy of degree distribution
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function H = Entropy_Distribution(P)

    H=0;
    N=length(P);
    for i=1:N
        if(P(i))
            H=H+P(i)*log2(P(i));
        end
    end
    H=-H;
    
end