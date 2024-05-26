function [BestSol Convergence_curve timep]=BBES(nPop,MaxIt,low,high,dim,fobj,Bits)
% Euclidean-based
%nPop: size of population 
%MaxIt:number of iterations 
%low, high : space of Decision variables
%dim : number of Decision variables
%fobj : funcation 
 % paper citation : Alsattar, H. A., Zaidan, A. A., & Zaidan, B. B. (2020). Novel meta-heuristic bald eagle search optimisation algorithm. Artificial Intelligence Review, 53(3), 2237-2264.?
st=cputime;
% Initialize Best Solution
BestSol.cost = inf;
% Means = zeros(500,30);

for i=1:nPop
    pop.Bpos(i,:) = rand(1,dim*Bits)>=0.5;
    pop.pos(i,:) = BPos2Pos(pop.Bpos(i,:)', Bits, low, high)';
    pop.cost(i)=fobj(pop.pos(i,:));
    if pop.cost(i) < BestSol.cost
        BestSol.pos = pop.pos(i,:);
        BestSol.Bpos = pop.Bpos(i,:);
        BestSol.cost = pop.cost(i);
    end
end
% 初始化
%  disp(num2str([0 BestSol.cost]))
for t=1:MaxIt
    
    %%               1- select_space 
    [pop BestSol s1(t)]=select_space(fobj,pop,nPop,BestSol,low,high,dim,Bits);
    %%                2- search in space
    [pop BestSol s2(t)]=search_space(fobj,pop,BestSol,nPop,low,high,Bits,dim);
    %%                3- swoop
  [pop BestSol s3(t) mean_ ]=swoop(fobj,pop,BestSol,nPop,low,high,Bits,dim);
        Convergence_curve(t)=BestSol.cost;
%         Means(t,:) = mean_;
%         disp(num2str([t BestSol.cost]))
    ed=cputime;
    timep=ed-st;
end
% disp(num2str([t BestSol.cost]))

function [pop BestSol s1]=select_space(fobj,pop,npop,BestSol,low,high,dim,Bits)
mean_=mean(pop.pos);
mean_ = (mean_-low).*(2^Bits-1)./(high-low);
BMean_ = de2bi(round(mean_),Bits,'left-msb');% 30*8 dim*Bits
BMean = reshape(BMean_,1,[]);
% Empty Structure for Individuals
empty_individual.Bpos = [];
empty_individual.pos = [];
empty_individual.cost = [];
lm= 0.5;
s1=0;
for i=1:npop
    newsol=empty_individual;
    newsol.Bpos= BestSol.Bpos+ lm*rand(1,dim*Bits).*(BMean - pop.Bpos(i,:));
    newsol.Bpos = S(newsol.Bpos);
    newsol.pos = BPos2Pos(newsol.Bpos', Bits, low, high)';
%     newsol.pos = max(newsol.pos, low);
%     newsol.pos = min(newsol.pos, high);
    newsol.cost=fobj(newsol.pos);
    if newsol.cost<pop.cost(i)
        pop.Bpos(i,:) = newsol.Bpos;
       pop.pos(i,:) = newsol.pos;
       pop.cost(i)= newsol.cost;
       s1=s1+1;
         if pop.cost(i) < BestSol.cost
              BestSol.Bpos= pop.Bpos(i,:);
              BestSol.pos= pop.pos(i,:);
              BestSol.cost=pop.cost(i); 
         end
    end
end
end
function [pop best s1]=search_space(fobj,pop,best,npop,low,high,Bits,dim)
mean_=mean(pop.pos);
mean_ = (mean_-low).*(2^Bits-1)./(high-low);
BMean_ = de2bi(round(mean_),Bits,'left-msb');
BMean = reshape(BMean_,1,[]);
a=5;
R=1.5;
% Empty Structure for Individuals
empty_individual.Bpos = [];
empty_individual.pos = [];
empty_individual.cost = [];
s1=0;
for i=1:npop-1
    A=randperm(npop);
    pop.Bpos=pop.Bpos(A,:);
    pop.pos=pop.pos(A,:);
    pop.cost=pop.cost(A);
	[x y]=polr(a,R,npop);
    newsol=empty_individual;
   Step = pop.Bpos(i,:) - pop.Bpos(i+1,:);
   Step1=pop.Bpos(i,:)-BMean;
   newsol.Bpos = pop.Bpos(i,:) +y(i)*Step+x(i)*Step1;
   newsol.Bpos = S(newsol.Bpos);
   newsol.pos = BPos2Pos(newsol.Bpos', Bits, low, high)';
%     newsol.pos = max(newsol.pos, low);
%     newsol.pos = min(newsol.pos, high);
    newsol.cost=fobj(newsol.pos);
    if newsol.cost<pop.cost(i)
        pop.Bpos(i,:) = newsol.Bpos;
       pop.pos(i,:) = newsol.pos;
       pop.cost(i)= newsol.cost;
              s1=s1+1;
                  if pop.cost(i) < best.cost
                 best.Bpos= pop.Bpos(i,:);
                 best.pos= pop.pos(i,:);
                best.cost=pop.cost(i); 
            end
    end
end
end
function [pop best s1 mean_]=swoop(fobj,pop,best,npop,low,high,Bits,dim)
mean_=mean(pop.pos);
mean_ = (mean_-low).*(2^Bits-1)./(high-low);
BMean_ = de2bi(round(mean_),Bits,'left-msb');
BMean = reshape(BMean_,1,[]);
a=2;
R=1.5;
% Empty Structure for Individuals
empty_individual.Bpos = [];
empty_individual.pos = [];
empty_individual.cost = [];
s1=0;
for i=1:npop
    A=randperm(npop);
    pop.Bpos=pop.Bpos(A,:);
    pop.pos=pop.pos(A,:);
    pop.cost=pop.cost(A);
	[x y]=swoo_p(a,R,npop);
    newsol=empty_individual;
   Step = pop.Bpos(i,:) - 2*BMean;
   Step1= pop.Bpos(i,:)-2*best.Bpos;
   newsol.Bpos = rand(1,length(BMean)).*best.Bpos+x(i)*Step+y(i)*Step1;
   newsol.Bpos = S(newsol.Bpos);
   newsol.pos = BPos2Pos(newsol.Bpos', Bits, low, high)';
%     newsol.pos = max(newsol.pos, low);
%     newsol.pos = min(newsol.pos, high);
    newsol.cost=fobj(newsol.pos);
    if newsol.cost<pop.cost(i)
       pop.Bpos(i,:) = newsol.Bpos;
       pop.pos(i,:) = newsol.pos;
       pop.cost(i)= newsol.cost;
              s1=s1+1;
                  if pop.cost(i) < best.cost
                 best.Bpos= pop.Bpos(i,:);
                  best.pos= pop.pos(i,:);
                best.cost=pop.cost(i); 
            end
    end
end
end
function [xR yR]=swoo_p(a,R,N)
th = a*pi*exp(rand(N,1));
r  =th; %R*rand(N,1);
xR = r.*sinh(th);
yR = r.*cosh(th);
 xR=xR/max(abs(xR));
 yR=yR/max(abs(yR));
end
function Y = S(x)
    temp = 1./(1+exp(-20.*(x-0.5)));
    R = rand(1,size(temp,2));
    Y = temp>=R;
end        
        
 function [xR yR]=polr(a,R,N)
%// Set parameters
th = a*pi*rand(N,1);
r  =th+R*rand(N,1);
xR = r.*sin(th);
yR = r.*cos(th);
 xR=xR/max(abs(xR));
 yR=yR/max(abs(yR));
 end
end