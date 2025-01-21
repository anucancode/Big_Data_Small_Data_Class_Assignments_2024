% mlintrpt;
clear; close all; clc;
load '2017-12-street.mat';
%load '2017-12-stop-and-search.mat'
figure(1);
hold on;
plot(events(:, 1), events(:, 2), '.', 'Color', 'yellow');
%%
load '2017-12-stop-and-search.mat'

% Parameters for K-means
CLUSTERS = 3;
max_its = 100;

% accepts a 2-column matrix, returns a 3-column matrix where the 3rd column is the cluster assignment
[clustered, centroids] = k_means(events, CLUSTERS, max_its);

colors = {'red', 'green', 'blue', 'black', 'magenta'};
for i = 1:CLUSTERS
    cluster_points = clustered(:, end) == i;
    plot(events(cluster_points, 1), events(cluster_points, 2), '.', 'Color', colors{i});
end

% plotting centroids!!
for i = 1:CLUSTERS
    plot(centroids(i, 1), centroids(i, 2), 'x', 'MarkerEdgeColor', 'white', 'MarkerSize', 20, 'LineWidth', 3);
end
hold off;