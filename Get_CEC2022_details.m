
% ----------------------- README ------------------------------------------
% -------------- 最后一次修改：2023/11/24 ---------------------------------
% -------------------  欢迎关注₍^.^₎♡  ------------------------------------
% -------------- 项目：CEC测试函数合集  -----------------------------------
% -------------- 微信公众号：KAU的云实验台(可咨询定制) ---------------------
% -------------- CSDN：KAU的云实验台 --------------------------------------
% -------------- 付费代码：https://mbd.pub/o/author-a2iWlGtpZA== ----------
% -------------- 免费代码：公众号后台回复"资源" ---------------------------
% -------------------------------------------------------------------------


function [lb,ub,dim,fobj] = Get_CEC2022_details(F,dim)

switch F
    case 'F1'

        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',1); 
        
    case 'F2'

        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',2); 
        
    case 'F3'

        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',3); 
        
        
    case 'F4'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',4); 
        
    case 'F5'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',5); 
        
        
    case 'F6'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',6); 
        
    case 'F7'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',7); 
        
    case 'F8'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',8); 
        
    case 'F9'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',9); 
        
    case 'F10'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',10); 
        
    case 'F11'
        
        lb=-600*ones(1,dim);
        ub=600*ones(1,dim);
        fobj = @(x) cec22_func(x',11); 
        
    case 'F12'
        
        lb=-100*ones(1,dim);
        ub=100*ones(1,dim);
        fobj = @(x) cec22_func(x',12);        
  
        
end

end
