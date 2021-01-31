clear all
image = imread('d.png');
size_image = size(image);
% image = image(:,:,1);
% construct derivative of gauss filter
% size_filter = 5;
% filter = Gen_Gauss_filter(10, size_filter);
% dx_filter = ones(size_filter);
% dy_filter = dx_filter;
% for i = 1:size_filter-1
%     for j = 1:size_filter-1
%         dx_filter(i,j) = filter(i+1,j)-filter(i,j);
%         dy_filter(i,j) = filter(i,j+1)-filter(i,j);
%     end
% end
% % filter = cal_gradient(filter);
% dx_image = conv(image, dx_filter);
% dy_image = conv(image, dy_filter);
% mag = (dx_image.^2 + dy_image.^2).^0.5;
% ori = atan(dy_image./dx_image);
size_filter = 5;
filter = Gen_Gauss_filter(50, size_filter);
image = conv(image, filter);
[mag, ori] = cal_gradient(image);   %未使用卷积的线性特点，可以先求filter的梯度，再卷积

hys_mag = hysteresis(mag);
nms_mag = non_max_suppression(hys_mag, ori);
for c = 1:size_image(3)
    nms_mag(:,:,c) = nms_mag(:,:,c)/max(nms_mag(:,:,c),[],'all');
    mag = mag/max(mag,[],'all');
    hys_mag(:,:,c) = hys_mag(:,:,c)/max(hys_mag(:,:,c),[],'all');
end
ori = ori-min(ori,[],'all');
imwrite(uint8(floor(ori)*255/max(ori,[], 'all')), 'ori.png');
imwrite(mag, 'mag.png');
imwrite(nms_mag, 'nms_mag.png');
imwrite(hys_mag, 'hys_mag.png');