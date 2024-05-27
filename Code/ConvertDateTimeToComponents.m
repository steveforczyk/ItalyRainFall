function [Year,Month,Day,Hour,Minutes,Seconds] = ConvertDateTimeToComponents(RainFallTime,index)
% This function will convert a datetimestr into its component parts
% Written By: Stephen Forczyk/Joydeb Saha
% Created" May 8,2024
% Revised:----
% Classification: Unclassified/Public Domain
Year=1981;
Month=1;
Day=1;
Hour=0;
Minutes=0;
Seconds=0;
teststr=(RainFallTime(index));
firststr=char(teststr);
firstrlen=length(firststr);
idash=strfind(firststr,'-');
numdash=length(idash);
is=idash(2)+1;
ie=is+3;
firstyearstr=firststr(is:ie);
Year=str2double(firststr(is:ie));
is=1;
ie=2;
firstdaystr=firststr(is:ie);
Day=str2double(firstdaystr);
is=idash(1)+1;
ie=idash(2)-1;
firstmonthstr=firststr(is:ie);
[Month] = ConvertMonthStrToNumber(firstmonthstr);
if(firstrlen<12)
    firsthrstr='00';
    firstminstr='00';
    firstsecstr='00';
    Hour=str2double(firsthrstr);
    Minutes=str2double(firstminstr);
    Seconds=str2double(firstsecstr);
else
    icolon=strfind(firststr,':');
    numcolon=length(icolon);
    is=icolon(1)-2;
    ie=is+1;
    firsthrstr=firststr(is:ie);
    is=icolon(1)+1;
    ie=is+1;
    firstminstr=firststr(is:ie);
    is=icolon(2)+1;
    ie=is+1;
    firstsecstr=firststr(is:ie);
    Hour=str2double(firsthrstr);
    Minutes=str2double(firstminstr);
    Seconds=str2double(firstsecstr);

end
end