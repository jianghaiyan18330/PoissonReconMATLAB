% Shows a couple of sample reconstruction using PR - Poisson Surface
% Reconstruction
%
% Maolin Tian, Tongji University, 2018

ptCloud = pcread('..\data\horse.points.ply');
% data: shpere_non_uniform.points, horse.points, bunny.points,
% Armadillo.points, dragon.points, eagle.points,
% TjHand.points,TjHand.points_trans.
ptCloud1 = pointCloud(ptCloud.Location(1:2:end,:), 'Normal', ptCloud.Normal(1:2:end,:));
ptCloud2 = pointCloud(ptCloud.Location(2:2:end,:), 'Normal', ptCloud.Normal(2:2:end,:));
minDepth = 4; % max voxel width = 2^-minDepth
maxDepth = 6; % maxDepth should < 8
verbose = true;
%    v2 depth 6 = v3 (maxNormalWeight=-1 and depth=7) or (maxNormalWeight=2 and depth=6)
% example1: ptCloud : horse.points.ply
%           v3 depth: 4~6, v2 depth: 4~5,4~6
% example2: ptCloud : bunny.points.ply
%           v3 depth: 4~5, v2 depth: 4~4,4~5

% pcshow(ptCloud)

[F,V] = poissonRecon(ptCloud1, minDepth, maxDepth, verbose);

% error
[error, dist] = getError(V, ptCloud2.Location);
% figure, axis equal, hold on
% % scatter3( V(:,1), V(:,2), V(:,3),'.');
% scatter3( ptCloud2.Location(dist>2*error,1), ptCloud2.Location(dist>2*error,2), ptCloud2.Location(dist>2*error,3),'.');
% errorPlot = scatter3( V(:,1), V(:,2), V(:,3), [], dist , '.');
% colormap jet
% color = [dist/error/2,zeros(length(dist),1),max(2*error - dist,0)/error/2];
% cPointCloud = pointCloud(ptCloud2.Location,'Color',color, 'Normal', ptCloud2.Normal);
% pcwrite(cPointCloud,'..\data\error.ply');
