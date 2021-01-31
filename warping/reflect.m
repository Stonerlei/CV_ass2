function new_image = reflect(image, transform_matrix)
size_image = size(image);
new_image = zeros(1000,1000,size_image(3));
for ch = 1:size_image(3)
    for i = 1:size_image(1)
        for j = 1:size_image(2)
            xt = transform_matrix*[i,j,1]';    %向下取整数坐标
            xt = floor(xt/xt(3));
    %         if xt(1)<=0 && xt(2)<=0
    %             xt = mod(xt'-1, size_image);
    %         elseif xt(1)<=0 &&xt(2)>0
    %             xt(1) = mod(xt(1)-1, size_image(1));
    %         elseif xt(1)>0 &&xt(2)<=0
    %             xt(2) = mod(xt(2)-1, size_image(2));
    %         end
            if(xt(1)+301>0 && xt(2)+101>0)
%                 if xt(1)==9 && xt(2)==8
%                     iufa = 'yes'
%                 end
                new_image(xt(1)+301,xt(2)+101,ch) = image(i,j,ch);
            end
        end
    end
    new_image(:,:,ch) = new_image(:,:,ch)/max(new_image(:,:,ch),[],'all');
end

end