import inc.BsplineSE;

%% 五控制点B样条曲线
C=[0 1 2 3 4  
   0 1 0 1 0 ];

% 起始点速度
Vs=[1;0];
Ve=[1;0];

Vs2=[0.5;0.5];
Ve2=[1;0];

Vs3=[-0.5;0.5];
Ve3=[1;0];

Vs4=[0.5;-0.5];
Ve4=[1;0];

% 轮距
L=1;

subplot(2,2,1);
BsplineSE(C,Vs,Ve,L,'起始速度（1，0）三次B样条');

subplot(2,2,2);
BsplineSE(C,Vs2,Ve2,L,'起始速度（0.5，0.5）三次B样条');

subplot(2,2,3);
BsplineSE(C,Vs3,Ve3,L,'起始速度（-0.5，0.5）三次B样条');

subplot(2,2,4);
BsplineSE(C,Vs4,Ve4,L,'起始速度（0.5，-0.5）三次B样条');
