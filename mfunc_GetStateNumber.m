function StateNumber = mfunc_GetStateNumber(binarizedData)
% Get State Number from binarized Data

% if binarizedData is N x M matrix, binarizedData(N,:) is MSB.
% Need to flipud.

%dat = (binarizedData > 0);
dat = flipud(binarizedData > 0);

StateNumber = bin2dec(num2str(dat'));
StateNumber = StateNumber + 1;
