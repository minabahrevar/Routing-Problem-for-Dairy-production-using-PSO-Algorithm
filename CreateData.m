clc
clear


%% Random Data

 nc=50;
 nv=20;
 nt=2;
 randomdata(nc,nv,nt);


%% Import Excel Data

a=xlsread('data.xlsx',1);



pos=a(:,1:2);
posd=pos(1,:);
posc=pos(2:end,:);
nc=size(posc,1);

disDtoC=zeros(nc,1);
for i=1:nc
disDtoC(i)=norm(posd-posc(i,:),2);
end

disCtoC=zeros(nc,nc);
for i=1:nc
    for j=1:nc
disCtoC(i,j)=norm(posc(i,:)-posc(j,:),2);
    end
end


dem=a(2:end,4:end);
nt=numel(dem(1,:));

cap=xlsread('data.xlsx',2);
nv=numel(cap);



bbb=xlsread('data.xlsx',3);

npcap=bbb(1,1);
nccap=bbb(2:end,2);

ltime=bbb(2:end,4:end);
utime=xlsread('data.xlsx',4);

ccc=xlsread('data.xlsx',5);
hp=ccc(1,1);
hc=ccc(2:end,2);
sp=ccc(1,3:end);

nvar=nc+nv;


emp.C=[];
emp.dis=0;
emp.ucap=0;
emp.tim=0;
veh=repmat(emp,[nv nt]);


save data





