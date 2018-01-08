humanSide=2;% 1 play first; 2 second
mapSize=15;% set map size
AIDep=6;% the depth for calculation; the lager the smarter 

%set line type values
defaultLineValue=[5000,2550,10000000,2500,2000,1250,1000,500,250];

centerCoor=ceil(mapSize/2);
map=creatNewMap(mapSize);
laziState=1;

plotMap(map);

for i=1:mapSize^2
    
    winSide=isEnd(map);
    
    if winSide~=0
        winSide
        break
    end
    
    if mod(i+1,2)+1==humanSide
    [map,laziState]=manualLazi(map,mod(i+1,2)+1);
    else
        if i<3
        pointState=map.array(centerCoor,centerCoor);
        map.array(centerCoor+pointState,centerCoor+pointState)=mod(i+1,2)+1;
        elseif i<8
            [map,value]=AILazi(map,mod(i+1,2)+1,4,defaultLineValue);
        else
            [map,value]=AILazi(map,mod(i+1,2)+1,AIDep,defaultLineValue);
        end
    end
    
    if laziState==0 
        break;
    end
    plotMap(map);
    pause(0.5);
end