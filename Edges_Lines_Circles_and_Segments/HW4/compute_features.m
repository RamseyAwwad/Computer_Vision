function [features] = compute_features(x,y,scores, Ix, Iy)
maxR = size(Ix,1);
maxC = size(Ix,2);

[row,~]=find(x<6 | y<6 | x > maxC-5 | y>maxR-5);
x(row,:) = [];
y(row,:) = [];
scores(row,:) = [];

m = zeros(size(Ix));
angle = zeros(size(m));
bins = zeros(size(m));

for r = 1:maxR
    for  c = 1:maxC
        %find magnitude of r,c coordinates
        m(r,c) = sqrt((Iy(r,c)^2)+(Ix(r,c)^2));
        %determines the orientations
        if m(r,c) ~= 0
            angle(r,c) = atand(Iy(r,c)/Ix(r,c));
        else
            angle(r,c) = 0;
        end
        %classify bin locations by orinentations
        if angle(r,c)>=-90 && angle(r,c)<-67.5
            bins(r,c) = 1;
        elseif angle(r,c)>=-67.5 && angle(r,c) < -45
            bins(r,c) = 2;
        elseif angle(r,c)>=-45 && angle(r,c)< -22.5
            bins(r,c) = 3;
        elseif angle(r,c)>=-22.5 && angle(r,c)< 0
             bins(r,c) = 4;
        elseif angle(r,c)>=0 && angle(r,c)< 22.5
            bins(r,c) = 5;
        elseif angle(r,c)>=22.5 && angle(r,c)< 45
            bins(r,c) = 6;
        elseif angle(r,c)>=45 && angle(r,c)< 67.5
            bins(r,c) =7;
        else
            bins(r,c) = 8;
        end
    end
end
%x keypoints 8 bins
features = zeros(size(x,1),8);
for i = 1:size(x,1)
    hist_final = zeros(1,8);
    for r = -5:5
        for c = -5:5
            %add the m values to their correspoinding bins for this
            %keypoint
            hist_final(1,(bins(y(i)+r,x(i)+c))) = hist_final(1,(bins(y(i)+r,x(i)+c))) + m(y(i)+r,x(i)+c);
        end
    end
    %normalize
    hist_final = hist_final/sum(hist_final);
    %clip to 0.2
    hist_final(hist_final>0.2) = 0.2;
    %norm
    hist_final = hist_final/sum(hist_final);
    features(i,:) = hist_final;
end

end
