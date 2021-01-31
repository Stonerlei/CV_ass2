function [mag, ori] = cal_gradient(image)
size_image = size(image);
dx = ones(size_image);
dy = dx;
for c = 1:size_image(3)
    for i = 1:size_image(1)-1
        for j = 1:size_image(2)-1
            dx(i,j,c) = image(i+1,j,c)-image(i,j,c);
            dy(i,j,c) = image(i,j+1,c)-image(i,j,c);
        end
    end
end
mag = (dx.^2 + dy.^2).^0.5;
ori = atan(dy./dx);
flag = isnan(ori);
ori(flag) = 0;
end