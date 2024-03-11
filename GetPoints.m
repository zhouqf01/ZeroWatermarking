% Get points from Shapefile
function [x,y] = GetPoints(s,keepNaN)
    % Default does not keep NaN
    arguments
        s
        keepNaN=false
    end

    x=[s.X];
    y=[s.Y];

    if ~keepNaN
        x(isnan(x))=[];
        y(isnan(y))=[];
    end
end
