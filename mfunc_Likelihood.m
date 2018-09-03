function likelihood = mfunc_Likelihood(h, J, binarizedData)
dataLength = size(binarizedData, 2);
%likelihood =  sum(sum(binarizedData.*(0.5*J*binarizedData),2)) + sum(h' * binarizedData, 2) - 2*sum(sum(log(cosh(0.5*J*binarizedData+h*ones(1,dataLength))),2));
likelihood =  sum(sum(binarizedData.*(J*binarizedData),2)) + sum(h' * binarizedData, 2) - sum(sum(log(2*cosh(J*binarizedData+h*ones(1,dataLength))),2));
likelihood = likelihood / dataLength;
end  