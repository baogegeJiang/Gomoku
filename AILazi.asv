function [ map,value ] = AILazi( map,side,dep,lineValue)
a=zeros(500,1);c=zeros(500,1);value=0;
for i=1:map.size
    for j=1:map.size
        a(i+(j-1)*20)=map.array(i,j);
    end
end
for i=1:9
    a(400+i)=lineValue(i);
end
c=gomoku(a,map.size,side,dep);
for i=1:map.size
    for j=1:map.size
        map.array(i,j)=c(i+(j-1)*20); 
    end
end
value=c(400);