function y_final = outputIT3FLS( ...
    R, K, w_lower, w_upper, lower_alpha_k, upper_alpha_k, zStruct )
% =========================================================================
% 函数：outputIT3FLS
% 目标：根据规则激活度 + 后件区间 
%       计算(27),(28)的上下输出，再用(26)加权得到单值输出 y
% =========================================================================

    numerator = 0; 
    denominator = 0;
    
    for k = 1:K
        
        low_alpha   = lower_alpha_k(k);
        up_alpha    = upper_alpha_k(k);
        
        % ------ 计算 upper_f_k (公式(27)) ------
        sum_num_bar = 0;  % 分子
        sum_den_bar = 0;  % 分母
        for l = 1:R
            z_up   = zStruct.zl_Alpha_upper(l, k).z_upper; % \bar{z}^l_{ mu_s= \overline{\alpha}_k }
            z_low = zStruct.zl_Alpha_upper(l, k).z_lower; % z^l_{ mu_s= \overline{\alpha}_k }
            
            sum_num_bar = sum_num_bar + ( z_up * w_upper(l) + z_low * w_lower(l) );
            sum_den_bar = sum_den_bar + ( z_up + z_low );
        end
        if sum_den_bar < 1e-9
            upper_f_k = 0;
        else
            upper_f_k = sum_num_bar / sum_den_bar;
        end
        
        % ------ 计算 loewe_f_k (公式(28)) ------
        sum_num_low = 0;  % 分子
        sum_den_low = 0;  % 分母
        for l = 1:R
            z_up2   = zStruct.zl_Alpha_lower(l, k).z_upper; % \bar{z}^l_{ mu_s= alpha_k }
            z_low2 = zStruct.zl_Alpha_lower(l, k).z_lower; % z^l_{ mu_s= alpha_k }
            
            sum_num_low = sum_num_low + ( z_up2 * w_upper(l) + z_low2 * w_lower(l) );
            sum_den_low = sum_den_low + ( z_up2 + z_low2 );
        end
        if sum_den_low < 1e-9
            lower_f_k = 0;
        else
            lower_f_k = sum_num_low / sum_den_low;
        end
        
        % ------ 做切片加权 (公式(26)) ------
        numerator   = numerator + ( up_alpha * upper_f_k + low_alpha * lower_f_k );
        denominator = denominator + ( up_alpha + low_alpha );
    end % for k = 1:K
    
    if denominator < 1e-9
        y_final = 0;
    else
        y_final = numerator / denominator;
    end
end
