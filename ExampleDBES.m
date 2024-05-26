% Comparing the performance of different algorithms on CEC2017/2022, with a dimension of 10.
clc
clear
close all
FunNumMax = 1;
Ts = [];
Bestcore = [];
II=0;

for FunNum = 1:FunNumMax
    Function_name = strcat('F',num2str(FunNum)); 
    dim = 10; %  2, 10, 20
    [lb,ub,dim,fobj] = Get_CEC2022_details(Function_name,dim); % 1-12
%     if FunNum ==2
%         continue;
%     end
%     dim = 10;
% The available functions include 2, 10, 30, 50, and 100, with different dimensions for each function. 
% Some dimensions may result in error reports.
%     [lb,ub,dim,fobj] = Get_CEC2017_details(Function_name,dim);% 1-30

    SearchAgents_no=50; 
    Max_iteration=500;
    Bits = 10;
    % Hamming based 
    [BBES2_score, BBES2_curve, timep2] = B_BES2(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Bits);
    % Euclidean based
    [BBES_score, BBES_curve, timep] = BBES(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Bits);
    figure()
    plot(BBES2_curve,'LineWidth',2);hold on;
    plot(BBES_curve,'LineWidth',2);
    legend(["Hamming based","Euclidean based"]);
    title('Objective space')
    xlabel('Iteration');
    ylabel('Best score obtained so far');
end



    
    
    
    
    