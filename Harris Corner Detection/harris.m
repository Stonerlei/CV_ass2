clear all
image = imread('d.png');
image_1 = image;
size_image = size(image);
filter = Gen_Gauss_filter(4,5);
image = conv(image, filter);
[dx, dy] = cal_gradient(image);
window = Gen_Gauss_filter(4, 5);
windowed_gradient = cell(2);
windowed_gradient{1,1} = conv(dx.^2, window);
windowed_gradient{1,2} = conv(dx.*dy, window);
windowed_gradient{2,1} = windowed_gradient{1,2};
windowed_gradient{2,2} = conv(dy.^2, window);
M = zeros(2);
corner_response = zeros(size_image);
harris_operator = corner_response;
alpha = 0.05;
operator_thershold = 0.000005;
response_thershold = 0.000002;
for c = 1:size_image(3)
    for i = 1:size_image(1)
        for j = 1:size_image(2)    
            M(1,1) = windowed_gradient{1,1}(i,j,c);
            M(1,2) = windowed_gradient{1,2}(i,j,c);
            M(2,1) = M(1,2);
            M(2,2) = windowed_gradient{2,2}(i,j,c);
            corner_response(i,j,c) = det(M)-alpha*trace(M)^2;
            harris_operator(i,j,c) = det(M)/trace(M);
        end
    end
end
%% select local maximum
harris_operator(isnan(harris_operator)) = 0;
corner_response(isnan(corner_response)) = 0;
harris_operator_max = imregionalmax(harris_operator, 8);
corner_response_max = imregionalmax(corner_response, 8);
harris_operator = harris_operator.*harris_operator_max;
corner_response = corner_response.*corner_response_max;
for c = 1:size_image(3)
    for i = 1:size_image(1)
        for j = 1:size_image(2) 
            if harris_operator(i,j,c) > operator_thershold
                harris_operator(i,j,c) = 255;
            else
                harris_operator(i,j,c) = 0;
            end
            if corner_response(i,j,c) > response_thershold
                corner_response(i,j,c) = 255;
            else
                corner_response(i,j,c) = 0;
            end
        end
    end
end
% imshow(corner_response,[])
corner_response = max(corner_response,[],3);
corner_flag = zeros(size_image);
corner_flag(:,:,1) = corner_response;
corner_flag(:,:,1) = corner_flag(:,:,1)/max(corner_flag(:,:,1),[],'all');
imshow(corner_flag);
corner_tagged = corner_flag + double(image_1)/max(double(image_1),[],'all');
for i = 1:size_image(1)
    for j = 1:size_image(2)
        if corner_response(i,j) ~= 0
            corner_tagged(i,j,1) = 255;
            corner_tagged(i,j,2) = 0;
            corner_tagged(i,j,3) = 0;
        end
    end
end
imshow(corner_tagged);