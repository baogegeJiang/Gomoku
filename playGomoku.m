humanSide=2;%ָ�������ӵ��Ⱥ�1�ȣ�2��-1���ǵ����Լ����ģ� 
mapSize=15;%�趨���̴�С
AIDep=6;%�趨AI��������ȣ�һ����4~8֮�䣬����Խ���ʱԽ��

%�趨ÿ�����͵ķ����������ǻ��ģ����������˻��������ӣ������壬���ģ���һ�˿����ӣ�
%����������ֻ�������ӣ���������ֻ��һ�˿����ӣ�����������˼������������ӣ������������ӣ�
%��������һ�˿����ӣ�
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