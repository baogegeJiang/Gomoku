perLoop=10;
mapSize=15;%�趨���̴�С
AIDep=6;%�趨AI��������ȣ�һ����4~8֮�䣬����Խ���ʱԽ��


%�趨ÿ�����͵ķ����������ǻ��ģ����������˻��������ӣ������壬���ģ���һ�˿����ӣ�
%����������ֻ�������ӣ���������ֻ��һ�˿����ӣ�����������˼������������ӣ������������ӣ�
%��������һ�˿����ӣ�
defaultLineValue=[5000,2550,10000000,2500,2000,1250,1000,500,250];
centerCoor=ceil(mapSize/2);
map=creatNewMap(mapSize);
laziState=1;




for i=1:3
    newLineValue=defaultLineValue;
    newLineValue(2)=newLineValue(2)*(1+(rand-0.5)*0.1);
    for j=1:10
        winside=0;
        defaultSide=mod(j+1,2)+1;
        newSide=mod(j,2)+1;
        newNum=0;
        centerCoor=ceil(mapSize/2);
        map=creatNewMap(mapSize);
        laziState=1;
        for k=1:200
            k
            winside=isEnd(map);
            if winside~=0
                winside
                break;
            end
        if k<3
        pointState=map.array(centerCoor,centerCoor);
        map.array(centerCoor+pointState,centerCoor+pointState)=mod(i+1,2)+1;
        elseif k<8
            if mod(k+1,2)+1==defaultSide
            [map,value]=AILazi(map,mod(k+1,2)+1,4,defaultLineValue);
            else
            [map,value]=AILazi(map,mod(k+1,2)+1,4,newLineValue);
            end
        else
            if mod(k+1,2)+1==defaultSide
            [map,value]=AILazi(map,mod(k+1,2)+1,AIDep,defaultLineValue);
            else
            [map,value]=AILazi(map,mod(k+1,2)+1,AIDep,newLineValue);
            end
        end
        end
        if winside==newSide
            newNum=newNum+1
        end
        plotMap(map);
    end
    newNum
    if newNum>5
        defaultLineValue=newLineValue;
    end
end
