function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)

outputImg = origImg; % save original to putput so that the output matches the dimensions and data type

newImg = double(origImg);
[m,n,x] = size(origImg);
numPixels = m*n;
newImg = reshape(newImg,numPixels,x);
[clusterIds,meanColors] = kmeans(newImg,k);

meanColors = uint8(meanColors); % meancolors was returned as a double, so we cast it to uint8
cIds = reshape(clusterIds,m,n);


for i=1:m
    for j=1:n     
       B = cIds(i,j); % the cluster that pixel(i,j) belongs to
       B = meanColors(B,:); % retrieve the RGB values for the cluster specified from the statement above
       outputImg(i,j,:) = B; % pass the RGB mean values to outputImg
    end
end



subplot(1,2,1);
imshow(origImg);
title('original image');
subplot(1,2,2);
imshow(outputImg);
t = sprintf('output image k=%i', k);
title(t);

end