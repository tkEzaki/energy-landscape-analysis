function BasinNumber = mfunc_GetBasinNumber(StateNumber, BasinGraph, LocalMinIndex)
% Get Basin Number
BasinNumber = zeros(length(StateNumber),1);
Nmin = length(LocalMinIndex);

tmp = BasinGraph(StateNumber, 3);
for i=1:Nmin
   BasinNumber(tmp == LocalMinIndex(i)) = i; 
end



