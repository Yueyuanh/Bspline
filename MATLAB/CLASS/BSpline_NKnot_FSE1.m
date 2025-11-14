import inc.BsplineSE;

%% 五控制点B样条曲线
C=[0 1 2 3 4  
   0 1 0 1 0 ];

% 起始点速度
Vs=[1;0];
Ve=[1;0];

% 轮距
L=1;

BsplineSE(C,Vs,Ve,L,'起始速度（1，0）三次B样条');

