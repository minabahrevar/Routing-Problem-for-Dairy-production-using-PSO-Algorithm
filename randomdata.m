function randomdata(nc,nv,nt)

pos=randi([0 100],nc+1,2);
dem=randi([100 200],nc,nt);

a=sum(sum(dem))/(nv*nt);
cap=randi([round(1.5*a) round(2*a)],nv,1);
nccap=randi([round(1.5*a) round(2*a)],nc,1);
npcap=randi([round(3*a) round(5*a)],1,1);
ltime=randi([200 300],nc,nt);
utime=randi([300 400],nc,nt);


hp=randi([10 15]);
hc=randi([15 20],nc,1);
sp=randi([1500 2000],nt,1);
Q=NaN(5*1,1);
Q(1,1)=hp;
xlswrite('data.xlsx',Q,5,'d8');
Q=NaN(5*nc,1);
Q(1:nc,:)=hc;
xlswrite('data.xlsx',Q,5,'e9');
Q=NaN(5*1,nt);
Q(1,:)=sp;
xlswrite('data.xlsx',Q,5,'f8');


Q=NaN(5*nc,2);
Q(1:nc+1,:)=pos;
xlswrite('data.xlsx',Q,1,'d8');

Q=NaN(5*nc,1);
Q(1:nc,:)=nccap;
xlswrite('data.xlsx',Q,3,'e9');

Q=NaN(5*1,1);
Q(1,1)=npcap;
xlswrite('data.xlsx',Q,3,'d8');

Q=NaN(5*nc,nt);
Q(1:nc,:)=ltime;
xlswrite('data.xlsx',Q,3,'g9');

Q=NaN(5*nc,nt);
Q(1:nc,:)=utime;
xlswrite('data.xlsx',Q,4,'g9');

Q=NaN(5*nc,nt);
Q(1:nc,:)=dem;
xlswrite('data.xlsx',Q,1,'g9');

Q=NaN(5*nv,1);
Q(1:nv,:)=cap;
xlswrite('data.xlsx',Q,2,'f7');



end