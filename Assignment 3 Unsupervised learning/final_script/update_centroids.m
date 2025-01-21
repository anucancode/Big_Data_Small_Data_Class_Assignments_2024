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
