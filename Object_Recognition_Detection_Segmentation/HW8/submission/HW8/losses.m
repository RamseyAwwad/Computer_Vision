
load('weights_samples.mat');
x = {x1, x2, x3, x4};
w = {W1, W2, W3};


weight_loss = zeros(2,3);

for i = 1:4
   for j=1:3  
       score = w{j} * x{i};
       weight_loss(1,j) = weight_loss(1,j) + hinge_loss(score, i);
       weight_loss(2,j) = weight_loss(2,j) + cross_entropy_loss(score, i);  
   end
end



