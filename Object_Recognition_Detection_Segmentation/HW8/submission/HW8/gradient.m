h=0.0001;
load('weights_samples.mat');

% w+h vector (first dimension)
Wh = W1;
% gradient (derivative) vector
dW = W1;

gradient_matrix = zeros(4,25);
x_array = {x1, x2, x3, x4};

for i = 1:4
    
    loss = hinge_loss(W1*x_array{i}, i);
    
    for j = 1:size(W1,1)
        
        for k = 1:size(W1,2)
            W = W1;
            W(j,k) = W(j,k)+h;
            hinge = hinge_loss(W*x_array{i}, i);

            g = (hinge-loss)/h;

            gradient_matrix(j,k) = gradient_matrix(j,k)+g;
        end

    end
end

gradient_matrix = gradient_matrix./4;

W1 = W1 - 0.001*gradient_matrix;
