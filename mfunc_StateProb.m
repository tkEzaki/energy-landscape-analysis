function probMEM = mfunc_stateProb(h,J)

nodeNumber = size(h,1);
vectorList = mfunc_VectorList(nodeNumber);
numVec = size(vectorList,2);

Z = sum(exp(-(-diag((0.5*J*vectorList)' * vectorList) - sum(((h * ones(1,numVec)) .* vectorList)', 2))),1);
probMEM = exp(-(-diag((0.5*J*vectorList)' * vectorList) - sum(((h * ones(1,numVec)) .* vectorList)', 2))) ./ Z;




