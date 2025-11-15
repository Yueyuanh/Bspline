function P=BsplineSE_ATH(C,Aths,Athe,L,Tel)
    % C  增广控制点
    % Co 原控制点

    % 起始点速度
    Vs=[Aths(1)*cos(Aths(2));Aths(1)*sin(Aths(2))];
    Ve=[Athe(1)*cos(Athe(2));Athe(1)*sin(Athe(2))];
    % 轮距
    %L=1;

    % 起始点设置
    c1s=C(:,1)-Vs*L;
    c2s=C(:,1);
    c3s=C(:,1)+Vs*L;

    c1e=C(:,end)-Ve*L;
    c2e=C(:,end);
    c3e=C(:,end)+Ve*L;

    % 重新构建控制点
    Cn=[c1s,c2s,c3s,C(1:2,2:end-1),c1e,c2e,c3e];
    % 归一化路程
    s=0:0.01:1;

    % 样条函数
    f1s=((1-s).^3)/6;
    f2s=(3*s.^3-6*s.^2+4)/6;
    f3s=(-3*s.^3+3*s.^2+3*s+1)/6;
    f4s=s.^3/6;

    n=length(C);
    Ps=zeros((n+1),2,length(s));
%     global P;
    P=zeros(2,length(s)*(n+1));
    
    figure(1);

    mycolor='mbc';
    plot(Cn(1,:),Cn(2,:), 'b*', 'LineWidth', 1, 'DisplayName', '增广点');
    hold on
    plot(C(1,:),C(2,:), 'r*', 'LineWidth', 1, 'DisplayName', '控制点');

   % 速度方向
    inc.Arrow(C(1,1),C(2,1),Vs(1),Vs(2));
%     inc.Arrow(C(1,end),C(2,end),C(1,end)+Ve(1),C(2,end)+Ve(2));
    
    
    % 四个控制点的B样条曲线
    for  i=0:n
        Ps(i+1,:,:) = Cn(:,1+i)*f1s + Cn(:,2+i)*f2s + Cn(:,3+i)*f3s + Cn(:,4+i)*f4s;

        plot(squeeze(Ps(i+1,1,:)), squeeze(Ps(i+1,2,:)), ...
         'Color', mycolor(mod(i,3)+1), ...
         'LineWidth', 2, ...
         'DisplayName', sprintf('第%d段B样条', i+1));
     
         P = [P, [squeeze(Ps(i+1,1,:))'; squeeze(Ps(i+1,2,:))']];
    end

    
    
    xlabel('X','FontSize',20);
    ylabel('Y','FontSize',20);
    xlim([-4 7]);
    ylim([-4 5]);
    axis manual;  % 防止自动调整
    title(sprintf('%s', Tel))
    grid on
    hold off
end