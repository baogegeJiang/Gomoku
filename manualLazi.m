function [ map,state ] = manualLazi( map,side)
state=1;
p=ginput(1);
x=floor(p(1)+0.5);y=floor(p(2)+0.5);
if map.array(x,y)==0;
    map.array(x,y)=side;
else
    fprintf('cannot lazi there!\n');
    [ map,state ] = manualLazi( map,side);
end
end

