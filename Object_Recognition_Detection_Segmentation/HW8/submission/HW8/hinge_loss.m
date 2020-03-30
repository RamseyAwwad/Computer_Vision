function [loss] = hinge_loss(scores, correct_class)

incorrect_scores = scores;
incorrect_scores(correct_class) = [];

loss = 0;
for i = 1:3
   loss = loss + max(0, incorrect_scores(i)-scores(correct_class)+1); 
end

end