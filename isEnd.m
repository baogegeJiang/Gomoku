function [ side ] = isEnd( map )
side=0;line=zeros(5,1);isFull=1;
for i=1:map.size
    for j=1:map.size
        if map.array(i,j)==0
            isFull=0;
        end
        if i<=map.size-4 && map.array(i,j)~=0
            
            if (i<=map.size-5 && map.array(i+5,j) ~= map.array(i,j)) || ...
                    i==map.size-4
                line(1:5,1)=map.array(i:i+4,j)-ones(5,1)*map.array(i,j);
                if norm(line)==0
                    side=map.array(i,j);
                    return;   
                end
            end
        end
            
       if j<=map.size-4 && map.array(i,j)~=0
            
            if (j<=map.size-5 && map.array(i,j+5) ~= map.array(i,j)) || ...
                    j==map.size-4
                line(1:5,1)=(map.array(i,j:j+4)-ones(1,5)*map.array(i,j))';
                if norm(line)==0
                    side=map.array(i,j);
                    return;   
                end
            end
       end  
        
       if i<=map.size-4 && map.array(i,j)~=0 && j <=map.size-4
            
            if (i<=map.size-5 && j<=map.size-5 && map.array(i+5,j+5) ~= map.array(i,j) || ...
                    i==map.size-4 || j==map.size-4)
                for ii=1:5
                    line(ii,1)=map.array(i+ii-1,j+ii-1);
                end
                line(1:5,1)=line(1:5,1)-ones(5,1)*map.array(i,j);
                if norm(line)==0
                    side=map.array(i,j);
                    return;   
                end
            end
       end
       
        if i<=map.size-4 && map.array(i,j)~=0 && j >=5
            
            if (i<=map.size-5 && j>=6 && map.array(i+5,j-5) ~= map.array(i,j)) || ...
                    i==map.size-4 || j==5
                for ii=1:5
                    line(ii,1)=map.array(i+ii-1,j-ii+1);
                end
                line(1:5,1)=line(1:5,1)-ones(5,1)*map.array(i,j);
                if norm(line)==0
                    side=map.array(i,j);
                    return;   
                end
            end
        end
       
    end
end
if isFull==1;side=3;end
end

