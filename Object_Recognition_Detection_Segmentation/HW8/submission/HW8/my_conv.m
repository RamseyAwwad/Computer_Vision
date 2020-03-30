function [Output] = my_conv(Image, Filter, Padding, Stride)

new_height = size(Image,1)+Padding*2;
new_width = size(Image,2)+Padding*2;

padded_image = zeros(new_height,new_width);
padded_image(Padding+1:new_height-Padding,Padding+1:new_width-Padding) = Image;

filter_size = size(Filter,1);

dimensionX = uint8(size(Image,1)/Stride);
dimensionY = uint8(size(Image,2)/Stride);

Output = zeros(dimensionX, dimensionY);

for i = 1:Stride:size(padded_image,2)
    for j = 1:Stride:size(padded_image,1)
        
        maxJ = j+filter_size-1;
        maxK = i+filter_size-1;
        
        if maxJ > dimensionX || maxK > dimensionY
            break;
        end
        
        filtered_content = padded_image(j:maxJ, i:maxK)*Filter;
        filter_sum = sum(sum(filtered_content));
        
        Output(uint8(j/Stride)+1,uint8(i/Stride)+1) = filter_sum;
    end
end