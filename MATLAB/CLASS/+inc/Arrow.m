function Arrow(x1, y1, x2, y2)
    % 绘制线段
    plot([x1, x2], [y1, y2], 'k-', 'LineWidth', 1);
    
    % 计算箭头方向
    dx = x2 - x1;
    dy = y2 - y1;
    angle = atan2(dy, dx);
    
    % 箭头头部参数
    head_length = 0.2 * norm([dx, dy]);
    head_angle = pi/6;
    
    % 计算箭头头部的两个点
    x3 = x2 - head_length * cos(angle - head_angle);
    y3 = y2 - head_length * sin(angle - head_angle);
    x4 = x2 - head_length * cos(angle + head_angle);
    y4 = y2 - head_length * sin(angle + head_angle);
    
    % 绘制箭头头部
    plot([x2, x3], [y2, y3], 'k-', 'LineWidth', 1);
    plot([x2, x4], [y2, y4], 'k-', 'LineWidth', 1);
end