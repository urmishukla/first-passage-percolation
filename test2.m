tic
N = 10000;
row = N +1;
column = 2*N + 1;
T = -Inf(row, column);
T(1, N+1) = 0;
omega = rand(row, column); % x is distributed uniformly
x = omega>3/10;
for t =2: N+1
    T (t, :)= max([-Inf T(t-1, 1:end-1)], [T(t-1, 2:end) -Inf]) + x(t,:);
    % plot(last_row, row)
end

last_row = T(end,:);
bad_loc = find(last_row==-Inf);
last_row(bad_loc)=0;
plot(last_row/N);
toc



%%

tic
epsilon = 0.01;
N = 20000;
row = N +1;
column = 2*N + 1;
T = -Inf(1, column);
T(1, N+1) = 0;

for t =2: N+1
    omega = rand(1, column); % x is distributed uniformly
    x = omega>3/10;
    T = max([-Inf T(1:end-1)], [T(2:end) -Inf]) + x;
    % plot(last_row, row)
end

last_row = T;
bad_loc = find(last_row==-Inf);
last_row(bad_loc)=0;
delta = round(N*epsilon);
test_vec = my_vec(N+1-delta: N+1+delta)/N;
good_coord1 = find(test_vec~=0);
test_vec = test_vec(good_coord1);
max(test_vec) - min(test_vec)

figure
plot(linspace(0,1,length(last_row)),last_row/N);
toc