% Pruebas "Visibility graph" 2
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

load CTR
load ANT
load PRK

N=size(ContISIAll,2);
for i=1:N
    assignin('base',['ISI_CTR_' num2str(i)],ContISIAll{1,i});
end

N=size(AntISIAll,2);
for i=1:N
    assignin('base',['ISI_ANT_' num2str(i)],AntISIAll{1,i});
end

N=size(LesISIAll,2);
for i=1:N
    assignin('base',['ISI_PRK_' num2str(i)],LesISIAll{1,i});
end