%% Initialization
clear ; close all; clc
%%
% Data from https://archive.ics.uci.edu/ml/datasets/statlog+(heart)
% Data set has been split into a training set (80%) and a validation set (20%)
load heart_train.mat
X = heart_disease_train(:, 1:end-1);
y = heart_disease_train(:, end:end);

% Add intercept term
X = [ones(size(X, 1), 1) X];
%%
% ASSIGNMENT 2: find sensible values for the leraning rate and the number of iterations
alpha = 1;
iterations = 20;
%%
% ASSIGNMENT 1: implement the function 'logistic' below
theta = logistic(X, y, alpha, iterations);
%%
% ASSIGNMENT 3: implement the function 'classify' below
p = classify(theta, X);
fprintf('Train Accuracy: %f%% (expected: 87.x%%)\n', mean(double(p == y)) * 100);
%%
% load validation data
load heart_test.mat
X = heart_disease_test(:, 1:end-1);
y = heart_disease_test(:, end:end);
% Add intercept term
X = [ones(size(X, 1), 1) X];

p = classify(theta, X);
fprintf('Validation Accuracy: %f%% (expected: 79.x%%)\n', mean(double(p == y)) * 100);
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

function [theta,cost] = logistic(X, y, alpha, iterations)

  % YOUR CODE HERE

end

% ASSIGNMENT 3: given a computed theta, classify the samples into 0/1
% Inputs:
%   X: the feature matrix including the intercept term
%   theta: the computed theta
% Outputs:
%   c: a vector of 0/1 values which classify the symptomps as heart disease likely present (1) or absent (0)
function c = classify(theta, X)

  % YOUR CODE HERE

end
