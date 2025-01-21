clear all; 
close all; 
clc
%% Loading data
% for this part we use the same dataset as for the linear regression
% assignment (for more info on the data features see check this assignment)
load 'auto-mpg.mat'

%% Processing data
% for the PCA we discard the output column (miles per gallon), which was
% stored in the first column
X=mpg(:,2:end);


%% PCA
% Find the first two principle components by implementing the steps for
% PCA, and project the data onto the first two priciple components. 
% The last step should be assigned to the matrix Z


Z = ;

%% Plotting
% here we visualise the 7 dimensional car data using the obtained PCs
figure(1)
plot(Z(:,1),Z(:,2),'x')
xlabel('PCA-1')
ylabel('PCA-2')

%% K-means
% use your k-means implementation to find clusters in the car data.
% You 
k= ;
[clustered,mu_k] = k_means();

% here we add the found clusters to the projected data stored in Z 
Z_clustered = ;

% project the found cluster locations onto the first two PCAs
PCA_mu_k = ;



%% visualize results
colors = [[25,101,176]; [220,5,12]; [247,240,86]; [136,46,114]; [238,128,38]; [123,175,221]; [114,25,14]; [82,137,199]; [246,193,65]];
colors = colors/256;

figure(2)
for i=1:k
  hold on, plot( Z_clustered(Z_clustered(:, end) == i, 1), Z_clustered(Z_clustered(:, end) == i, 2), 'x', 'color', colors(i,:) );
end
hold on
plot(PCA_mu_k(:,1),PCA_mu_k(:,2), 'o', 'LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','c')



