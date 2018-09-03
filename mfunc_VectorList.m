%This function creates a state vectorList: NumNode x 2^NumNode
function vectorList = mfunc_VectorList(nodeNum)

node = 2^nodeNum;

tmp = dec2bin((0:node-1)');

vectorList = zeros(node, nodeNum, 'double');

vectorList(tmp == '0') = -1;
vectorList(tmp == '1') = 1;
vectorList = flipud(vectorList');

% vectorList = -ones(nodeNum, 1);
% 
% for ite = 1:nodeNum % ite = num of the active nodes
%     
%     activeNodeList = nchoosek(1:nodeNum,ite); % obtain a list of possible configurations
%     
%     vectorListTemp = - ones(nodeNum, size(activeNodeList,1));
%     
%     for ite2 = 1:size(activeNodeList,1)
%         vectorListTemp(activeNodeList(ite2,:),ite2) = 1;
%     end
%     
%     vectorList = [vectorList,vectorListTemp];
%     
% end
% clear ite ite2 activeNodeList vectorListTemp
