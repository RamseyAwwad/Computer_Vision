% Question 1
v = randn(1000000,1)*5;


% Question 2
tic
    for i = 1:size(v)
         v(i) = v(i) + 1; 
    end
toc      % toc prints by default


% Question 3
tic
    v+1; 
time = toc;
fprintf(1, '  Runtime is %f seconds.\n', time); % print function
   

% Question 4
A = reshape(0:99, 10, 10);
B = ones(10);
C = A + B;
assert(all(C(:) == (1:100)') == 1);


% Question 5 
a = 0:99;
b = a(1:2:end);
plot(2.^b);


% Question 6
x=0;
a = (1:10);
z = zeros(1,10);
t1 = tic;
while(x==0)
    randomIndex = randi(length(a),1);
    if(a(randomIndex) >0)
        a(randomIndex)=0;
        t2 = toc;           % to account for time taken until this line..
        pause(1-t2);        % .. we subtract it from 1 and pause for the remainder...
        disp(randomIndex);  % ..and then print.
        tic;
    end
    if (a==z)
        x=1;
    end
end


% Question 7
A = randi([0 9], 5, 3);
B = randi([0 9], 3, 5);
C = zeros(5);

for j = 1:5 % iteration through rows of C and A
    for m = 1:5 % iteration through columns of B
        sum = 0;
        for l = 1:3 % iteration through columns of A and rows B
            temp = A(j,l) * B(l,m);
            sum = sum +temp;
        end 
        C(j,m) = sum; 
    end
end

%{
% Question 8
function [B] = normalize_rows(A)
      
    B = A./repmat(sum(A,2),1,size(A,2)); 
    
end


% Question 9
function [B] = normalize_columns(A)
    
    B = A./repmat(sum(A,1),size(A,1),1);
    
end


% Question 10
function [val] = fib(n)

    i=1;
    j=0;
    k=1;
    
    for x = 1:n        
        %disp(k); % prints out k (for testing)
        k = i+j;
        j = i;
        i = k;
    end
    
    val = k;    
end


% Question 11
function [N] = my_unique(M)
    f = [];
    for i = 1:size(M,1)    
        v = M(i,:); 
        for j = i:size(M,2)    
            if v==M(j,:)
                if j~=i
                    f = [f, j]; 
                end
            end
        end
    end  
    N = M(setdiff(1:size(M,1),f),:);
end
%}

% Question 12
A = imread('pittsburgh.png');

% Question 13
I = rgb2gray(A);

% Question 14
k = find(I==6);
L = logical(k);
sum(L)  % the question on the assigment said "write down" how many pixels 
        % are equal to 6, but I didn't know whether that meant in answers.txt
        % or to print it out to the screen - so I did both.

        
% Question 15
darkestPixel = min(I(:));
[rowVal, colVal] = find(I == darkestPixel);


% Question 16
a = rowVal-15;
b = colVal-15;
c = a+31;
d = b+31;

for j = a:c
    for k = b:d
        I(j,k) = 255;
    end
end


% Question 17
rows = size(I,1);
columns = size(I,2);

centerRow = rows/2;
centerColumn = columns/2;

upperRow = centerRow-121/2-0.5; % here we have to subtract 0.5 to keep it an integer
lowerRow = centerRow+121/2-0.5;                 % ... %
leftmostColumn = centerColumn-121/2-0.5;        % ... %
rightmostColumn = centerColumn+121/2-0.5;       % ... %

I(upperRow:lowerRow, leftmostColumn:rightmostColumn) = 150;


% Question 18
imshow(I);
saveas(gcf, 'new_image.png');


% Question 19
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

vectorR = R(:);
vectorG = G(:);
vectorB = B(:);

meanR = mean(vectorR);
meanG = mean(vectorG);
meanB = mean(vectorB);

newR = R - meanR;
newG = G - meanG;
newB = B - meanB;

rgbImage = cat(3, newR, newG, newB);

imshow(rgbImage);
saveas(gcf, 'mean_sub.png');


