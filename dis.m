a=xlsread('50-20-2.xlsx',1);



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


diss=zeros(nc+1,nc+1);
diss(2:nc+1,1)=disDtoC;
diss(1,2:nc+1)=disDtoC;
diss(2:nc+1,2:nc+1)=disCtoC;
diss