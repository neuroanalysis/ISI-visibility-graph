% Entropy of visibility graph from ISI
% 
% Para Alecita
% Pérez-Ortega Jesús E.
% Sep 2016

function H = Entropy_Network(A,Name)
    
    [f k]=hist(sum(A),1:100);
    P=f/size(A,1);
    H=Entropy_Distribution(P);
    
    Set_Figure(Name,[0 0 500 400]);
    bar(k,P)
    title([Name ' - Entropy = ' num2str(H)])
    
    % Save
    frame=getframe(gcf);
    imwrite(frame.cdata,[Name '.png']);
end