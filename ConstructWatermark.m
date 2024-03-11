% Construct watermark from Shapefile
function w=ConstructWatermark(s)
    [X,Y]=GetPoints(s);

    x=X;
    y=Y;

    okarr=[];
    remaindercnt=0;

    cnt=0;
    layersX={};
    layersY={};

    while(true)
        cnt=cnt+1;
        [ok,~]=convhull(x,y); 
        ok(end)=[];

        okarr(end+1)=numel(ok);
        layersX{end+1}=x(ok);
        layersY{end+1}=y(ok);

        x(ok)=[];
        y(ok)=[];

        if numel(x)<=2 || PtAreCollinear(x,y)
            remaindercnt=numel(x);
            break;
        end
    end

    okInnerArr=zeros(size(okarr));
    for i=1:numel(okInnerArr)
        okInnerArr(i)=numel(X)-sum(okarr(1:i));
    end


    areas=cellfun(@(x,y) GetArea(x,y),layersX,layersY);
    density=double(okInnerArr)./areas;

    w=diff(density)>0;
end