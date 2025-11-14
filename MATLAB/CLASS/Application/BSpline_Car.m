% import inc.BsplineSE_ATH;

addpath('..');  % 添加上一级目录到路径

%% 五控制点B样条曲线
C=[0 0 3 3   
   0 2 2 0  ];

% 起始点速度
Aths=[1;pi/2];
Athe=[1;-pi/2];


% 轮距
L=1;
% 设置窗口位置和大小 [左, 下, 宽, 高]
figure('Position', [100, 100, 1000, 800]);  % 位置[100,100]，大小800×600

subplot(2,2,1);
inc.BsplineSE_ATH(C,Aths,Athe,L,sprintf('起始速度（%.2f，%.2f）三次B样条',Aths(1),Aths(2)));

Aths=[1;0];
Athe=[1;0];
subplot(2,2,2);
inc.BsplineSE_ATH(C,Aths,Athe,L,sprintf('起始速度（%.2f，%.2f）三次B样条',Aths(1),Aths(2)));

Aths=[0.1;pi/2];
Athe=[0.1;-pi/2];
subplot(2,2,3);
inc.BsplineSE_ATH(C,Aths,Athe,L,sprintf('起始速度（%.2f，%.2f）三次B样条',Aths(1),Aths(2)));

Aths=[1;pi];
Athe=[1;-pi];
subplot(2,2,4);
inc.BsplineSE_ATH(C,Aths,Athe,L,sprintf('起始速度（%.2f，%.2f）三次B样条',Aths(1),Aths(2)));


