function v_col = computeEdgePotential1D(colData, sigma)
% 计算 1D 节点输出 的信息势 V(q_l), 
% colData: [N x 1]
% sigma: kernel带宽
    N = length(colData);
    sumVal = 0;
    for i=1:N
        for j=1:N
            diff_ij = colData(j) - colData(i);
            sumVal = sumVal + gaussKernel(diff_ij, sqrt(2)*sigma);
        end
    end
    v_col = sumVal / (N^2);
end

function val = gaussKernel(x, band)
    val = 1/(sqrt(2*pi)*band) * exp(-0.5*(x^2)/(band^2));
end
