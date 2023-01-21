m=100;
result=zeros(1,m);
figure
datacursormode on
for j=1:m
    n=500;
    sc = 10;
    x= zeros(n,1);
    y= zeros(n,1);
    for i=1:n-1
        r= randi(4,1);
        if r==1
            x(i+1) = x(i) +1;
            y(i+1) = y(i);
        elseif r==2
            x(i+1) = x(i) -1;
            y(i+1) = y(i);
        elseif r==3
            x(i+1) = x(i);
            y(i+1) = y(i)+1;
        else
            x(i+1) = x(i);
            y(i+1) = y(i) -1;
        end
        plot(x(1:i+1),y(1:i+1), '-', 'Color','r');
        hold on;
        plot(x(i+1), y(i+1), 'o','MarkerSize',4,'MarkerFaceColor','b')
        hold off
        %%xlim([-20 20])
        %%ylim([-20 20])
        if (max(abs(x(i+1)), abs(y(i+1)))) == sc
            sc = sc*2;
        end
        axis([-sc sc -sc sc]);
        pause(0.05)
    end
    result(j) = sqrt(x(n)^2 + y(n)^2);
end
mean(result)
