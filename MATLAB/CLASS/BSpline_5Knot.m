%% 五控制点B样条曲线
% C=[0 1 2 3 4 5 
%    0 1 0 1 0 1];

C=[0 1 2 3 4 5 
   0 0 0 1 1 1];
% 归一化路程
s=0:0.01:1;

% 样条函数
f1s=((1-s).^3)/6;
f2s=(3*s.^3-6*s.^2+4)/6;
f3s=(-3*s.^3+3*s.^2+3*s+1)/6;
f4s=s.^3/6;

n=length(C)-4;
Ps=zeros((n+1)*2,2,length(s));

% 四个控制点的B样条曲线
for  i=0:n
    Ps(i+1,:,:) = C(:,1+i)*f1s + C(:,2+i)*f2s + C(:,3+i)*f3s + C(:,4+i)*f4s;
end


figure(1);

plot(C(1,:),C(2,:), 'r*', 'LineWidth', 2, 'DisplayName', '控制点');
hold on

for  i=0:n
    plot(squeeze(Ps(i+1,1,:)),squeeze(Ps(i+1,2,:)), 'b', 'LineWidth', 2);
end
    
% plot(C(:,1),C(:,2),'r*',Ps_x,Ps_y,'b');


%%
xlabel('X','FontSize',20);
ylabel('Y','FontSize',20);
xlim([min(C(1,:))-0.2 max(C(1,:))+0.2]);
ylim([min(C(2,:))-0.2 max(C(2,:))+0.2]);
title('四个控制点及其B样条曲线')

grid on
