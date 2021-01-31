function new_edge = hysteresis(edge)
size_edge = size(edge);

high_threshold = mean(edge,'all');
low_threshold = high_threshold/2;
flag = edge>high_threshold;
for c = 1:size_edge(3)
    for i = 2:size_edge(1)-1
        for j = 2:size_edge(2)-1
            if edge(i,j,c)>low_threshold
                if flag(i-1,j,c) || flag(i+1,j,c) || flag(i,j-1,c) || flag(i,j+1,c)
                    flag(i,j,c) = 1;
                end
            end
        end
    end
end
new_edge = edge.*flag;
end
