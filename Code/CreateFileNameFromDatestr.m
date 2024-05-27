function [MatFileName] = CreateFileNameFromDatestr(DateTimeHold,suffix)
% This function will create a Matlabe File name for data storage for
% a Daily File composed of the sum of 24 hourly files
% 
% Written By Stephen Forczyk
% Created: April 17,2024
% Revised:-----
% Classification: Unclassified/Public Domain


Tdmyhrminsec=DateTimeHold;
MatFileName='Test.mat';
dstr=char(DateTimeHold);
[idash]=strfind(dstr,'-');
% Find out whether the dateimestring has a 1 or 2 digit date
is=1;
ie=idash(1)-1;
strlen=ie-is+1;
if(strlen==1)% 1 Digit date
    daystr=strcat(num2str(0),dstr(is:ie));
    monthstr=dstr(3:5);
    is=idash(2)+1;
    ie=is+3;
    yearstr=dstr(is:ie);
    namestr=strcat(monthstr,'-',daystr,'-',yearstr);
elseif(strlen>1) % Two digit case
     daystr=dstr(1:2);
     monthstr=dstr(4:6);
    is=idash(2)+1;
    ie=is+3;
    yearstr=dstr(is:ie);
    namestr=strcat(monthstr,'-',daystr,'-',yearstr);

end
MatFileName=strcat(namestr,suffix);
end