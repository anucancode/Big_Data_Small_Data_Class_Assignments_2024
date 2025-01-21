function [clustered, centroids] = k_means(events, K, max_its)
    % initializing centroids randomly
    rng('default'); % this line ensures random startings for centroids
    n = size(events, 1);
    centroids = events(randperm(n, K), :);
    
    for iter = 1:max_its
        % updating cluster assignments
        assignments = update_assignments(events, centroids);
        
        % updating centroid locations
        centroids = update_centroids(events, centroids, assignments);
    end
    
    % appending assignments to the events data
    clustered = [events, assignments];
end