% mlintrpt;
clear ; close all; clc    
%load '2017-12-street.mat'
load '2017-12-stop-and-search.mat'
figure(1);
hold on, plot(events(:, 1), events(:, 2), '.', 'color', 'yellow')
% pause;



CLUSTERS = 5;

% accepts a 2-column matrix, returns a 3-column matrix where the 3rd column is the cluster assignment
%for j=1:100
clustered = k_means(events, CLUSTERS);
%end

colors = {'red', 'green', 'blue', 'black', 'magenta'};

figure(1);
for i=1:CLUSTERS
  hold on, plot( clustered(clustered(:, end) == i, 1), clustered(clustered(:, end) == i, 2), '.', 'color', colors{i} );
end

% Plot centroids
for i=1:CLUSTERS
  hold on, plot(clustered(i, 1), clustered(i, 2), 'x', 'MarkerEdgeColor', 'black', 'MarkerSize', 20, 'LineWidth', 3);
end

% figure;
% hold on;
% for i = 1:CLUSTERS
%     % Plot cluster points
%     clusterPoints = events(clustered == i, :);
%     plot(clustered(:, 1), clustered(:, 2), '.', 'color', colors{i});
% 
%     % Plot centroid
%     plot(centroids(i, 1), centroids(i, 2), 'x', 'MarkerEdgeColor', 'k', 'MarkerSize', 10, 'LineWidth', 2);
% end
% hold off;


% pause;
% close all;
%%
% function [clusteredEvents, centroids] = k_means(events, CLUSTERS)
%     % Number of events
%     numEvents = size(events, 1);
% 
%     % Randomly initialize centroids
%     randIndices = randperm(numEvents, CLUSTERS);
%     centroids = events(randIndices, :);
% 
%     % Initialize variables for storing the assignments
%     assignments = zeros(numEvents, 1);
%     oldAssignments = ones(numEvents, 1);
% 
%     % Iterate until assignments do not change
%     while ~isequal(assignments, oldAssignments)
%         oldAssignments = assignments;
% 
%         % Step 1: Assign each event to the nearest centroid
%         for i = 1:numEvents
%             distances = sum((events(i, :) - centroids).^2, 2);
%             [~, closestCentroid] = min(distances);
%             assignments(i) = closestCentroid;
%         end
% 
%         % Step 2: Recalculate centroids as the mean of all assigned events
%         for k = 1:CLUSTERS
%             if any(assignments == k)
%                 centroids(k, :) = mean(events(assignments == k, :), 1);
%             end
%         end
%     end
    
%     % Output the assignments and the final centroids
%     clusteredEvents = assignments;
% end




%% first try
function [clusteredEvents, centroids] = k_means(events, CLUSTERS);
    % 
    [n, m] = size(events);

    % step 1 initialization of centroids
    rng("default");
    initialCentroids = randperm(n, CLUSTERS);
    centroids = events(initialCentroids, :);
    clusterAssignments = zeros(n, 1);

    centroidsChanged = true;

    while centroidsChanged
        % calculate distances
        for i = 1:n
            distances = sqrt(sum((events(i, :) - centroids).^2, 2));
            [m, closestCentroid] = min(distances);
            clusterAssignments(i) = closestCentroid;
        end

        % % update step
        % %newCentroids = clusterAssignments;
        % newCentroids = arrayfun(@(k) mean(events(clusterAssignments == k, :), 1), (1:CLUSTERS)', 'UniformOutput', false);
        % newCentroids = cell2mat(newCentroids);

        % preallocate newCentroids 
        newCentroids = zeros(CLUSTERS, size(events, 2));

        % looping through each cluster to calculate new centroid
        for k = 1:CLUSTERS
            % logical indexing to select events belonging to the current cluster
            clusterEvents = events(clusterAssignments == k, :);

            % calculate the mean of the selected events
            newCentroids(k, :) = mean(clusterEvents, 1);
        end

        if newCentroids == centroids
            centroidsChanged = false;
        else
            centroids = newCentroids;
        end
    end

    clusteredEvents = [events, clusterAssignments];
end

 %%
% function [clusteredEvents, centroids] = k_means(events, CLUSTERS)
%     % Determine the size of the events data
%     [n, ~] = size(events);
% 
%     % Step 1: Initialization of centroids
%     rng("default"); % For reproducibility
%     initialCentroids = randperm(n, CLUSTERS);
%     centroids = events(initialCentroids, :);
%     clusterAssignments = zeros(n, 1);
% 
%     centroidsChanged = true;
%     while centroidsChanged
%         % Step 2: Assign clusters
%         for i = 1:n
%             distances = sqrt(sum((events(i, :) - centroids).^2, 2));
%             [~, closestCentroid] = min(distances);
%             clusterAssignments(i) = closestCentroid;
%         end
% 
%         % Step 3: Update centroids
%         newCentroids = zeros(CLUSTERS, size(events, 2));
%         for k = 1:CLUSTERS
%             if any(clusterAssignments == k)
%                 newCentroids(k, :) = mean(events(clusterAssignments == k, :), 1);
%             else
%                 % If no events are assigned to the cluster, keep the previous centroid
%                 newCentroids(k, :) = centroids(k, :);
%             end
%         end
% 
%         % Check for convergence
%         if isequal(centroids, newCentroids)
%             centroidsChanged = false;
%         else
%             centroids = newCentroids;
%         end
%     end
% 
%     % Concatenate the original events with their cluster assignments
%     clusteredEvents = [events, clusterAssignments];
% end
