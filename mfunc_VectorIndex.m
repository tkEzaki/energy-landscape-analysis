function [vectorIndex, EnergyIndex] = mfunc_VectorIndex(vectorList)
% Calculate vector index
%
% So as to speed up calculation, get the vector index
% from binary of vector value.
%
% Example: vectorList = mfunc_VectorList(3)'
%     -1    -1    -1
%      1    -1    -1
%     -1     1    -1
%     -1    -1     1
%      1     1    -1
%      1    -1     1
%     -1     1     1
%      1     1     1
%
% binarize vectorList (the value -1 turns to 0)
%
%    0   0   0  = 0
%    1   0   0  = 4
%    0   1   0  = 2
%    0   0   1  = 1
%    1   1   0  = 6
%    1   0   1  = 5
%    0   1   1  = 3
%    1   1   1  = 7
% 
% Then, vectorIndex = above value + 1 because Matlab index starts 1 (not 0)
%
%      1
%      5
%      3
%      2
%      7
%      6
%      4
%      8
%
vectorIndex = bin2dec(num2str(double(vectorList'==1))) + 1;

% EnergyIndex is inverse of vectorIndex
[dummy, EnergyIndex] = sort(vectorIndex);


