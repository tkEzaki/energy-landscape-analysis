%1 This function binarizes original data with respect to a threshold value.
function [binarizedData] = pfunc_01_Binarizer(originalData, threshold)
[nodeNumber,dataLength] = size(originalData);
average = mean(originalData,2);
binarizedData = sign(originalData - average*ones(1,dataLength) - (threshold+eps)*ones(nodeNumber,dataLength));%should not be equal to zero
end