function memStruct = computeMembershipIT3(x_i, param, alpha_0)
% =========================================================================
% 函数：computeMembershipIT3
% 论文：An Interval Type-3 Fuzzy System and a New Online Fractional-Order Learning Algorithm: Theory and Practice
% 目标：根据给定的高斯参数 + 输入 x_i + 基准水平 alpha_0，
%       计算并存储三型模糊集在此处的一些关键量：
%         - muUpper_alpha0, muLower_alpha0 : 上/下隶属度(公式(19),(20))
%         - mA_alpha0                     : 中心值(18)
%         - sigmaVi_sq                    : 对应 (17) 推出的方差
%         - 以及为计算 alpha_k / overline_alpha_k 时做准备的函数 handle（见下示例）
%
% 对应论文中公式以及(17)-(20): 
% =========================================================================

    % 高斯参数
    C         = param.C;        % 中心
    sigUpper  = param.sigUp;    % 上宽度
    sigLower  = param.siglow;   % 下宽度
    
    % 1) 计算在 alpha_0 水平下的 "上下隶属度"
    muUpper_alpha0 = exp( - (x_i - C)^2 / (sigUpper^2) );
    muLower_alpha0 = exp( - (x_i - C)^2 / (sigLower^2) );
    
    % 2) 中心值 mA_alpha0
    mA_alpha0 = (muUpper_alpha0 + muLower_alpha0)/2;
    
    % 3) 根据 (17)，计算二级不确定性方差 sigmaVi_sq
    %    其中需要 ln(1/ε)，设 ε = 0.01
    eps_val = 0.01;
    numerator = (muLower_alpha0 - mA_alpha0)^2;  % ( \underline{\mu}_{A}|_{\alpha_0} - m_{A}|_{\alpha_0} )^2
    denominator = log(1/eps_val);               % ln(1/ε)
    sigmaVi_sq = numerator / denominator;
    if sigmaVi_sq < 0, sigmaVi_sq = 0; end  % 避免负值
    
    % 封装
    memStruct.muUpper_alpha0 = muUpper_alpha0;
    memStruct.muLower_alpha0 = muLower_alpha0;
    memStruct.mA_alpha0      = mA_alpha0;
    memStruct.sigmaVi_sq     = sigmaVi_sq;
    memStruct.C              = C;
    memStruct.sigUp          = sigUpper;
    memStruct.siglow         = sigLower;
    
end
