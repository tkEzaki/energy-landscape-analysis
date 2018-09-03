function E = mfunc_Energy(h,J)
% Calculate energy

nodeNumber = size(h,1);
vectorList = mfunc_VectorList(nodeNumber);
numVec = size(vectorList,2);

E = -diag((0.5*J*vectorList)' * vectorList) ...
    - sum(((h * ones(1,numVec)) .* vectorList)', 2);




