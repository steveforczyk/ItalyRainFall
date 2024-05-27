function GetDatasetStartAndEndTimes()
% This function will get the start and end times of the dataset
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 11,2024
% Revised:
% Classification" Unclassified/Public Domain
global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallFile3 RainFallFile3C;
global StationStr StationNum RainFallFile RainFallCatalogedFile;
global RainFallTime RainFallFlag RainFallAmt RainFallName;

global ProvinceNames RainFallTime30 I30max;
global PotentialStorms ConsolidatedStorm  DefinedStorms;
global numtimesstep SelectedYears SelStartIndex SelEndIndex numused numedused30;
global StormThreshTot StormThresh360 StormThresh15;
global firstyearstr firstyear firstdaystr firstday firstmonthstr;
global firsthrstr firsthr firstminstr firstmin firstsecstr firstsec;
global lastyearstr lastyear lastdaystr lastday lastmonthstr;
global lasthrstr lasthr lastminstr lastmin lastsecstr lastsec;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30 ER30 VR30 KEnergy RainRate;
global RFactorTable RFactorTT DiagTable DiagTT;
global PotentialStormsTable PotentialStormsTT;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath excelpath;
global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie iFastSave;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig;
global iStorms;

% Get the starting date info of the dataset
teststr=(RainFallTime(1));
firststr=char(teststr);
firstrlen=length(firststr);
idash=strfind(firststr,'-');
numdash=length(idash);
is=idash(2)+1;
ie=is+3;
firstyearstr=firststr(is:ie);
firstyear=str2double(firststr(is:ie));
is=1;
ie=2;
firstdaystr=firststr(is:ie);
firstday=str2double(firstdaystr);
is=idash(1)+1;
ie=idash(2)-1;
firstmonthstr=firststr(is:ie);
if(firstrlen<12)
    firsthrstr='00';
    firstminstr='00';
    firstsecstr='00';
    firsthr=str2double(firsthrstr);
    firstmin=str2double(firstminstr);
    firstsec=str2double(firstsecstr);
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
    firsthr=str2double(firsthrstr);
    firstmin=str2double(firstminstr);
    firstsec=str2double(firstsecstr);

end
fprintf(fid,'\n');
fprintf(fid,'%s\n', 'Dataset Time Limits');
startdatastr=strcat('StartDataDate-',firstyearstr,'-',firstdaystr,'-',firstmonthstr,...
    '-',firsthrstr,':',firstminstr,':',firsthrstr);
fprintf(fid,'%s\n',startdatastr);
% Get the ending time of the dataset
teststr=(RainFallTime(numtimesstep));
laststr=char(teststr);
lastlen=length(laststr);
idash=strfind(laststr,'-');
numdash=length(idash);
is=idash(2)+1;
ie=is+3;
lastyearstr=laststr(is:ie);
lastyear=str2double(laststr(is:ie));
is=1;
ie=2;
lastdaystr=laststr(is:ie);
lastday=str2double(lastdaystr);
is=idash(1)+1;
ie=idash(2)-1;
lastmonthstr=laststr(is:ie);
if(firstrlen<12)
    lasthrstr='00';
    lastminstr='00';
    lastsecstr='00';
    lasthr=str2double(firsthrstr);
    lastmin=str2double(firstminstr);
    lastsec=str2double(firstsecstr);
else
    icolon=strfind(firststr,':');
    numcolon=length(icolon);
    is=icolon(1)-2;
    ie=is+1;
    lasthrstr=laststr(is:ie);
    is=icolon(1)+1;
    ie=is+1;
    lastminstr=laststr(is:ie);
    is=icolon(2)+1;
    ie=is+1;
    lastsecstr=laststr(is:ie);
    lasthr=str2double(lasthrstr);
    lastmin=str2double(lastminstr);
    lastsec=str2double(lastsecstr);

end
enddatastr=strcat('EndDataDate-',lastyearstr,'-',lastdaystr,'-',lastmonthstr,...
    '-',lasthrstr,':',lastminstr,':',lasthrstr);
fprintf(fid,'%s\n',enddatastr);
fprintf(fid,'%s\n', 'End Dataset Time Limits');
end