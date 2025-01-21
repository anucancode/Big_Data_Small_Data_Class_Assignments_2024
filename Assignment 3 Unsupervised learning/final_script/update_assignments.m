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
