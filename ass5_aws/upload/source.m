%% Q1: LINEAR PROGRAMMING
clearvars;
% Input data
n = 4;
% Parameters of objective function
q = [1,2,3,4];
% Parameters of equality constraints
C = [1,1,1,1;1,-1,1,-1];
d = [1;0];
% Parameters of inequal constraints
l = [0,0,0,0]';

% cvx opt
cvx_begin
    variable x(n)
    minimize( q*x )
    subject to
        C*x==d
        l<=x
cvx_end
echo off

%% Q2: Regularized ML Estimation
clearvars;
load asgn5q2.mat;
% Input data
[m, n] = size(X);
x_corr = cov(X);
% off diagonal matrix
idx = 1-eye(n,n);
sum_idx = ones(1,n);
% range of lambda
iters_num = 20;
lambda_arr = logspace( -5, 1, iters_num );
% Results history arrays
S_nonzeros_arr = zeros(1,iters_num);
obj_arr = zeros(1,iters_num);
ml_arr = zeros(1,iters_num);

% cvx opt loop
for i=1:iters_num
    lambda = lambda_arr(i);
    cvx_begin sdp
        variable S(n,n) symmetric 
        minimize ( -log_det(S) + trace(x_corr*S)...
            + lambda * sum_idx * abs(idx.*S)*sum_idx' );
        subject to
            S==semidefinite(n,n);
    cvx_end
    
    % record history
    ml_arr(i) = log_det(S) - trace(x_corr*S);
    obj_arr(i) = cvx_optval;
    S_nonzeros_arr(i) = sum(sum(S>1e-6));
end

% plot graph
figure();
plot(lambda_arr,[S_nonzeros_arr;obj_arr;ml_arr], 'LineWidth', 3);
xlabel('\lambda','FontSize',15);
l = legend('non-zeros number', 'obj value', 'ML value');
set(l, 'FontSize',15);
title('non-zeros, obj, ML values v.s. lambda', 'FontSize',15);
grid on;

%% Q3: Total Variation Denoising
clearvars;
load asgn5q3.mat;
% input data
n = length(x_corr);
% difference matrix
e = ones(n,1);
D = spdiags([-e e], -1:0, n, n);
D(1)=0;
% range of lambda
iters_num = 30;
lambda_arr = logspace( -5,1, iters_num );
% Results history arrays
obj_arr = zeros(1,iters_num);
norm_error = zeros(1,iters_num);
norm_regu = zeros(1,iters_num);

% cvx opt loop
for i = 1:iters_num
    lambda = lambda_arr(i);
    cvx_begin
        variable x(n)
        minimize( norm(x-x_corr) + lambda*norm(D*x,1));
    cvx_end
    % record history
    obj_arr(i) = cvx_optval;
    norm_error(i) = norm(x-x_corr);
    norm_regu(i) = norm(D*x,1);
end

% plot graph
figure();
plot(1:iters_num,[lambda_arr;obj_arr]);
l_lambda = legend('\lambda','obj value');
set(l_lambda,'FontSize',15);
title('obj value v.s. \lambda', 'FontSize',15);
figure();
plot(norm_error, norm_regu);
xlabel('||x - x_{corr}||_2', 'FontSize',15);
ylabel('||Dx||_1', 'FontSize',15);
title('Optimal trade-off curve between ||Dx||_1 and ||x-x_{corr}||_2', 'FontSize',15);

% Best lambda we choose
lambda=0.2212;
cvx_begin
    variable x(n)
    minimize( norm(x-x_corr) + lambda*norm(D*x,1));
cvx_end
% Plot Recovered Results
figure();
subplot(2,1,1);
plot(1:n, x_corr, 'LineWidth', 3);
grid on;
title('Original Corrupted Signal','FontSize', 15);
subplot(2,1,2);
plot(1:n, [x_corr';x'], 'LineWidth', 3);
l = legend('corrupted', 'recovered');
set(l,'FontSize',15);
grid on;
title('Recovered Signal with best \lambda=0.2212','FontSize',15);
