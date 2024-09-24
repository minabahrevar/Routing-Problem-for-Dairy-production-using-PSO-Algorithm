function [par,emp]=CreateInitialPopulation(data)

Npar=data.Npar;
lb=data.lb;
ub=data.ub;

emp.x=[];
emp.y=[];
emp.z=[];
emp.v=[];
emp.vy=[];
emp.vz=[];
emp.fit=[];
emp.info=[];
emp.SCH=[];

par=repmat(emp,Npar,1);


for i=1:Npar
par(i).x=unifrnd(lb.x,ub.x);
par(i).y=unifrnd(lb.y,ub.y);
par(i).z=unifrnd(lb.z,ub.z);
par(i).v=0;
par(i).vy=0;
par(i).vz=0;
par(i)=fitness(par(i),data);
end


end