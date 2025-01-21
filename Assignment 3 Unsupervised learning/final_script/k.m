clc
clear all

load 'data10min.mat';

Vw = data10min.WindSpeed10m;
P = data10min.Power10m;
%Ti = data10min.WindspeedTurbulence;
%rho = data10min.air_density;
events = [Vw, P];

figure(1);
plot(Vw, P, '.', 'Color', 'yellow');
xlabel('Wind Speed (m/s)');
ylabel('Power (kW)');
title('Wind Turbine Data');
grid on;
%%
CLUSTERS = 3;
max_its = 10000;

[clustered, centroids] = kmeans(events, CLUSTERS, 'MaxIter', max_its);

figure(2);
hold on;

colors = {'red', 'green', 'blue', 'black', 'magenta'};
for i = 1:CLUSTERS
    cluster_points = clustered == i;
    plot(events(cluster_points, 1), events(cluster_points, 2), '.', 'Color', colors{i});
end

% Plot centroids
for i = 1:CLUSTERS
    plot(centroids(i, 1), centroids(i, 2), 'x', 'MarkerEdgeColor', 'black', 'MarkerSize', 20, 'LineWidth', 3);
end

xlabel('Wind Speed (m/s)');
ylabel('Power (kW)');
title('Wind Turbine Data - K-means Clustering');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids');
hold off;
grid on;

