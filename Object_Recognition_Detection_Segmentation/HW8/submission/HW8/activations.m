% D=4 M=3 K=2
% D is the inputs, M is the hidden layer, K is the outputs

x = [10, 1, 2, 3];
w1 = [0.5, 0.6, 0.4, 0.3, 0.02, 0.25, 0.4, 0.3, 0.82, 0.1, 0.35, 0.3];
w2 = [0.7, 0.45, 0.5, 0.17, 0.9, 0.8];

% compute value of z2
z2 = x*w1';
z2 = tanh(z2);
disp(z2(2));
% compute value of y1
RELU = max(0,x*w1');
% RELU is now the z nodes in the hidden layer



