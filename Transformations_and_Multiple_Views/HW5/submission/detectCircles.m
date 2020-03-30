function [centers] = detectCircles(im, edges, radius, top_k)

[m,n,~] = size(im);
H = zeros(m,n);

[c,d] = size(edges);

for i=1:c
    x = edges(i,1);
    y = edges(i,2);
    theta = edges(i,4);
    
    % derive center points
    a = y - radius*sind(theta);
    b = x - radius*cosd(theta);
    
    
    a = uint16(a);
    b = uint16(b);
    
    if ~(a<1 || b<1 || a>m || b>n) % make sure that H(a,b) is within the image and not out of bounds
        H(a,b) = H(a,b)+1;
    end 
end

[B,I] = maxk(H(:),top_k); % B is the maximum values in H and I is the index of each of those maximums

centers = zeros(top_k,2);

% converting 2d column vector [B,I] back to a 3d matrix
for i=1:top_k
   x = I(i)/m;
   x = uint16(x);
   y = mod(I(i),m);
   
   centers(i,1) = x;
   centers(i,2) = y;
end

figure; 
imshow(im); 
viscircles(centers, radius * ones(size(centers, 1), 1));

end