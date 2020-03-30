function [loss] = cross_entropy_loss(scores, correct_class)

scores = exp(scores);
sum_scores = sum(scores);
scores = scores/sum_scores;

loss = -log(scores(correct_class));

end