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
%%
figure;
scatter(X,y,'red');
%xlim([0 5000]);
%ylim([0 800]);
xlabel('Size (sqft)');
ylabel('Price (in thousands of dollars)');
title('Housing prices in Portland');
legend('off');
grid on
%% linear regression using fitlm

ols = fitlm(X,y);

% adding the linear regression line to the plot
hold on;
plot(X, predict(ols, X), 'green', 'LineWidth',3);
hold off;
grid on