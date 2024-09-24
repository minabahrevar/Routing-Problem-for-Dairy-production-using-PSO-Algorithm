function PlotBestSol(sol,data)


nv=data.nv;
nt=data.nt;
posd=data.posd;
posc=data.posc;

Pos=[posd;posc];

minpos=min(Pos);
maxpos=max(Pos);
minpos=minpos*0.8;
maxpos=maxpos*1.2;

Colors=0.9*(hsv(nv));

figure(1)
plot(posd(1),posd(2),'bs',...
    'Markersize',10,...
    'MarkerFaceColor','b')

xlim([minpos(1) maxpos(1)])
ylim([minpos(2) maxpos(2)])
hold on

plot(posc(:,1),posc(:,2),'ko',...
    'Markersize',5);

hold on

for t=1:nt
for v=1:nv

    C=sol.info.veh(v,t).C;

    if isempty(C)
        continue
    end
    
    % Customer START
    i=1;
    j=C(1)+1;
    line(Pos([i j],1),Pos([i j],2),...
        'LineStyle','-',...
        'Color',Colors(v,:));
    hold on
    
    % Customer i to j
    ncv=numel(C);
    for jj=2:ncv
        ii=jj-1;
        i=C(ii)+1;
        j=C(jj)+1;
        
        line(Pos([i j],1),Pos([i j],2),...
            'LineStyle','-',...
            'Color',Colors(v,:));
        
        hold on
    end
    
    
    
    % Customer END
    
    j=1;
    i=C(end)+1;
    line(Pos([i j],1),Pos([i j],2),...
        'LineStyle','-',...
        'Color',Colors(v,:));
    
    hold on    
    
   

end
end


xlabel('X')
ylabel('Y')
title([' Best= ' num2str(sol.fit)]);

hold off

