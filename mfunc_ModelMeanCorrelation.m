% This function calculates mean and correlation with respect to the pairwise MEM
% with given h and J.
function [modelMean, modelCorrelation] = mfunc_ModelMeanCorrelation(h,J)
nodeNumber = size(h,1);
vectorlist =  mfunc_VectorList(nodeNumber);
prob = mfunc_StateProb(h,J);

modelMean = mean((vectorlist.*(ones(nodeNumber,1)*prob')),2)*2^nodeNumber;
modelCorrelation = (vectorlist.*(ones(nodeNumber,1)*(sqrt(prob'))))*(vectorlist.*(ones(nodeNumber,1)*(sqrt(prob'))))';
end

