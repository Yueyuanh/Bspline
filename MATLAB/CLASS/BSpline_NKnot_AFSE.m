import inc.BsplineSE_ATH;

%% 五控制点B样条曲线
C=[0 1 2 3 4  
   0 1 0 1 0 ];

% 起始点速度
% Aths=[1;pi];
% Athe=[1;0];

% 轮距
L=1;
% 设置窗口位置和大小 [左, 下, 宽, 高]
figure('Position', [100, 100, 1000, 800]);  % 位置[100,100]，大小800×600

for a=0.5:0.25:2
    for i=0:pi/36:2*pi
        Aths=[a+(i/2*pi*0.025);i];
        Athe=[1;0];
        ps=BsplineSE_ATH(C,Aths,Athe,L,sprintf('起始速度（%.2f，%.2f）三次B样条',a+(i/2*pi*0.025),i));
        disp(dps)
    end
end
