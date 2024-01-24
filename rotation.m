%% Rotation

startX = 0; startY = 0; 

endPt = randi([-300,300],[1,2])

theta = [6 12 18 24 30];

for ii = 1:length(theta)
    roTarg(ii,1) = (endPt(1)-startX)*cosd(theta(ii))-(endPt(2)-startY)*sind(theta(ii))+startX;
    roTarg(ii,2) = (endPt(1)-startX)*sind(theta(ii))+(endPt(2)-startY)*cosd(theta(ii))+startY;
end

%% Shift
for ii = 1:length(theta)
eucDist(ii) = sqrt(sum((endPt - roTarg(ii,:)).^2));
xVals(ii,:) = [endPt(1)-eucDist(ii),endPt(2)];
end
 
%% Gain
lenReach = sqrt(sum((endPt - [startX startY]).^2));
unitReach = endPt/lenReach;
for ii = 1:length(theta)
    newLen1 = lenReach + eucDist(ii);
    newLen2 = lenReach - eucDist(ii);
    plusGain(ii,:) = (unitReach*newLen1) + [startX startY];
    minusGain(ii,:) = (unitReach*newLen2) + [startX startY];
end

%% test distances
eucDist = round(eucDist,2);
shiftDist = round(sqrt(sum((endPt - xVals).^2,2)),2)';
gainDist = round(sqrt(sum((endPt - plusGain).^2,2)),2)';

shiftDist == eucDist
shiftDist == gainDist
gainDist == eucDist

%% plot
figure; hold on
scatter(startX,startY,50,'filled')
scatter(endPt(1),endPt(2),50,'filled')
scatter(roTarg(:,1),roTarg(:,2),50,'filled')
scatter(xVals(:,1),xVals(:,2),50,'filled')
scatter(plusGain(:,1),plusGain(:,2),50,'filled')
xlim([-400 500])
ylim([0 500])
axis square
axis equal

