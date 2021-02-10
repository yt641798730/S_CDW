clear
x=[0,1/2,0,1/2,2,3/2,2,3/2,3,7/2,3,7/2,5,9/2,5,9/2,     6,13/2,6,13/2,8,15/2,8,15/2];
y=[0,sqrt(3)/2,sqrt(3),3*sqrt(3)/2,0,sqrt(3)/2,sqrt(3),3*sqrt(3)/2,   0,sqrt(3)/2,sqrt(3),3*sqrt(3)/2,0,sqrt(3)/2,sqrt(3),3*sqrt(3)/2,   0,sqrt(3)/2,sqrt(3),3*sqrt(3)/2,0,sqrt(3)/2,sqrt(3),3*sqrt(3)/2];
% close all
% figure
% plot(x,y,'ko')
% % break
% for j=1:23
%     plot(x(j:j+1),y(j:j+1),'r-');
%     hold on
% end
% break
lenth=length(x);
dx=zeros(1,lenth*lenth);
dy=zeros(1,lenth*lenth);
for i=1:lenth
    for j=1:lenth
        ik=(i-1)*lenth+j;
        dx(ik)=x(i)-x(j);
        dy(ik)=y(i)-y(j);
    end
end
figure
for V=1:4
    LN=['MSU1FNF_SU1FNF_24_V_' num2str(V) '.000000'];
data=load(LN);

kxarray=linspace(-2*pi,2*pi,101);
kyarray=linspace(-2*pi,2*pi,101);

Scks=zeros(length(kxarray),length(kyarray));
for ikx=1:length(kxarray)
    kx=kxarray(ikx);
    for iky=1:length(kyarray)
        ky=kyarray(iky);
        Sck=0;
        for n=1:lenth*lenth
            Sc=data(n,3)+1j*data(n,4);
            Sck=Sck+Sc*exp((-1j)*(kx*dx(n)+ky*dy(n)));
        end
        Scks(ikx,iky)=real(Sck);
    end
end

% figure
subplot(2,2,V)
[X,Y]=meshgrid(kxarray,kyarray);
Z=Scks';
xtxt='kx';
ytxt='ky';

h=pcolor(X,Y,Z);
box on
ps=20;
xlabel(xtxt,'fontsize',ps)
ylabel(ytxt,'fontsize',ps)
set(h,'edgecolor','none','facecolor','interp');

set(get(gca,'XLabel'),'Fontsize',ps)
set(get(gca,'YLabel'),'Fontsize',ps)
set(gca,'FontSize',ps);
box on
title(['V=' num2str(V)])
colorbar
end
% break