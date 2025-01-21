% data from https://archive.ics.uci.edu/ml/datasets/auto+mpg with rows with missing data removed

%%
clear all; 
close all; 
clc;

%%
% 1. mpg:           continuous
% 2. cylinders:     multi-valued discrete
% 3. displacement:  continuous
% 4. horsepower:    continuous
% 5. weight:        continuous
% 6. acceleration:  continuous
% 7. model year:    multi-valued discrete
% 8. origin:        multi-valued discrete
%%
load 'auto-mpg.mat';
% first column has y
X = mpg(:, 2:end);
y = mpg(:, 1);
n = size(mpg, 2) - 1;
m = length(y);

%plot(X,y)
%%
% true --> normalizing data, false --> no normalization
normalize = true


if normalize
  % ASSIGNMENT: implement feature normalization. This function must return:
  % 1. The normalized feature matrix
  % 2. mu and sigma to scale inputs for new predictions
  [X, mu, sigma] = normalizeFeatures(X);
  alpha = 0.3;
  iterations = 1000;
else
  mu = zeros(1, n);
  sigma = ones(1, n);
  % ASSIGNMENT: without normalization this combination of learning rate and iterations does not converge. Find
  % values that do, and compare with normalized learning.
  alpha = 20;
  iterations = 1000;
end
%%
% Add Y-displacement term
X = [ones(m, 1) X];

% Initial theta can be anything 
theta = ones(n+1, 1);
%%
% ASSIGNMENT: implement multi-variate gradient descent and return:
% 1. the computed theta vector
% 2. the cost history during calculation for plotting
%[theta, J_history] = mvgd(X, y, theta, alpha, iterations);

%% question 1 ans
% function [theta, J_history] = mvgd(X, y, theta_0, alpha, iterations)
%     % Initialize variables
%     m = length(y); % Number of training examples
%     theta = theta_0; % Initial theta values
%     J_history = zeros(iterations, 1); % To record cost function value at each iteration

    for iter = 1:iterations
        % Hypothesis function
        h = X * theta;
        % Error
        error = h - y;
        % Gradient descent update rule
        theta = theta - (alpha/m) * (X' * error);
        % Compute cost function
        J_history(iter) = (1/(2*m)) * sum(error .^ 2);
    end



%% ASSIGNMENT: Without normalization using alpha = 0.3 and iterations = 1000 the GD
% does not converge. Explain why.
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost');
grid on

if sum(isnan(theta(:))) > 0 || sum(isinf(theta(:))) > 0
  error('Theta ran out of bounds')    
end

fprintf('Computed theta:\n')
disp(theta)

% test samples
for i = 1:10
  sample = randi(m);
  input = [1 mpg(sample, 2:end)];
  actual = mpg(sample, 1);

  prediction = (input - [0 mu]) ./ [1 sigma] * theta;
  fprintf('Sample: %i, predicted: %f, actual: %f\n', sample, prediction, actual);
end

%% normalize function
function [X_norm, mu, sigma] = normalizeFeatures(X)
    mu = mean(X);
    sigma = std(X);
    X_norm = (X - mu) ./ sigma;
end
%%
function [theta, J_history] = mvgd(X, y, theta_0, alpha, iterations)
 % Initialize variables
    m = length(y); % Number of training examples
    theta = theta_0; % Initial theta values
    J_history = zeros(iterations, 1); % To record cost function value at each iteration
end