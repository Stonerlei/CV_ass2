clear all
image = imread('e.png');
% image(306,308) = 123;
size_pyramid = 5;
pyramid_rate = 2;
gauss_pyramid = cell(size_pyramid, 1);
laplacian_pyramid = cell(size_pyramid, 1);
image = subsample(image, pyramid_rate);
gauss_pyramid{1,1} = image;
for i = 2:size_pyramid
    image = subsample(image, pyramid_rate);
    gauss_pyramid{i,1} = image;
    laplacian_pyramid{i-1,1} = double(gauss_pyramid{i-1,1})-upsample(gauss_pyramid{i,1}, pyramid_rate);
end
laplacian_pyramid(size_pyramid) = gauss_pyramid(size_pyramid);
% figure(1)
hold on
for i = size_pyramid:-1:1
    laplacian_pyramid{i} = abs(laplacian_pyramid{i});
    laplacian_pyramid{i} = laplacian_pyramid{i}/max(laplacian_pyramid{i},[],'all');
    imshow(laplacian_pyramid{i})
end