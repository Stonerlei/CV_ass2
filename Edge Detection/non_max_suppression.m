function nms_mag = non_max_suppression(mag, ori)
size_mag = size(mag);
flag = zeros(size_mag);
for c = 1:size_mag(3)
    for i = 2:size_mag(1)-1
        for j = 2:size_mag(2)-1
            dir = ori(i,j,c);
            %interpolate
            x1 = i+cos(dir);
            y1 = j+sin(dir);
            x2 = i-cos(dir);
            y2 = j-sin(dir);
            mag_first = mag(floor(x1),round(y1),c)*(floor(x1)+1-x1) + mag(floor(x1)+1,round(y1),c)*(x1-floor(x1));
            mag_second = mag(floor(x2),round(y2),c)*(floor(x2)+1-x2) + mag(floor(x2)+2,round(y2),c)*(x2-floor(x2));

            if mag(i,j,c)>mag_first && mag(i,j,c)>mag_second
                flag(i,j,c) = 1;
            end
        end
    end
end
nms_mag = mag.*flag;
end