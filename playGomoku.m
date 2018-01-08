humanSide=2;%指定人下子的先后，1先，2后，-1则是电脑自己对弈； 
mapSize=15;%设定棋盘大小
AIDep=6;%设定AI搜索的深度，一般在4~8之间，层数越深耗时越长

%设定每种棋型的分数，依次是活四，活三（两端还可三入子），连五，连四（仅一端可入子）
%连三（两端只可入两子），连三（只有一端可入子），活二（两端加起来可入三子），活二（入二子）
%连二（仅一端可入子）
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