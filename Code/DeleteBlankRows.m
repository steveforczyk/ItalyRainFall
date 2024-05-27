function [outArray] = DeleteBlankRows(inArray,ictr,imax)
% This function will clip null values from the bottom of an array
% Written By: Stephen Forczyk
% Created: May 10,2024
% Revised: -----
% Classification: Unclassified/Public Domain
outArray = zeros(ictr,1);
for ii=1:ictr
    outArray(ii,1)=inArray(ii,1);
end
ab=1;
end