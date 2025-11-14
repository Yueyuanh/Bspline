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
Ps=[Ps_x;Ps_y];

figure(1);

% 绘制控制点连线（红色虚线）
plot(C(:,1), C(:,2), 'r--', 'LineWidth', 1.5, 'DisplayName', '控制多边形');
hold on;

% 绘制控制点（红色星号）
plot(C(:,1), C(:,2), 'r*', 'LineWidth', 2, 'MarkerSize', 10, 'DisplayName', '控制点');

% 绘制原始B样条曲线
plot(Ps_x, Ps_y, 'b', 'LineWidth', 2, 'DisplayName', '原始B样条曲线');

%% 卷积滤波（平滑处理）
% 创建平滑滤波器（高斯滤波器）
filter_size = 5;  % 滤波器大小
sigma = 1;        % 高斯核标准差
gaussian_filter = fspecial('gaussian', [1, filter_size], sigma);

% 对曲线进行卷积滤波
Ps_x_filtered = conv(Ps_x, gaussian_filter, 'same');
Ps_y_filtered = conv(Ps_y, gaussian_filter, 'same');

% 绘制滤波后的曲线
plot(Ps_x_filtered, Ps_y_filtered, 'g--', 'LineWidth', 2, 'DisplayName', '滤波后曲线');

%% 另一种滤波方法：移动平均滤波
% window_size = 7;  % 窗口大小
% ma_filter = ones(1, window_size) / window_size;
% 
% Ps_x_ma = conv(Ps_x, ma_filter, 'same');
% Ps_y_ma = conv(Ps_y, ma_filter, 'same');
% 
% plot(Ps_x_ma, Ps_y_ma, 'm:', 'LineWidth', 2, 'DisplayName', '移动平均滤波');

%% 图形设置
xlabel('X','FontSize',20);
ylabel('Y','FontSize',20);
xlim([min(C(:,1))-0.2 max(C(:,1))+0.2]);
ylim([min(C(:,2))-0.2 max(C(:,2))+0.2]);
legend('Location', 'best');
title('四个控制点及其B样条曲线（含滤波）','FontSize',14);
grid on;
hold off;

%% 显示滤波效果对比
figure(2);
subplot(2,1,1);
plot(s, Ps_x, 'b', 'LineWidth', 1.5, 'DisplayName', '原始X坐标');
hold on;
plot(s, Ps_x_filtered, 'g--', 'LineWidth', 1.5, 'DisplayName', '滤波后X坐标');
ylabel('X坐标');
legend;
title('X坐标滤波前后对比');
grid on;

subplot(2,1,2);
plot(s, Ps_y, 'b', 'LineWidth', 1.5, 'DisplayName', '原始Y坐标');
hold on;
plot(s, Ps_y_filtered, 'g--', 'LineWidth', 1.5, 'DisplayName', '滤波后Y坐标');
xlabel('参数 s');
ylabel('Y坐标');
legend;
title('Y坐标滤波前后对比');
grid on;