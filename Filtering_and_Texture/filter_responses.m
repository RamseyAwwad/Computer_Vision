% QUESTION 3
DirList = dir(fullfile('*.jpg')); % consider changing this so it only adds specific images (there are other .jpg files from later in the assignment)
listOfFiles = {DirList.name};

images = cell(6,1); % 6 images
processedImages = cell(6,49); % contains the cross-correlations between each of the filtered images and their respective grayscale image

[m,n] = size(listOfFiles);
F = makeLMfilters;

% loop over list of files
for i = 1:n
    disp(listOfFiles(i)); % print file name (for testing purposes only)
    images{i,1} = char(convertStringsToChars(listOfFiles(i))); % convert to string format
    processedImages{i,1} = imread(images{i,1});   % read in image
    processedImages{i,1} = rgb2gray(processedImages{i,1});    % convert to grayscale
    processedImages{i,1} = imresize(processedImages{i,1}, [300 300]); % resize image to 300x300
    
    % now we need to apply each of the 48 filters created from makeLMfilters.m using imfilter
    for j= 1:48   
        processedImages{i,j+1} = imfilter(processedImages{i,1}, F(:,:,j)); % the +1 is there because we already have the original grayscale image in column 1
    end   
end


% QUESTION 4
for i = 1:48
    for j = 1:8

        if j==2 
            continue; % plot an empty white space in the second column of the first row
        end

        if j==1
            subplot(2,4,1); 
            imagesc(F(:,:,i)); % plot the filter first
            continue;
        end
      
        m = j-2; % for referencing any of the 6 images in processedImages{}
        n = i+1; % for referencing any of the 48 filters in processedImages{}, where the filtered images are between 2 and 49
        
        subplot(2,4,j);
        imagesc(processedImages{m,n}); % create 2x4 subplot for each filter 
        
        % Add titles to images
        switch m
            case 1
                title('cardinal1.jpg');
            case 2
                title('cardinal2.jpg');
            case 3
                title('leopard1.jpg');
            case 4
                title('leopard2.jpg');
            case 5
                title('panda1.jpg');
            case 6
                title('panda2.jpg');
        end % end switch
        
    end % for j = 1:8
    saveas(gcf, strcat('responses_to_filter_', num2str(i), '.png'));
end % for i = 1:48
