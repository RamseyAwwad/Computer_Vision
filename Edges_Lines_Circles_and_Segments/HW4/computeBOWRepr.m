function [bow_repr] = computeBOWRepr(features, means)
    bow_repr = zeros(1,size(means,1));
    dis= pdist2(features,means); %distance from features to center means
    %find the indexs with the shorteset distance for each feature
    [~,I] = min(dis,[],2);
    %counts how many features were mapped to each cluster
    for i = 1:size(I,1)
        bow_repr(1,I(i,1)) = bow_repr(1,I(i,1))+1;
    end
    %norm
    bow_repr = bow_repr/sum(bow_repr);
end