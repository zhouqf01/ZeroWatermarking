% Get area from convex hull
function area = GetArea(x, y)
    
    x = x(:);
    y = y(:);
    
    if length(x) ~= length(y)
        error('x and y must have the same length');
    end
    
    
    n = length(x);
    area = 0; 
    
    % formula (4)
    for i = 1:n
        j = mod(i, n) + 1;
        area = area + (x(i) * y(j) - x(j) * y(i));
    end
    
    area = abs(area) / 2; 
end