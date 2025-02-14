%% Initialization

clear ; close all; clc
%%
% Data from https://archive.ics.uci.edu/ml/datasets/statlog+(heart)
% Data set has been split into a training set (80%) and a validation set (20%)

load heart_train.mat
X = heart_disease_train(:, 1:end-1);
y = heart_disease_train(:, end:end);
%% Add intercept term

X = [ones(size(X, 1), 1) X];

%% ASSIGNMENT 2: find sensible values for the leraning rate and the number of iterations

alpha = 4;
iterations = 9000;

%% ASSIGNMENT 1: implement the function 'logistic' below

theta = logistic(X, y, alpha, iterations);

%% ASSIGNMENT 3: implement the function 'classify' below

p = classify(theta, X);
fprintf('Train Accuracy: %f%% (expected: 87.x%%)\n', mean(double(p == y)) * 100);

%% load validation data
load heart_test.mat
X = heart_disease_test(:, 1:end-1);
y = heart_disease_test(:, end:end);
%% Add intercept term
X = [ones(size(X, 1), 1) X];

p = classify(theta, X)
fprintf('Validation Accuracy: %f%% (expected: 79.x%%)\n', mean(double(p == y)) * 100);
%%
% Plot the data points
figure; % Creates a new figure
hold on;
pos = find(y == 1); % Indices of positive examples
neg = find(y == 0); % Indices of negative examples
plot(X(pos, 2), X(pos, 3), 'k+','LineWidth', 2, 'MarkerSize', 7); % Adjust indices based on your data
plot(X(neg, 2), X(neg, 3), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);

% Plot decision boundary
plot_x = [min(X(:,2))-2,  max(X(:,2))+2];
plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));
plot(plot_x, plot_y)
legend('Admitted', 'Not admitted', 'Decision Boundary')
xlabel('Exam 1 score')
ylabel('Exam 2 score')
hold off;

%%
% ASSIGNMENT 2: implement the logistic regression algorithm.
% Inputs:
%   X: the feature matrix including the intercept term
%   y: the outcomes (vector of 0/1 values)
%   alpha: the learning rate
%   iterations: the number of iterations to run
% Outputs:
%   theta: the computed theta
%   cost: a vector containing the value of the cost function for each
%   iteration of the algorithm 
function [theta,J_history] = logistic(X, y, alpha, iterations)
    m = length(y); % number of training examples 
    n = size(X,2); % number of features including the intercept term
    theta = zeros(n, 1); % initial theta values
    J_history = ones(iterations, 1); %to record the cost function value at each iteration

     %sigmoid function
    %sigmoid = @(z) 1.0 ./ (1.0 + exp(-z));

    for iter = 1:iterations
        % hypothesis function
        z = X * theta;
        h =  1 ./ (1 + exp(-z));
        %h = sigmoid(z);   %y_hat = h(x) which is sigmoid(z) 

        % cost function for log reg
        J = (-1/m) * sum(y .* log(h) + (1 - y) .* log(1 - h));

        % gradient calculation for log reg
        gradient = (1/m) * (X' * (h - y));

        % update theta
        theta = theta - alpha * gradient;

        J_history(iter) = J; % saving the cost in every iteration
    end
end
%%
% function g = sigmoid(z)
%     %SIGMOID Compute sigmoid function
%     g = 1 ./ (1 + exp(-z));
% end
%%
% ASSIGNMENT 3: given a computed theta, classify the samples into 0/1
% Inputs:
%   X: the feature matrix including the intercept term
%   theta: the computed theta
% Outputs:
%   c: a vector of 0/1 values which classify the symptomps as heart disease likely present (1) or absent (0)
function c = classify(theta, X)
  % compute the hypothesis
  z = X * theta;
  h =  1 ./ (1 + exp(-z));

  % converting probabilities to 0 or 1 using 0.5 as threshold
  c = h >= 0.5;
end

