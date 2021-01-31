function new_image = inverse_reflect(image, inverse_matrix)
size_image = size(image);
new_image = zeros(1000,1000,size_image(3));
size_newimage = size(new_image);
for ch = 1:size_image(3)
    for i = -400:size_newimage(1)-400
        for j = -200:size_newimage(2)-200
            x = inverse_matrix*[i,j,1]';
            yt = x(2);
            xt = x(1);
            if x(1)>1 && x(2)>1 && x(1)<size_image(1) && x(2)<size_image(2)
                temp1 = ((xt-floor(xt))*image(floor(xt)+1, floor(yt),ch) + (floor(xt)+1-xt)*image(floor(xt), floor(yt),ch));
                temp2 = ((xt-floor(xt))*image(floor(xt)+1, floor(yt)+1,ch) + (floor(xt)+1-xt)*image(floor(xt), floor(yt)+1,ch));
                new_image(i+401,j+201,ch) = temp2*(yt-floor(yt)) + temp1*(floor(yt)+1-yt);
            end
        end
    end
    new_image(:,:,ch) = new_image(:,:,ch)/max(new_image(:,:,ch),[],'all');
end
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
end