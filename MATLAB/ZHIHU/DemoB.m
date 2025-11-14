%控制点
P = [0 0;
    1 2;
    2 2;
    3 0];

%阶数
k=3;

%type
% 1:均匀B样条
% 2:准均匀B样条
% 3:分段Bezier曲线
% 4:非均匀有理B样条 NURBS
type=3;



%drawble
drawable=true;

%绘制spline曲线
BSpline(P,k,2,drawable);
BSpline(P,k,3,drawable);

hold on

%给控制点按顺序打上标记
hold on
for i=1:size(P,1)
    text(P(i,1)+0.05,P(i,2),char(65+i-1));
end

%设置坐标轴标签和范围
figure(1)
xlabel('X','FontSize',20);
ylabel('Y','FontSize',20);
xlim([min(P(:,1))-0.2 max(P(:,1))+0.2]);
ylim([min(P(:,2))-0.2 max(P(:,2))+0.2]);