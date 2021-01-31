clear all
image = imread('d.png');
% image = image(:,:,1);
size_iamge = size(image);
t = [200;300];
transform_matrix = zeros(3,3);
transform_matrix(1:2, 3) = t;
transform_matrix(3,:) = [0,0,1];
% translation
transform_matrix(1:2,1:2) = [1,0;0,1];
new_image_t = reflect(image, transform_matrix);
new_image_it = inverse_reflect(image, inv(transform_matrix));

% rotation
theta = pi/6;
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
transform_matrix(1:2, 1:2) = R;
new_image_r = reflect(image, transform_matrix);
new_image_ir = inverse_reflect(image, inv(transform_matrix));
% œ‡À∆
theta = pi/6;
s = 0.5;
transform_matrix(1:2, 1:2) = s*R;
new_image_x = reflect(image, transform_matrix);
new_image_ix = inverse_reflect(image, inv(transform_matrix));
%∑¬…‰
transform_matrix = [2,5,3;4,1,7;0,0,5]/5;
new_image_f = reflect(image, transform_matrix);
new_image_if = inverse_reflect(image, inv(transform_matrix));
%Õ∂”∞
H = [2,1,0;1,2,0;0,0,1]/3;
new_image_ip = inverse_reflect(image,inv(H));
imshow(new_image_p)
new_image_p = reflect(image, H);
