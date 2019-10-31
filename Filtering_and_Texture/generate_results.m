function [] = generate_results(filename, reduceAmt, reduceWhat)
    
    A = imread(filename);
    
    figure;
    space = ' reduced by ';
    name = strcat(filename,space,reduceAmt);
    title(name);
    
    subplot(1,3,1);
    imagesc(A);
    title('original');
    
    B = A; % save a copy of the original image for subplotting later
    
    % reduce size of image by reduceAmt using looped calls to reduceWidth()
    % or reduceHeight()
    if strcmp(reduceWhat,'WIDTH') 
        for i=1:reduceAmt
            if i==1
                A = reduceWidth(A,1); % only set flag to 1 on first iteration
            else
                A = reduceWidth(A,0);
            end
        end
        B = resize(B,[0 reduceAmt]);
    elseif strcmp(reduceWhat,'HEIGHT')
        for i=1:reduceAmt
            A = reduceWidth(A,1);
        end
        B = resize(B,[reduceAmt 0]);
    end
    
    subplot(1,3,2);
    imagesc(A);
    title('content-aware');
    subplot(1,3,2);
    imagesc(B);
    title('standard');
    
    
    [energyImage, Ix, Iy] = energy_image(A);
    M1 = cumulative_minimum_energy_map(energyImage,'HORIZONTAL');
    M2 = cumulative_minimum_energy_map(energyImage,'VERTICAL');
    
    horizontalSeam = find_optimal_horizontal_seam(M1);
    verticalSeam = find_optimal_vertical_seam(M2);
    
    displaySeam(A, horizontalSeam, 'HORIZONTAL');
    displaySeam(A, verticalSeam, 'VERTICAL'); 
    
end
