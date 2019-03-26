function plotData(x,y)

figure;
hold on;

pos = find(y == 1);
neg = find(y == 0);

plot(x(pos,1),x(pos,2),'k+','LineWidth', 2, 'MarkerSize', 7);
plot(x(neg,1),x(neg,2), 'ko', 'MarkerFaceColor', 'y','MarkerSize', 7);
end

