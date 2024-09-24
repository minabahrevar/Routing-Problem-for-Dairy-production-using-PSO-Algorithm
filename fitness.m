function sol=fitness(sol,data)
betta=10;

%% Calling Data
nc=data.nc;
nv=data.nv;
nt=data.nt;
hp=data.hp;
hc=data.hc;
sp=data.sp;
veh=data.veh;
cap=data.cap;
nccap=data.nccap;
npcap=data.npcap;
dem=data.dem;
disDtoC=data.disDtoC;
disCtoC=data.disCtoC;
ltime=data.ltime;
utime=data.utime;

%% Calling Sol
x=sol.x;
y=max(sol.y,0);
z=max(sol.z,0);

%% Random Key
[not,x]=sort(x);

%% Assignment
g=3;

for t=1:nt
    a=x(:,t);
for vp=1:nv

    b=find(a>nc);
    b=b(1);
    v=a(b)-nc;
    C=a(1:b-1);
    a(1:b)=[];
    veh(v,t).C=C;
end
 
     if isempty(a)
        continue
    end
        
        ncv=numel(a);
    for jj=1:ncv
        
        j=a(jj);
        y(j,t)=0;

    end
end


%% Simulation
icap=zeros([nc nt]);
UCAP=zeros([nv nt]);
prod=zeros(nt);
totaldem=0;
for v=1:nv
    C=veh(v,1).C;
    dis=veh(v,1).dis;
    ucap=veh(v,1).ucap;
    tim=veh(v,1).tim;
    
    if isempty(C)
        continue
    end
    
    % Depot To Customer 1
    i=C(1);
    dis=dis+disDtoC(i);
    tim=tim+g*disDtoC(i);
    
        if tim<=ltime(i,1)
            y(i,1)=max(min(y(i,1),nccap(i)+dem(i,1)),0);
            icap(i,1)=max(y(i,1)-dem(i,1),0);
            totaldem=totaldem+min(dem(i,1),y(i,1));
        elseif (tim<=utime(i,1)&& tim>=ltime(i,1))
            y(i,1)=max(min(y(i,1),nccap(i)+dem(i,1)*(utime(i,1)-tim)/(utime(i,1)-ltime(i,1))),0);
            icap(i,1)=max(y(i,1)-dem(i,1)*(utime(i,1)-tim)/(utime(i,1)-ltime(i,1)),0);
            totaldem=totaldem+min(dem(i,1)*(utime(i,1)-tim)/(utime(i,1)-ltime(i,1)),y(i,1));
        end  
        
    ucap=ucap+y(i,1);
           
   % Customer i to j
    ncv=numel(C);
    for jj=2:ncv
        
        ii=jj-1;
        
        i=C(ii);
        j=C(jj);
        tim=tim+g*disCtoC(i,j);
        dis=dis+disCtoC(i,j);
        
        if tim<=ltime(j,1)
            y(j,1)=min(y(j,1),nccap(j)+dem(j,1));
            icap(j,1)=max(y(j,1)-dem(j,1),0);
            totaldem=totaldem+min(dem(j,1),y(j,1));            
        elseif (tim<=utime(j,1) && tim>=ltime(j,1))
            y(j,1)=min(y(j,1),nccap(j)+dem(j,1)*(utime(j,1)-tim)/(utime(j,1)-ltime(j,1)));
            icap(j,1)=max(y(j,1)-dem(j,1)*(utime(j,1)-tim)/(utime(j,1)-ltime(j,1)),0);
            totaldem=totaldem+min(dem(j,1)*(utime(j,1)-tim)/(utime(j,1)-ltime(j,1)),y(j,1));            
        end  
        
    ucap=ucap+y(j,1);
        
    end
    
    
    
    % Customer END To Depot
    i=C(end);
    dis=dis+disDtoC(i);
    tim=tim+g*disCtoC(i);
        
    veh(v,1).dis=dis;
    veh(v,1).ucap=ucap;    
    veh(v,1).tim=tim;
    UCAP(v,1)=ucap;
    
end

prod(1)=sum(y(:,1))+z(1);
for t=2:nt
    for i=1:nc
       dd=min(dem(i,t),icap(i,t-1)); 
       totaldem=totaldem+dd;
       dem(i,t)=dem(i,t)-dd;
       icap(i,t-1)=icap(i,t-1)-dd;
    end
    
for v=1:nv
    C=veh(v,t).C;
    dis=veh(v,t).dis;
    ucap=veh(v,t).ucap;
    tim=veh(v,t).tim;
    
    if isempty(C)
        continue
    end
    
    % Depot To Customer 1
    i=C(1);
    dis=dis+disDtoC(i);
    tim=tim+g*disDtoC(i);
     
        if tim<=ltime(i,t)
            y(i,t)=min(y(i,t),nccap(i)+dem(i,t)-icap(i,t-1));
            icap(i,t)=max(icap(i,t-1)+y(i,t)-dem(i,t),0);
            totaldem=totaldem+min(dem(i,t),y(i,t));
        elseif (tim<=utime(i,t) && tim>=ltime(i,t))
            y(i,t)=min(y(i,t),nccap(i)-icap(i,t-1)+dem(i,t)*(utime(i,t)-tim)/(utime(i,t)-ltime(i,t)));
            icap(i,t)=max(icap(i,t-1)+y(i,1)-dem(i,1)*(utime(i,t)-tim)/(utime(i,t)-ltime(i,t)),0);
            totaldem=totaldem+min(dem(i,t)*(utime(i,t)-tim)/(utime(i,t)-ltime(i,t)),y(i,t));
        end  
        
    ucap=ucap+y(i,t);
    
       
    
   % Customer i to j
    ncv=numel(C);
    for jj=2:ncv
        
        ii=jj-1;
        
        i=C(ii);
        j=C(jj);
        
        tim=tim+g*disCtoC(i,j);
        dis=dis+disCtoC(i,j);

        if tim<=ltime(j,t)
            y(j,t)=max(min(y(j,t),nccap(j)+dem(j,t)-icap(j,t-1)),0);
            icap(j,t)=max(icap(j,t-1)+y(j,t)-dem(j,t),0);
            totaldem=totaldem+min(dem(j,t),y(j,t));
        elseif (tim<=utime(j,t)&& tim>=ltime(j,t))
            y(j,t)=max(min(y(j,t),nccap(j)-icap(j,t-1)+dem(j,t)*(utime(j,t)-tim)/(utime(j,t)-ltime(j,t))),0);
            icap(j,t)=max(icap(j,t-1)+y(j,1)-dem(j,1)*(utime(j,t)-tim)/(utime(j,t)-ltime(j,t)),0);
            totaldem=totaldem+min(dem(j,t)*(utime(j,t)-tim)/(utime(j,t)-ltime(j,t)),y(j,t));
        end  
        
    ucap=ucap+y(j,t);        
        
    end
    
    % Customer END To Depot
    i=C(end);
    dis=dis+disDtoC(i);
    tim=tim+g*disCtoC(i);
   
    
    veh(v,t).dis=dis;
    veh(v,t).ucap=ucap;    
    veh(v,t).tim=tim;
    UCAP(v,t)=ucap;
end

prod(t)=sum(y(:,t))+z(t)-z(t-1);
end




sol.y=y;
sol.z=z;

%% Cal CH

CH=0;
CH2=0;
sprod=zeros(nt);
SS=0;

for t=1:nt
    CH=CH+sum(max(UCAP(:,t)-cap,0));
    CH2=CH2+max(prod(t)-2*npcap,0);
    if prod(t)> 0
        sprod(t)=1;
        SS=SS+sp(t);
    end
end
    





%% Cal SCH
Alpha=sum(disCtoC(:));
SCH=10000000000*Alpha*(sum(CH)+sum(CH2));

%% Cal OBJ

fit=sum([veh.dis])+SS+hp*sum(z)+sum(hc.*sum(icap,2))-betta*totaldem;

costz1=sum([veh.dis])+SS+hp*sum(z)+sum(hc.*sum(icap,2));
totaldemz2=totaldem;
sol.info.costz1=costz1;
sol.info.totaldemz2=totaldemz2;
sol.fit=fit+SCH;
sol.SCH=SCH;
sol.info.x=x;
sol.info.y=y;
sol.info.z=z;
sol.info.veh=veh;
sol.info.RealFit=fit;


end