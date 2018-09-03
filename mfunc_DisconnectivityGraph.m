function [Cost, Path] = mfunc_DisconnectivityGraph(E, LocalMinIndex, AdjacentList)

try
% Set adjacecy matrix
[sy, sx] = size(AdjacentList);
AdjacencyMatrix = zeros(sy, 'logical');
tmp1 = repmat(1:sy, sx, 1);
tmp2 = AdjacentList';
AdjacencyMatrix(sub2ind(size(AdjacencyMatrix), tmp1(:), tmp2(:))) = true;
AdjacencyMatrix = sparse(AdjacencyMatrix);  % sparse matrix for memory reduction

% Set weight matrix
% Weight of the edge sets as max of each ends.
Weight = zeros(sy, 'double');
tmp3 = zeros(sy, sx, 'double');
for i=2:sx
    % max of each ends
    tmp3(:,i) = max(E(AdjacentList(:,1)), E(AdjacentList(:,i)));
end
tmp3 = tmp3';
Weight(sub2ind(size(Weight), tmp1(:), tmp2(:))) = tmp3(:);
Weight = sparse(Weight);    % sparse matrix for memory reduction

% Set start and end point
StartPos = LocalMinIndex;
EndPos = LocalMinIndex;

% Dijkstra
fShowFigure = true;
[Cost, Path] = dijkstra(AdjacencyMatrix, Weight, StartPos, EndPos, fShowFigure);

% Show dendrogram
Y = nonzeros(tril(Cost))';
Z = linkage(Y);
figure(102);
dendrogram2(Z, 'data', E(LocalMinIndex));     % Matlab original dendrogram() cannot show minus distance
title('Disconnectivity Graph', 'FontSize', 16);

catch ME
    % Error happens. Usually, the number of local minimum is too few.
    figure(102);
    title('No Disconnectivity Graph', 'FontSize', 16);
end

