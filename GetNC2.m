% Get normalized correlation (NC) for two watermarks
function NC = GetNC2(w1,w2)
    
    
    if iscolumn(w1)
        w1=w1';
    end
    
    if iscolumn(w2)
        w2=w2';
    end
    
    w1=int32(w1);
    w2=int32(w2);

    l1=numel(w1);
    l2=numel(w2);

    if l1>l2
        w1=w1(1:l2);
    else
        w2=w2(1:l1);
    end

    NC=sum(w1.*w2)/sqrt(sum(w1.^2)*sum(w2.^2));
end
