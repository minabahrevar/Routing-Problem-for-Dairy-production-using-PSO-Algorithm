clc
clear
close all
format shortG

%%  Insert Data

data=InsertData();


%% Parameters Setting

nvar=data.nvar;           % Number of  Variables
nt=data.nt;           % Number of  periods
nc=data.nc;           % Number of  period

lb.x=0*ones(nvar,nt);    % Lower Bound
ub.x=1*ones(nvar,nt);    % Upper Bound

lb.y=0*ones(nc,nt);    % Lower Bound
ub.y=[];
for i=1:nt
ub.y=[ub.y,data.nccap+data.dem(:,i)];    % Upper Bound
end

lb.z=0*ones(1,nt);    % Lower Bound
ub.z=data.npcap*ones(1,nt);    % Upper Bound


lb.v=-1000;             % Lower Bound of Velocity
ub.v= 1000;             % Upper Bound of Velocity

lb.vy=-10000;             % Lower Bound of Velocity
ub.vy= 10000;             % Upper Bound of Velocity

W=1;                % Inertia Weight
W_RF=0.7;          % Inertia Weight Reduction factor
C1=20;               % Personal Best Learning Coefficient
C2=1;               % Global Best Learning Coefficient

C12=20;               % Personal Best Learning Coefficient
C22=1;               % Global Best Learning Coefficient


Npar=20;       % Population Size
Maxiter=50;   % Max Iteration




data.Npar=Npar;
data.lb=lb;
data.ub=ub;

%% Initial Population

tic
[par,emp]=CreateInitialPopulation(data);


bpar=par; % Best Particle

[not,ind]=min([par.fit]);
gpar=par(ind); % Global Particle


%% Main Loop 

BEST=zeros(Maxiter,1);
MEAN=zeros(Maxiter,1);


for iter=1:Maxiter
    
    
    for i=1:Npar
        
        % Update Velocity x
        par(i).v=1*W*par(i).v+...
            C1*rand(nvar,nt).*(bpar(i).x-par(i).x)+...
            C2*rand(nvar,nt).*(gpar.x-par(i).x);
        
        
        par(i).v=CB(par(i).v,lb.v,ub.v); % Check Bound
        
         
        % Update Position x
        par(i).x=par(i).x+par(i).v;
        
        % Update Velocity y
        par(i).vy=W*par(i).vy+...
            C12*rand(nc,nt).*(bpar(i).y-par(i).y)+...
            C22*rand(nc,nt).*(gpar.y-par(i).y);

        par(i).vy=CB(par(i).vy,lb.vy,ub.vy); % Check Bound
        
        % Update Position y
        par(i).y=par(i).y+par(i).vy;
        
        % Update Velocity z
        par(i).vz=W*par(i).vz+...
            C12*rand(1,nt).*(bpar(i).z-par(i).z)+...
            C22*rand(1,nt).*(gpar.z-par(i).z);

        par(i).vz=CB(par(i).vz,lb.vy,ub.vy); % Check Bound
        
        % Update Position z
        par(i).z=par(i).z+par(i).vz;
        
        
        % Cal Fitness
        par(i)=fitness(par(i),data);
        
        
        % Update gpar and bpar
        
        if par(i).fit<bpar(i).fit
            bpar(i)=par(i);
            
            if par(i).fit<gpar.fit
                gpar=par(i);
            end
        end
        
        
        
    end
    
    
    
    
    BEST(iter)=gpar.fit;
    MEAN(iter)=mean([bpar.fit]);
    
    NO=' Feasible';
    if gpar.SCH>0
        NO=' Infeasible';
    end
    
    disp([ 'Iter = ' num2str(iter) ' BEST = ' num2str(BEST(iter)) NO ])
    
    
    W=W*W_RF;
    
    
  % Plot Best Solution
   
    
end
%% Results


disp([ ' Best Fitness = ' num2str(gpar.fit), num2str(toc) ])
disp([ ' Time = ' num2str(toc) ])
disp([ ' z1 = ' num2str(gpar.info.costz1) ])
disp([ ' z2 = ' num2str(gpar.info.totaldemz2) ])

figure
%semilogy(BEST,'r')
plot(BEST,'r')

xlabel('Iteration ')
ylabel(' Fitness ')
legend('BEST')
title('PSO')

