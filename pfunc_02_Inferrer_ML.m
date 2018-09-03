% 2016/11/11 by T. Ezaki 
% This function infers h and J by maximum likelihood estimation. 
% binarizedData: nodeNumber x tmax

function [h,J] = pfunc_02_Inferrer_ML(binarizedData)

[nodeNumber,dataLength] = size(binarizedData);
% tuning parameters
iterationMax = 5000000;
permissibleErr = 0.00000001;
dt = 0.2;


dataMean = mean(binarizedData,2);
dataCorrelation = (binarizedData*binarizedData')/dataLength;

h = zeros(nodeNumber,1);
J = zeros(nodeNumber);

for t=1:iterationMax
    [modelMean, modelCorrelation] = mfunc_ModelMeanCorrelation(h,J);
    dh = dt * (dataMean-modelMean);
    dJ = dt *  (dataCorrelation-modelCorrelation);
    dJ = dJ - diag(diag(dJ));% Jii = 0
    h = h + dh;
    J = J + dJ;
    
    if (sqrt(norm(dJ,'fro')^2 + norm(dh)^2)/nodeNumber/(nodeNumber+1) < permissibleErr)
        break;
    end
end
end