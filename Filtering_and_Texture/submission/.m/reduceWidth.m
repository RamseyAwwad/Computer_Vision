function [reducedColorImage] = reduceWidth(im, display_flag)

    reducedColorImage = im;
    [energyImage, Ix, Iy] = energy_image(im);
    M = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
    seam = find_optimal_vertical_seam(M);
    
    if(display_flag == 1) 
        figure;
        hold on;
        subplot(1,3,1);
        imagesc(energyImage);
        subplot(1,3,2);
        imagesc(M);
        subplot(1,3,3);
        imagesc(displaySeam(im, seam, 'VERTICAL'));
    end

    row = reducedColorImage(1,:,:);
    row(:,seam(1),:) = [];
    newI = row;
    for s = 2:length(seam)
        row = reducedColorImage(s,:,:);
        row(:,seam(s),:) = [];
        newI = [newI; row];
    end
    reducedColorImage = newI;   
end
