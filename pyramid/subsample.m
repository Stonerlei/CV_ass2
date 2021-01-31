function new_image = subsample(image, subsample_rate)
size_image = size(image);
%blur
var = 9;
size_filter = 5;
gauss_filter = Gen_Gauss_filter(var, size_filter);
image = conv(image, gauss_filter);

size_new = size_image;
size_new(1:2) = floor(size_image(1:2)/subsample_rate);
new_image = zeros(size_new);
for c = 1:size_image(3)
    for i = 1:size_new(1)
        for j = 1:size_new(2)
            new_image(i,j,c) = image(subsample_rate*i,subsample_rate*j,c);
        end
    end
end
end