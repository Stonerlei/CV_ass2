function new_image = projection(image, H)
size_image = size(image);
transform_matrix = H;
new_image = zeros(1000);
for i = 1:size_image(1)
    for j = 1:size_image(2)
        xt = transform_matrix*[i,j,1]';
%         if xt(1)<=0 && xt(2)<=0
%             xt = mod(xt'-1, size_image);
%         elseif xt(1)<=0 &&xt(2)>0
%             xt(1) = mod(xt(1)-1, size_image(1));
%         elseif xt(1)>0 &&xt(2)<=0
%             xt(2) = mod(xt(2)-1, size_image(2));
%         end
        xt = xt'/xt(3);
        xt = floor([xt(1), xt(2)]);
        if(xt(1)>0 && xt(2)>0)
            new_image(xt(1),xt(2)) = image(i,j);
        end
    end
end
end