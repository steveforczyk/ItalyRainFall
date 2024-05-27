function [NewFileList] = SortDailyFilesInTimeOrder(FileList)
% The purpose of this function is to sort the Daily RainFall Accumilation files in ascending
% time order. This routine is needed because the operating system order in
% the folder can be disprupted by small name changes. This method will read
% the file data date to get around this limitation
% 
% Written By: Stephen Forczyk
% Created: April 19,2024


% Revised:-----
% Classification: Public Domain

numFiles=length(FileList);
NewFileList=cell(numFiles,1);
DateNums=zeros(numFiles,1);
% Jan-01-1981-DailyAcumil.mat
% Now calculate the datetime for each file
for n=1:numFiles
    nowFile=FileList{n,1};
    [iper]=strfind(nowFile,'-');
    is=iper(1)+1;
    ie=iper(2)-1;
    dstr=nowFile(is:ie);
    dd=str2double(dstr);
    is=iper(2)+1;
    ie=iper(3)-1;
    yd=str2double(nowFile(is:ie));
    MonthStr=(nowFile(1:3));
    [mm] = ConvertMonthStrToNumber(MonthStr);
    DateNums(n,1) = datenum(yd,mm,dd);
    ab=2;
end
[SortDate,index]=sort(DateNums);
for n=1:numFiles
    nowInd=index(n,1);
    NewFileList{n,1}=FileList{nowInd,1};
end

end