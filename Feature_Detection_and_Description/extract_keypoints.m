function [x, y, scores, Ih, Iv] = extract_keypoints(image)


kval = 0.05;
%windowSize = 5;
originalImage = image;
image = rgb2gray(image);
image = im2double(image);


x = [];
y = [];
scores = [];

% these are the filters
hX = [1, 0 , -1];
hY = [1; 0; -1];

% compute derivative of image using filters
Ih = imfilter(image,hX,'same');
Iv = imfilter(image, hY, 'same');

% find the image size to use in the matrix
imageSize = size(image);

% declare matrix same size as image for R-scores
R = zeros(imageSize);
[m,n,z] = size(image);

% loop through the image with a 5x5 window and apply the harris detector to 
% each pixel in the window
for i = 1:m
    for j = 1:n
        
        M = zeros(2);
        
        % looping through the pixels in the window
        for k = i-2 : i+2
            for l = j-2 : j+2
                if k>m || k<=0 || l>n || l<=0
                    R(i,j) = -Inf;
                    continue;
                end
                M(1,1) = M(1,1) + Ih(k,l)^2;
                M(1,2) = M(1,2) + Ih(k,l)*Iv(k,l);
                M(2,1) = M(2,1) + Ih(k,l)*Iv(k,l);
                M(2,2) = M(2,2) + Iv(k,l)^2;
            end
        end   
        % compute R-score
        R(i,j) = det(M) - kval*(trace(M))^2;
    end
end

% find the mean R-score in order to determine a threshold for finding the
% highest R-scores
averageR = mean2(R); 
threshold = 5*averageR;

% creates a matrix of same dimensions as R with 1s in place of values that
% surpass the threshold
thresholdR = R > threshold;


for i = 1:m
    for j = 1:n
        % remove pixels along any of the edges (set them to 0)
        if i==1 || i==m || j==1 || j==n
           thresholdR(i,j) = 0;
           continue;
        end
        
        % find local maximum
        %%%%%%%%%%%%%%%%%%%%max = 0;
        %max = 0;
        maxFound =1;
        for k = i-1:i+1
            for l = j-1:j+1
                % keep updating the maximum
                %if R(k,l) > max
                if R(k,l) >= R(i,j) && k~=i && l~=j
                   thresholdR(i,j) = 0;
                   maxFound = 0;
                   break;
                end
            end
            if maxFound ==0
                break;
            end
        end
        % remove keypoints that are not greater than their 8 neighbors        
       % if R(i,j) < max
       %    thresholdR(i,j) = 0;
       %    continue;
        %end  
        
        % append locations and scores of local maximums to output vectors
        if maxFound ==0
            continue;
        end
       
        if thresholdR(i,j) == 1
            x = [x, i];
            y = [y, j];
            scores = [scores, R(i,j)];
        end
        
    end
end
    %imshow(image);
    %hold on;
    %scatter(y,x);
    
    imshow(originalImage);
    hold on;
    for i = 1:length(x)
        plot(y(i), x(i), 'ro', 'MarkerSize', scores(i)*5);
    end

end  
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

