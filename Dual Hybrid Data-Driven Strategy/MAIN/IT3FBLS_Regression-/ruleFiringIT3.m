function zStruct = ruleFiringIT3(x_input, membershipData, lower_alpha_k, upper_alpha_k)
% =========================================================================
% 函数：ruleFiringIT3
% 目标：对给定的输入 x_input(1..n)、已计算的 membershipData{i,j}，
%       以及所有规则 j=1..M，在各个二级切片 lower_alpha_k / upper_alpha_k 下
%       计算 "上激活度" \bar{z}^l 与 "下激活度" z^l (公式(22)~(25)).
%
% 在此过程中，需要用到论文中公式(12)~(15)
% =========================================================================

    % 取输入维度 n, 规则数 M (可以从 membershipData 解析)
    [n, M] = size(membershipData);
    
    % 设 T-norm = product (也可用 min)
    Tnorm = @(vals) prod(vals);
    
    % 准备存储
    zStruct = struct();
    
    % ---- 遍历 k=1..K(长度 alpha_k_vals) ----
    K = length(lower_alpha_k);
    for k = 1:K % 第k个切片的隶属度计算
        
        low_alpha_k = lower_alpha_k(k);
        up_bar_alpha_k = upper_alpha_k(k);
        
        for l = 1:M
            % 对第 l 条规则：它的前件对应每个输入 i=1..n 的三型模糊集
            % 需要把 "上/下隶属度" 聚合 => "上/下激活度"
            % ============ 依照(12)~(15) 思路，计算 "上隶属度" 与 "下隶属度"  ============
            
            mu_upper_Alpha_upper = zeros(1,n); 
            mu_lower_Alpha_upper = zeros(1,n);  
            mu_upper_Alpha_lower    = zeros(1,n); 
            mu_lower_Alpha_lower    = zeros(1,n); 
            
            for i = 1:n
                % 取出在 alpha_0 下的 mA_alpha0, sigmaVi_sq
                mA_alpha0    = membershipData{i,l}.mA_alpha0;
                sigmaVi_sq   = membershipData{i,l}.sigmaVi_sq;
                
                % ========== 计算第k个Alpha_upper的偏移项 ==========
                addTerm_Alpha_upper = sqrt( log(1 / up_bar_alpha_k) * sigmaVi_sq );
                
                % 公式(12)  
                mu_upper_Alpha_upper(i) = mA_alpha0 + addTerm_Alpha_upper;
                % 公式(13)  
                mu_lower_Alpha_upper(i) = mA_alpha0 - addTerm_Alpha_upper;
                
                % ========== 计算第k个Alpha_lower的偏移项 ==========
                addTerm_alpha_lower = sqrt( log(1 / low_alpha_k) * sigmaVi_sq );
                % 公式(14)  
                mu_upper_Alpha_lower(i) = mA_alpha0 + addTerm_alpha_lower;
                % 公式(15)  
                mu_lower_Alpha_lower(i) = mA_alpha0 - addTerm_alpha_lower;
                
                % 注意：在论文中，这些 mu 值可能需要截断在 [0,1] 范围
                %       避免出现<0 或 >1 的情况
                mu_upper_Alpha_upper(i) = max(0, min(1, mu_upper_Alpha_upper(i)));
                mu_lower_Alpha_upper(i) = max(0, min(1, mu_lower_Alpha_upper(i)));
                mu_upper_Alpha_lower(i)    = max(0, min(1, mu_upper_Alpha_lower(i)));
                mu_lower_Alpha_lower(i)    = max(0, min(1, mu_lower_Alpha_lower(i)));
            end
            
            % ============ 用 T-norm 聚合 => 上/下激活度 ============
            % 公式(22)
            z_upper_Alpha_upper = Tnorm(mu_upper_Alpha_upper);
            % 公式(23) 
            z_lower_Alpha_upper = Tnorm(mu_lower_Alpha_upper);
            % 公式(24)
            z_upper_Alpha_lower = Tnorm(mu_upper_Alpha_lower);
            % 公式(25)
            z_lower_Alpha_lower = Tnorm(mu_lower_Alpha_lower);
            
            % ============ 存储 ============
            zStruct.zl_Alpha_upper(l, k).z_upper = z_upper_Alpha_upper;
            zStruct.zl_Alpha_upper(l, k).z_lower = z_lower_Alpha_upper;
            zStruct.zl_Alpha_lower(l, k).z_upper    = z_upper_Alpha_lower;
            zStruct.zl_Alpha_lower(l, k).z_lower    = z_lower_Alpha_lower;
            
        end % for l=1..M
    end % for k=1..K
end
