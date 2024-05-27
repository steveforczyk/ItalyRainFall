% This script will calculation the R factor for the Rusle Equation
% The Rev 1 version was created for the purpose of defining the time
% periods when the rainfall is sufficient to be called a storm
% Written By Stephen Forczyk and Dr Joydeb Saha
% Created: May 7,2024
% Revised: 
% Source:Rainfall erosivity in Italy: a national scale spatio-
% temporal assessment https://doi.org/10.1080/17538947.2016.1148203

global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallFile3 RainFallFile3C;
global StationStr StationNum RainFallFile RainFallCatalogedFile;
global RainFallTime RainFallFlag RainFallAmt RainFallName;
global ProvinceNames RainFallTime30 I30max;
global numtimesstep SelectedYears SelStartIndex SelEndIndex numused numedused30;
global StormThreshTot StormThresh360 StormThresh15;
global firstyearstr firstyear firstdaystr firstday firstmonthstr;
global firsthrstr firsthr firstminstr firstmin firstsecstr firstsec;
global lastyearstr lastyear lastdaystr lastday lastmonthstr;
global lasthrstr lasthr lastminstr lastmin lastsecstr lastsec;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30;
global RFactorTable RFactorTT;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath;
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
global isumhourlyfiles sf1;% sf1 is the scale factor to go from kg/m^2 to inches of water
% for the given time period


%% Paths
datapath='D:\Joydeb\Data\';
matlabpath='D:\Joydeb\Matlab_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='D:\Joydeb\LogFiles\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
tablepath='D:\Joydeb\Tables\';
jpegpath='D:\Joydeb\Jpeg_Files\';
govjpegpath='D:\Joydeb\gov_jpeg\';
dailyfilepath='D:\Joydeb\Daily_Files\';
rainfalldatapath='K:\Joydeb\RainFall_Files\';
%% Default Values
ItalyRainFallFile='CMCC_italy-hist-1981-1.nc';
ItalyRasterDataFile='ItalyERA5RasterData.mat';
% the next two files are single location rainfall amounts taken over 1984
% to 2021 at 5 minute intervals
RainFallFile1='VE_0003_5min_newflag.mat';
RainFallFile1C='VE_0003_5min_cataloged.mat';
RainFallFile2='VE_0009_5min_newflag.mat';
RainFallFile2C='VE_0009_5min_cataloged.mat';
RainFallFile3='VE_0234_5min_newflag.mat';
RainFallFile3C='VE_0234_5min_cataloged.mat';
StormThresh360=1.27; % Min RainFalll in 6 hours to be a storm
StormThreshTot=12.7; % Min Total RainFalll to declare a storm
StormThresh15=6.35; % Min Gully Washer Threshold 15 min rainfall
% Store The Map Boundaries
westEdge=0;
eastEdge=22;
northEdge=50;
southEdge=35.;
idecode=0;
framecounter=0;
iMovie=1;
iCityPlot=1;
icataloged=1;
RainFallConstantsFile='ItalyRainFallConstants.mat';
StatValues=zeros(13,1);
deg2rad=pi/180;
iprecomputed=0;
iCreateMasks=0;
eventctr=0;
norainctr=0;


iFastSave=1;
iLogo=1;
LogoFileName1='UPadua_Logo.jpg';
isumhourlyfiles=1;
iCheckConfig=1;
sf1=.039370;
FoundData=zeros(60,3);
% Set Cells
MaskPoints=cell(22,2);
MaskPoints{1,1}='MaskName';
MaskPoints{1,2}='Number of Values';
MaskPoints{1,3}='Mask Area km^2';
% Load in some needed files just 1 time
% eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
% load('ItalyERA5RasterData.mat');
% load('ItalyRainFallConstants.mat');
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% load('ItalyMasks.mat');

% Set up the cell array for the Province RainFall Totals in weight inches
% over the selected study time period
% ProvinceRainFallTotals=cell(20,1);
% for kk=1:20
%     ProvinceRainFallTotals{kk,1}=0;
% end
% Set up the cell array for the Province Names
ProvinceNames=cell(20,1);
ProvinceNames{1,1}='Abruzzo';
ProvinceNames{2,1}='Apulia';
ProvinceNames{3,1}='Basilicata';
ProvinceNames{4,1}='Calabria';
ProvinceNames{5,1}='Campania';
ProvinceNames{6,1}='Emilia';
ProvinceNames{7,1}='Friuli';
ProvinceNames{8,1}='Lazio';
ProvinceNames{9,1}='Liguria';
ProvinceNames{10,1}='Lombardia';
ProvinceNames{11,1}='Marche';
ProvinceNames{12,1}='Molise';
ProvinceNames{13,1}='Piemonte';
ProvinceNames{14,1}='Sardegna';
ProvinceNames{15,1}='Sicily';
ProvinceNames{16,1}='Toscana';
ProvinceNames{17,1}='Trentino';
ProvinceNames{18,1}='Umbria';
ProvinceNames{19,1}='Valla';
ProvinceNames{20,1}='Veneto';
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start StormFinder at-',startruntime);
logfilename=startruntime;
logfiledbl=double(logfilename);
% find the blank space in the date and replace it with a '-' to make a
% legalfilename
[iblank]=find(logfiledbl==32);
numblank=length(iblank);
for n=1:numblank
    is=iblank(n);
    ie=is;
    logfilename(is:ie)='-';
end
[icolon]=strfind(logfilename,':');
numcolon=length(icolon);
for n=1:numcolon
    is=icolon(n);
    ie=is;
    logfilename(is:ie)='-';
end
toolbox='MATLAB Report Generator';
[RptGenPresent] = ToolboxChecker(toolbox);
toolbox='Image Processing Toolbox';
[ImageProcessPresent]=ToolboxChecker(toolbox);
eval(['cd ' logfilepath(1:length(logfilepath)-1)]);
logfilename=strcat('StormFinder-',logfilename,'.txt');
fid=fopen(logfilename,'w');
dispstr=strcat('Opened Log file-',logfilename,'-for writing');
disp(dispstr);
fprintf(fid,'%50s\n',startrunstr);
%% Call some routines that will create nice plot window sizes and locations
% Establish selected run parameters
imachine=2;
if(imachine==1)
    widd=720;
    lend=580;
    widd2=1000;
    lend2=700;
elseif(imachine==2)
    widd=1080;
    lend=812;
    widd2=1000;
    lend2=700;
elseif(imachine==3)
    widd=1296;
    lend=974;
    widd2=1200;
    lend2=840;
end
% Set a specific color order
set(0,'DefaultAxesColorOrder',[1 0 0;
    1 1 0;0 1 0;0 0 1;0.75 0.50 0.25;
    0.5 0.75 0.25; 0.25 1 0.25;0 .50 .75]);
% Set up some defaults for a PowerPoint presentationwhos
scaling='true';
stretching='false';
padding=[75 75 75 75];
igrid=1;
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);
igo=1;
% Set up some more colors
SetUpExtraColors()
almond=[LandColors(1,1) LandColors(1,2) LandColors(1,3)];
beige=[LandColors(3,1) LandColors(3,2) LandColors(3,3)];
wheat=[LandColors(5,1) LandColors(5,2) LandColors(5,3)];
butterscotch=[LandColors(8,1) LandColors(8,2) LandColors(8,3)];
% Read in 1 RainFallFile
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
[RainFallFile,nowpath] = uigetfile('*.mat','Select One File', ...
'MultiSelect', 'off');
[iunder]=strfind(RainFallFile,'_');
numunder=length(iunder);
is=iunder(1)+1;
ie=iunder(2)-1;
StationStr=string(RainFallFile(is:ie));
StationNum=str2double(StationStr);
% See if this file is a catalog file
a100=contains(RainFallFile,'cataloged','IgnoreCase',true);
if(a100==1)
    icataloged=1;
else
    icataloged=0;
    a98=strfind(RainFallFile,'newflag');
    a99=strfind(RainFallFile,'.');
    is=a98(1)-1;
    ie=a99(1)-1;
    stub=RainFallFile(1:is);
    RainFallCatalogedFile=strcat(stub,'cataloged.mat');
end

ab=1;
% Read in 1 of the RainFall Files
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
load(RainFallFile)
RainFallName=S.name;
RainFallTime=S.time;
RainFallAmt=S.vals;
RainFallFlag=S.flag;
numtimesstep=length(RainFallAmt)-1;
loadstr=strcat('Loaded file-',RainFallFile);
fprintf(fid,'%50s\n',loadstr);
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
ab=1;
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
fclose(fid)
ab=1;
%% Go through the data to find exceedances
[ibig]=find(RainFallAmt>0);
numbig=length(ibig);
Rain30_Max=zeros(6,1);
Rain60_Max=zeros(12,1);
for i=1:numbig
    RainValues30=zeros(6,1);
    RainValues60=zeros(12,1);
    kx=ibig(i,1);
    ictr=0;
    for k=kx:1:kx+11
        ictr=ictr+1;
        RainValues60(ictr,1)=RainFallAmt(k,1);
    end
    R60=max(RainValues);
    Rain60_Max(i,1)=R60;
    dispstr=strcat('Sample Number=',num2str(kx),'-Exceedance Number=',num2str(i),'-Max60=',num2str(R60));
    disp(dispstr)
    ab=1;
end
ab=2;