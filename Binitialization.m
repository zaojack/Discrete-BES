
function X=Binitialization(N,dim)
X=zeros(N,dim);
for i=1:N
    for j=1:dim
        if rand>0.5
            X(i,j)=0;
        else
            X(i,j)=1;
        end
    end
end
end