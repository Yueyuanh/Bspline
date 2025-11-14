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

% 四个控制点的B样条曲线
Ps_x = C(1,1)*f1s + C(2,1)*f2s + C(3,1)*f3s + C(4,1)*f4s;
Ps_y = C(1,2)*f1s + C(2,2)*f2s + C(3,2)*f3s + C(4,2)*f4s;
Ps=[Ps_x,Ps_y];

figure(1);

plot(C(:,1),C(:,2), 'r*', 'LineWidth', 2, 'DisplayName', '控制点');
hold on
plot(Ps_x,Ps_y, 'b', 'LineWidth', 2, 'DisplayName', 'B样条曲线');
    
% plot(C(:,1),C(:,2),'r*',Ps_x,Ps_y,'b');


%%
xlabel('X','FontSize',20);
ylabel('Y','FontSize',20);
xlim([min(C(:,1))-0.2 max(C(:,1))+0.2]);
ylim([min(C(:,2))-0.2 max(C(:,2))+0.2]);
legend('控制点','B样条曲线')
title('四个控制点及其B样条曲线')
grid on
