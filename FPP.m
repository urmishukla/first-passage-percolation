clearvars
tic
format compact
N=300;
x= N+1;
y=N+1;
V= zeros(2*N+1,2*N+1);
T= zeros(2*N+1,2*N+1) + inf;
[Y,X]= meshgrid(1:2*N+1);
T(x,y)=0;

P= zeros(2*N+1);
E= zeros(2*N+1, 2*N+1,4);
E(:,:,1:2) = rand(2*N+1,2*N+1,2);
E= double(E>1/2);
E(:,end,1)= inf(2*N+1,1,1);
E(end,:,2)= inf(1,2*N+1,1);
%E(:,:,3) = rand(2*N+1,2*N+1,2);
E(:,:,3) = cat(2, Inf(2*N+1,1,1), E(:,1:end-1,1));
%[inf(2*N+1,1,1); E(:,1:end)]; % conc along second dimension
E(:,:,4) = cat(1, Inf(1,2*N+1,1), E(1:end-1,:,2));% conc along 1 dim
while ~ isempty(find(V==0, 1))
    loc= find(V==0);
    T_temp = T(loc);
    [~,loc_temp]= min(T_temp);
    loc=loc(loc_temp);
    x=X(loc);
    y=Y(loc);

    %[val,x]=min(T+V.*inf);
    %[~,y]=min(val);
    %x=x(y);
    V(x,y)=1;
%%
    if E(x,y,1)~= inf
        if V(x,y+1)==0
        [T(x,y+1),idx]= min([T(x,y+1) T(x,y)+E(x,y,1)]);
            if idx==2
                P(x,y+1)= 3;
            end
        end
    end
if E(x,y,2)~= inf
    if V(x+1,y)==0
    [T(x+1,y),idx]= min([T(x+1,y) T(x,y)+E(x,y,2)]);
        if idx==2
            P(x+1,y)= 4;
        end
    end
end
if E(x,y,4)~= inf
    if V(x-1,y)==0
    [T(x-1,y),idx]= min([T(x-1,y) T(x,y)+E(x,y,4)]);
        if idx==2
            P(x-1,y)= 2;
        end
    end
end

if E(x,y,3)~= inf
    if V(x,y-1)==0
    [T(x,y-1),idx]= min([T(x,y-1) T(x,y)+E(x,y,3)]);
        if idx==2
            P(x,y-1)= 1;
        end
    end
end
end
%%
[min_1, loc_1]= min(T(1,:));
[min_2, loc_2] =min(T(end,:));
[min_3, loc_3]= min(T(:,1));
[min_4, loc_4]= min(T(:,end));
[min_final,loc_final]= min([min_1,min_2,min_3,min_4]);
if loc_final == 1
    T_min = T(1,loc_1);
    x_zero = 1;
    y_zero = loc_1;
elseif loc_final ==2
    T_min = T(end,loc_2);
    x_zero = 2*N+1;
    y_zero = loc_2;
elseif loc_final==3
    T_min = T(loc_3, 1);
    x_zero = loc_3;
    y_zero = 1;
else
    T_min = T(loc_4,end);
    x_zero = loc_4;
    y_zero = 2*N+1;
end

P_r= (P==2)- (P==4);
P_c= (P==1)- (P==3);
x=x_zero;
y=y_zero;
path = zeros((2*N+1)^2,2);
path(1,:)= [x_zero, y_zero];
counter = 1 ;

while P(x,y)~= 0
    x_new = x+P_r(x,y);
    y = y+P_c(x,y);
    x= x_new;
    counter= counter+1;
    path(counter,:)=[x,y];
end

figure
hold on
box on
grid on
axis([1 2*N+1 1 2*N+1])
path = path(1:counter,:);
plot(N+1,N+1,"k.", "MarkerSize", 30);
plot(path(1,2), 2*N+2-path(1,1),"k.", "MarkerSize", 30);
plot(path(:,2),2*N+2-path(:,1),"b-","LineWidth",6);
title(['$N = $ ' num2str(N) ', passage time $=$ ' num2str(T_min) ', number of edges $=$' num2str(counter-1)],'interpreter', 'latex');
toc
