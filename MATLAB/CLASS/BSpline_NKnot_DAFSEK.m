import inc.BsplineSE_ATH;

%% 五控制点B样条曲线
C=[0 1 2 3 4  
   0 1 0 1 0 ];

% 起始点速度
Aths=[1;pi];
Athe=[1;0];

% 轮距
L=1;
% 设置窗口位置和大小 [左, 下, 宽, 高]
figure('Position', [100, 100, 1000, 800]);  % 位置[100,100]，大小800×600

% for a=0.5:0.25:2
a=1;
     for i=0:pi/36:2*pi
% i=0;
        Aths=[a+(i/2*pi*0.025);i];
        Athe=[1;pi];
        subplot(2,1,1);
        p=BsplineSE_ATH(C,Aths,Athe,L,sprintf('起始速度（%.2f，%.2f）三次B样条',a+(i/2*pi*0.025),i));
        
      % 计算参数t（通常使用索引或累积弧长）
        % 改进的参数化：使用累积弦长
        dx = diff(p(1,:));
        dy = diff(p(2,:));
        ds = sqrt(dx.^2 + dy.^2);
        arc_length = cumsum([0, ds]);
        t = arc_length;
        
        % 计算关于参数t的导数
        dx_dt = gradient(p(1,:), t);
        dy_dt = gradient(p(2,:), t);
        subplot(2,1,2);

        % 速度向量（一阶导数）
        velocity=atan2(dy_dt,dx_dt);
%         plot(t,velocity);
        
        % 加速度向量（二阶导数）
        d2x_dt2 = gradient(dx_dt, t);
        d2y_dt2 = gradient(dy_dt, t);
%         acceleration = sqrt(d2x_dt2.^2 + d2y_dt2.^2);
        
        %% 曲率k
%         k=(dx_dt.*d2y_dt2  -  d2x_dt2.*dy_dt)./(sqrt(dx_dt.^2 + dy_dt.^2).^3);

        % 分子：x'y'' - y'x''
        numerator = dx_dt .* d2y_dt2 - d2x_dt2 .* dy_dt;

        % 分母：(x'? + y'?)^(3/2)
        denominator = (dx_dt.^2 + dy_dt.^2).^(3/2);

        % 避免除零错误
        epsilon = 1e-10;
        denominator(denominator < epsilon) = epsilon;

        % 曲率
        curvature = numerator ./ denominator;
        plot(t,curvature);
     end
% end
