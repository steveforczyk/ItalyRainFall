function [nowdate,values] = ParseRistSection1(teststr)
% This function will parse the output string for Rist Section 1 Data 
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 10,2024
% Revised
% Classification: Unclassified/Public Domain
nowdate='01/01/1920';
values=zeros(9,1);
nowdate=teststr(1:10);
iper=strfind(teststr,'.');
numper=length(iper);
for ii=1:numper
    is=iper(ii)-3;
    ie=iper(ii)+3;
    valuesstr=teststr(is:ie);
    values(ii,1)=str2double(valuesstr);
    ab=1;
end
end