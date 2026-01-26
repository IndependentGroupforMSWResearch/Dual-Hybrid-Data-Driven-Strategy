function a = Plot_RF(Y_Actual,Y_Predicted,num)
%UNTITLED3 此处显示有关此函数的摘要
figure (num)
%   此处显示详细说明
% plot(Y_Predicted,'- .','Color',[0.0000,0.4470,0.7410],'LineWidth',1);
% plot(Y_Predicted,'- .','Color',[0.4660,0.6740,0.1880],'LineWidth',1);
plot(Y_Predicted,'b-o','LineWidth',1);
hold on
% plot(Y_Actual,'-o','Color',[0.8500,0.3250,0.0980],'LineWidth',1);
plot(Y_Actual,'r-h','LineWidth',1);
xlabel('Sample');
ylabel('Value');
legend('Predicted value','Actual value');
end

