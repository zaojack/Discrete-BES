function Position = BPos2Pos(BPosition, Bits, lb, ub)

%BPos2Pos Converting binary positions to decimal positions facilitates the calculation of the fitness function.
noP = size(BPosition,2);%粒子数量
noD = size(BPosition,1)/Bits; % 问题的维度
Position = zeros(noD, noP);
for ii = 1:noP
    temp_ = TransBin(BPosition(:,ii),Bits);
%     The above conversion from binary to decimal has been completed. Next, we need to perform range mapping.
    Position(:,ii) = temp_.*(ub'-lb')./(2^Bits-1)+lb';
end


    function P = TransBin(BP, Bits)
        P = zeros(size(BP,1)/Bits,1);
        for kk = 1:size(BP,1)/Bits
            Temp = BP((kk-1)*Bits+1:Bits*kk);
            P(kk,1) = Mybin2dec(Temp,Bits);    
        end
    end
    function Ans = Mybin2dec(Temp,Bits)
        Ans = 0;
        for jj = 1:Bits
            if Temp(jj) ==0 || Temp(jj)==1
                Ans = Ans + 2^(Bits-jj)*Temp(jj);
            else
                disp("NOT zero OR one !!!!");
            end
            
        end
    end
end

