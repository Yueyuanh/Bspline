import inc.BsplineSE_ATH;
%% 五控制点B样条曲线
C = [0 1 2 3 4  
     0 1 0 1 0 ];

% 轮距
L = 1;

% 设置窗口位置和大小
figure('Position', [100, 100, 1000, 800]);

% 设置GIF文件名
filename = 'Bspline_animation1.gif';

% 设置延迟时间（秒）
delay_time = 0.1;

frame_count = 0;
for a = 0.5:0.25:2
    for i = 0:pi/24:2*pi
        Aths = [a+(i/2*pi*0.025); i];
        Athe = [1; 0];
       
        % 清除当前图形
        clf;
        
        % 绘制B样条曲线
        BsplineSE_ATH(C, Aths, Athe, L, sprintf('起始速度 (%.2f, %.2f) 三次B样条', a+(i/2*pi*0.025), i));
        
        
        
        % 捕获当前帧
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        
        % 写入GIF文件
        if frame_count == 0
            % 第一帧
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', delay_time);
        else
            % 后续帧
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delay_time);
        end
        
        frame_count = frame_count + 1;
        
        % 可选：显示进度
        fprintf('已生成 %d 帧\n', frame_count);
    end
end

fprintf('动画已保存为: %s\n', filename);