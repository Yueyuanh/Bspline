%% 四控制点B样条曲线
C=[0 0;
   1 1;
   2 1;
   3 0];

% 归一化路程
s=0:0.01:1;

% 样条函数
f1s=((1-s).^3)/6;
f2s=(3*s.^3-6*s.^2+4)/6;
f3s=(-3*s.^3+3*s.^2+3*s+1)/6;
f4s=s.^3/6;

plot(f1s,s,f2s,s,f3s,s,f4s,s,'LineWidth', 2);
% 添加图例和标签
legend('B_{1,3}(s)', 'B_{2,3}(s)', 'B_{3,3}(s)', 'B_{4,3}(s)', 'Location', 'best');

axis equal; grid on;
grid on