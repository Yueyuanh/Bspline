%% 五控制点B样条曲线
import inc.Bspline;

C=[0 1 2 3 4  
   0 1 0 1 0 ];

% 起始点速度
Vs=[1;0];
Ve=[1;0];
% 轮距
L=1;

% 起始点设置
c1s=C(:,1)-Vs*L;
c2s=C(:,1);
c3s=C(:,1)+Vs*L;

c1e=C(:,end)-Ve*L;
c2e=C(:,end);
c3e=C(:,end)+Ve*L;

% 重新构建控制点
Cn=[c1s,c2s,c3s,C(1:2,2:end-1),c1e,c2e,c3e];

Bspline(Cn);



% n=length(C)-4;
% Ps=zeros((n+1)*2,2,length(s));
% 
% figure(1);
% 
% mycolor='mbc';
% plot(C(1,:),C(2,:), 'r*', 'LineWidth', 2, 'DisplayName', '控制点');
% hold on
% 
% % 四个控制点的B样条曲线
% for  i=0:n
%     Ps(i+1,:,:) = C(:,1+i)*f1s + C(:,2+i)*f2s + C(:,3+i)*f3s + C(:,4+i)*f4s;
%     
%     plot(squeeze(Ps(i+1,1,:)), squeeze(Ps(i+1,2,:)), ...
%      'Color', mycolor(mod(i,3)+1), ...
%      'LineWidth', 2, ...
%      'DisplayName', sprintf('第%d段B样条', i+1));
% end
% 
% 
% 
% 
% %%
% xlabel('X','FontSize',20);
% ylabel('Y','FontSize',20);
% xlim([min(C(1,:))-0.2 max(C(1,:))+0.2]);
% ylim([min(C(2,:))-0.2 max(C(2,:))+0.2]);
% title('四个控制点及其B样条曲线')
% legend('show', 'Location', 'best');
% grid on
