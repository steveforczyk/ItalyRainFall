function [values] = ParseRistSection5(teststr)
% This function will parse the output string for Rist Section 5 Data 
% This is the monthly rainfall averages
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 15,2024
% Revised
% Classification: Unclassified/Public Domain

values=zeros(5,1);
monthstr=teststr(1:2);
month=str2double(monthstr);
values(1,1)=month;
iper=strfind(teststr,'.');
testlen=length(teststr);
numper=length(iper);
for ii=1:numper
    is=iper(ii)-4;
    ie=iper(ii)+4;
    if(ie>testlen)
        ie=testlen;
    end
    valuesstr=teststr(is:ie);
    values(ii+1,1)=str2double(valuesstr);
    ab=1;
end
ab=1;
end