function [  ] = plotMap( map )
mark={'ok','or'};c=[0,0,0;1,1,1];
for i=1:map.size
    for j=1:map.size
        plot(i,j,'.k');hold on
        if map.array(i,j)~=0
          plot(i,j,mark{map.array(i,j)},'MarkerSize',20,'MarkerFaceColor',c(map.array(i,j),:));
          hold on
        end
    end
end
xlim([1,map.size]);
ylim([1,map.size]);
%legend('1','2');
hold off
end

