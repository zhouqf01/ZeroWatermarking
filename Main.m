fn="data-poi/a.shp";

% 0. read shp
s=shaperead(fn);

% 1. construct zero watemark
w0=ConstructWatermark(s);

% 2. print zero watermark
disp("zero watermark: ")
disp(w0);

% 3. robustness experiments
% translation attack, tranlate 100m in x and y direction
s_translate=s;
for i=1:numel(s_translate)
    s_translate(i).X=s_translate(i).X+100;
    s_translate(i).Y=s_translate(i).Y+100;
end

w_translate=ConstructWatermark(s_translate);
nc=GetNC2(w0,w_translate);
disp("NC after translation attack: ")
disp(nc);

% 4. uniqueness experiments
n=100;
warr=cell(1,n); % watermark array
for i=1:n
    fn_tmp="data-random/a"+i;
    s_tmp=shaperead(fn_tmp);
    warr{i}=ConstructWatermark(s_tmp);
end

% get pairs of zero watemarks
combIndex=nchoosek(1:n,2);
ncmb=size(combIndex,1);

% calculate NC values
ncarr=zeros(1,ncmb);

for i=1:ncmb
    w1=warr{combIndex(i,1)};
    w2=warr{combIndex(i,2)};
    ncarr(i)=GetNC2(w1,w2);
end

% analysis of NC values
disp("min: ");
disp(min(ncarr));
disp("mean: ");
disp(mean(ncarr));
disp("median: ");
disp(median(ncarr));
disp("max: ");
disp(max(ncarr));

%% Extension to polyline and polygon (see section 5.1)

% for polyline
fnln="data-polyline-polygon/River_JiangsuProvince.shp";
sln=shaperead(fnln);
wln=ConstructWatermark(sln);

% for polygon
fnpg="data-polyline-polygon/AdminDivision_HenanProvince.shp";
spg=shaperead(fnpg);
wpg=ConstructWatermark(spg);

% calculate NC between them with w0 to validate the uniqueness
disp("for polyline: ");
disp(GetNC2(wln,w0));

disp("for polygon: ");
disp(GetNC2(wpg,w0));

