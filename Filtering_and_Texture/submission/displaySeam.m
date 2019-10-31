function displaySeam(im, seam, seamDirection)
% display the selected type of seam on top of the input image
% im should be the result of an imread
% seamDirection should be the string 'HORIZONTAL' or 'VERTICAL'
% seam should be the output of find_optimal_vertical_seam or find_optimal_horizontal_seam (which are provided separately)

    if(strcmp(seamDirection, 'VERTICAL'))
        rows = linspace(1,length(seam),length(seam));
        lineSpec = 'yellow';
         % Display image with seem ontop of it
        figure,imshow(im)
        hold on;
        plot(seam,rows, lineSpec);
        hold off;
    else 
        assert(strcmp(seamDirection, 'HORIZONTAL'));
        cols = linspace(1,length(seam),length(seam));
        lineSpec = 'red';
         % Display image with seem ontop of it
        figure, imshow(im)
        hold on;
        plot(cols,seam, lineSpec);
        hold off;
    end
end
