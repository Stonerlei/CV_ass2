function new_image = upsample(image, upsample_rate)
size_image = size(image);
size_new = size_image;
size_new(1:2) = size_image(1:2)*upsample_rate;
new_image = zeros(size_new);
% NN interpolate
% for c = 1:size_image(3)
%     for i = 1:size_new(1)
%         for j = 1:size_new(2)
%             x = round(i/upsample_rate);
%             y = round(j/upsample_rate);
%             if x>0 && y>0
%                 new_image(i,j,c) = image(x,y,c);
%             end
%         end
%     end
% end

% bilinear interpolate
for c = 1:size_image(3)
    for i = 1:size_new(1)
        for j = 1:size_new(2)
            xt = i/upsample_rate;
            yt = j/upsample_rate;
            if mod(xt,1)==0 && mod(yt,1)==0
                new_image(i,j,c) = image(xt,yt,c);
            end
            if xt>1 && yt>1 && xt<size_image(1) && yt<size_image(2)
                temp1 = ((xt-floor(xt))*image(floor(xt)+1, floor(yt),c) + (floor(xt)+1-xt)*image(floor(xt), floor(yt),c));
                temp2 = ((xt-floor(xt))*image(floor(xt)+1, floor(yt)+1,c) + (floor(xt)+1-xt)*image(floor(xt), floor(yt)+1,c));
                new_image(i, j, c) = temp2*(yt-floor(yt)) + temp1*(floor(yt)+1-yt);
            end
        end
    end
end

%blur
var = 9;
size_filter = 5;
gauss_filter = Gen_Gauss_filter(var, size_filter);
new_image = conv(new_image, gauss_filter);
end