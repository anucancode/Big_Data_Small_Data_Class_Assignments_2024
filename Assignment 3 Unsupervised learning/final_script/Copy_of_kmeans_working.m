% mlintrpt;
clear; close all; clc;
%load '2017-12-street.mat';

load 'data10min.mat';
%%

Vw = data10min.WindSpeed10m;
P = data10min.Power10m;
events = [Vw, P];

%events_norm = zscore(events);

figure(1);
hold on;
plot(events(:,1), events(:,2), '.', 'Color', 'yellow');
grid on
%%
%load '2017-12-stop-and-search.mat'

% Parameters for K-means
CLUSTERS = 3;
max_its = 1000;



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
grid on 

%%
function assignments = update_assignments(events, centroids)
    n = size(events, 1);
    K = size(centroids, 1);
    assignments = zeros(n, 1);
    
    for i = 1:n
        distances = sum((events(i, :) - centroids).^2, 2);
        [~, closest_centroid] = min(distances);
        assignments(i) = closest_centroid;
    end
end
%%
function new_centroids = update_centroids(events, centroids, assignments)
    K = size(centroids, 1);
    new_centroids = zeros(K, size(events, 2));
    
    for k = 1:K
        cluster_points = events(assignments == k, :);
        if ~isempty(cluster_points)
            new_centroids(k, :) = mean(cluster_points, 1);
        else
            new_centroids(k, :) = centroids(k, :); 
        end
    end
end
