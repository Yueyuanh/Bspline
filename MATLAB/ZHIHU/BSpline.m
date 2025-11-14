function [C]=BSpline(varargin)
    narginchk(1,7);
    
    ctrls=varargin{1};    % 控制点
    k=varargin{2};        % 阶数
    flag=varargin{3};     % 形式
    drawable=varargin{4}; % 是否绘图  
    
    weights=ones(size(ctrls,1),1)*(1/size(ctrls,1));
    n=size(ctrls,1)-1;
    switch flag
        case 1
            NodeVector = linspace(0, 1, n+k+2); % 均匀B样条的节点矢量           
        case 2
            NodeVector = U_quasi_uniform(n, k); % 准均匀B样条的节点矢量   
        case 3
            NodeVector = U_piecewise_Bezier(n, k); % 分段Bezier曲线的节点矢量
        case 4
            NodeVector=varargin{5}; %非均匀有理B样条 NURBS
            weights=varargin{6}; 
        otherwise
            fprintf('error!\n');
    end
        
    C=BSpline_gen(ctrls,n,k,NodeVector,0.001,weights);
  
  %绘制结果
    if drawable
        DisSpline(ctrls, n,C);
    end
 
end

function DisSpline(ctrls, n, C)
    % DISSPLINE 显示B样条曲线
    % 输入：
    %   ctrls - 控制点
    %   n     - 控制点数量减1（用于接口兼容）
    %   C     - B样条曲线点

    figure;
    hold on;
    grid on;
    
    % 绘制控制点和控制多边形
    plot(ctrls(:,1), ctrls(:,2), 'ro-', 'LineWidth', 1.5, 'MarkerSize', 8, ...
         'DisplayName', '控制多边形');
    
    % 绘制B样条曲线
    plot(C(1,:), C(2,:), 'b-', 'LineWidth', 2, 'DisplayName', 'B样条曲线');
    
    % 设置图形属性
    title(sprintf('B样条曲线 (控制点: %d)', size(ctrls, 1)));
    legend('Location', 'best');
    axis equal;
    
    hold off;
end
%% B-spline Generator
function [C]=BSpline_gen(vertices,n,k,NodeVector,accuracy,weights)
     
     %n=size(veritces,1);
     Nik_w=zeros(1,n);
     if NodeVector(2)~=0&&NodeVector(end-1)~=1%均匀B样条
        offset=k/(n+k+1); %由于均匀B样条的性质，起始和结束的拟合效果不好，一般舍弃掉         
     else   
        offset=0;
     end
    
     count=1;
     C=zeros(2,int8((1-2*offset)/accuracy));  
     for u =0+offset : accuracy :1- offset-accuracy
         Dom=0;
          for i = 0 : 1 : n
              weights(i+1,1)
             Nik_w(1, i+1) = BaseFunction(i, k , u, NodeVector)*weights(i+1,1);
             Dom=Dom+Nik_w(1,1+i);
          end        
          C(:,count)=  (Nik_w/Dom)*vertices;
          count=count+1;
     end

end

%% 计算基函数Ni,k(u),NodeVector为节点向量
function Nik_u = BaseFunction(i, k , u, NodeVector)

    if k == 0       % 0次B样条
        if (u >= NodeVector(i+1)) && (u < NodeVector(i+2))
            Nik_u = 1.0;
        else
            Nik_u = 0.0;
        end
    else
        % 支撑区间的长度
        Length1 = NodeVector(i+k+1) - NodeVector(i+1);
        Length2 = NodeVector(i+k+2) - NodeVector(i+2);      

         % 规定0/0 = 0
        if Length1 == 0.0      
            Length1 = 1.0;
        end
        if Length2 == 0.0
            Length2 = 1.0;
        end

        %递归计算
        Nik_u = (u - NodeVector(i+1)) / Length1 * BaseFunction(i, k-1, u, NodeVector) ...
            + (NodeVector(i+k+2) - u) / Length2 * BaseFunction(i+1, k-1, u, NodeVector);
    end
end

%% 分段Bezier-节点向量生成函数
function NodeVector = U_piecewise_Bezier(n, k)
% 分段Bezier曲线的节点向量计算，共n+1个控制顶点，k次B样条
% 分段Bezier端节点重复度为k+1，内间节点重复度为k,且满足n/k为正整数

    if ~mod(n, k) && (~mod(k, 1) && k>=1)   % 满足n是k的整数倍且k为正整数
        NodeVector = zeros(1, n+k+2);   % 节点矢量长度为n+k+2（控制点+阶数+1）
        NodeVector(1, n+2 : n+k+2) = ones(1, k+1);  % 右端节点置1

        piecewise = n / k;      % 设定内节点的值
        Flg = 0;
        if piecewise > 1
            for i = 2 : piecewise
                for j = 1 : k
                    NodeVector(1, k+1 + Flg*k+j) = (i-1)/piecewise;
                end
                Flg = Flg + 1;
            end
        end

    else
        fprintf('error!\n');
    end
end

%% 准均匀-节点向量生成函数
function NodeVector = U_quasi_uniform(n, k)
% 准均匀B样条的节点向量计算，共n+1个控制顶点，k次B样条
NodeVector = zeros(1, n+k+2);
piecewise = n - k + 1;       % 有效曲线的段数 起始的k+1段都是0，结尾k+1段都是1（重复度k+1）
if piecewise == 1       % 只有一段曲线时，n = k
    for i = n+2 : n+k+2
        NodeVector(1, i) = 1;
    end
else
    flag = 1;       % 不止一段曲线时
    while flag ~= piecewise
        NodeVector(1, k+1+flag) = NodeVector(1, k + flag) + 1/piecewise;
        flag = flag + 1;
    end
    NodeVector(1, n+2 : n+k+2) = 1;
end
end