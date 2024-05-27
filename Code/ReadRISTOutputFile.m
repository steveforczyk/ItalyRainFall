% This script will read the storm output file from the RIST code and turn
% it into a file that can be used by Excel and Matlab
% Written By: Stephen Forczyk/Joydeb Saha
% Created:May 10,2024
% Revised:May 15,2024 converting section 1 data to tables
% Classification: Unclassified/Public Domain

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
global StartPeriodStr StartPeriod EndPeriodStr EndPeriod YearPeriod StartMonth EndMonth totalperiod;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30;
global Section1Table Section1TT Section1STT EventTimes Section1BasicStats Section1BasicStatsHdr;
global RISTOutputFile Section1BasicStatsTable Section1SATT Section1DurTT Section1DurSTT;
global DateCell DateStr Precip Duration MAX_5 MAX_10 MAX_15 MAX_30 MAX_60; 
global ENERGY EI130;
global Period Precip24 Energy24 EI3024 EI24 ACC24_EI ErosDensity24;
global Month12 Precip12 Energy12  EI13012 ErosDensity12;
global TotalPrecipSec1 TotalRainTimeSec1 RainFracSection1;
global Section3Table Section3TT Section5Table Section5TT;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath ristpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global fid fid2;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie iFastSave;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig iExcel iRunExcelMacro;
global isumhourlyfiles sf1;% sf1 is the scale factor to go from kg/m^2 to inches of water
global min5peryear total5minper nsortlim;
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
csvfilepath='K:\Joydeb\CSV_Files\';
ristpath='K:\Joydeb\RISTTool_Output\';
excelpath='K:\Joydeb\Excel_Files\';
%% Default Values
ItalyRainFallFile='CMCC_italy-hist-1981-1.nc';
ItalyRasterDataFile='ItalyERA5RasterData.mat';
RISTOutputFile='Padua_VE_0234_MetricOutput.txt';
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
framecounter=0;
idecode=0;
iCityPlot=1;
icataloged=1;
RainFallConstantsFile='ItalyRainFallConstants.mat';
StatValues=zeros(13,1);
deg2rad=pi/180;
iprecomputed=0;
iCreateMasks=0;
eventctr=0;
norainctr=0;
% Flag values
idecode=0;
iMovie=1;
iExcel=1;
iRunExcelMacro=0;
iFastSave=1;
iLogo=1;
%LogoFileName1='UPadua_Logo.jpg';
LogoFileName1='UPadua_Logo3.jpg';
isumhourlyfiles=1;
iCheckConfig=1;
nsortlim=25;
sf1=.039370;
min5peryear=365*24*12;
FoundData=zeros(60,3);
%% Set Cells
Section1BasicStats=cell(9,10);
Section1BasicStatsHdr=cell(1,10);
Section1BasicStatsHdr{1,1}='Variable';
Section1BasicStatsHdr{1,2}='Measurements';
Section1BasicStatsHdr{1,3}='Mean';
Section1BasicStatsHdr{1,4}='Median';
Section1BasicStatsHdr{1,5}='Mode';
Section1BasicStatsHdr{1,6}='StdDev';
Section1BasicStatsHdr{1,7}='MinVal';
Section1BasicStatsHdr{1,8}='MaxVal';
Section1BasicStatsHdr{1,9}='Skewness';
Section1BasicStatsHdr{1,10}='Kurtosis';



%% Initialize some arrays to Pre Allocate Memory-this is for section 1
DateCell=cell(10000,1);
Precip=zeros(10000,1);
Duration=zeros(10000,1);
MAX_5=zeros(10000,1);
MAX_10=zeros(10000,1);
MAX_15=zeros(10000,1);
MAX_30 =zeros(10000,1);
MAX_60=zeros(10000,1);
ENERGY=zeros(10000,1);
EI130=zeros(10000,1);

%% Do the same for section 3
Period=zeros(24,1);
Precip24=zeros(24,1);
Energy24=zeros(24,1);
EI3024=zeros(24,1);
EI24=zeros(24,1);
ACC24_EI=zeros(24,1);
ErosDensity24=zeros(24,1);
%% Do the same for section 5
Month12=zeros(12,1);
Precip12=zeros(12,1);
Energy12=zeros(12,1);
EI13012=zeros(12,1);
ErosDensity12=zeros(12,1);
tic;
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start CalculateRainFallErosion Factor at-',startruntime);
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
logfilename=strcat('RISTFileOutput-',logfilename,'.txt');
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
%% Check The system configuration
if(iCheckConfig==1)
    SpecifyMatlabConfiguration('ReadRISTOutputFile.m')
end
%% Select a single RIST Output file
% Load up the RISTOutput file
eval(['cd ' ristpath(1:length(ristpath)-1)]);
[RISTOutputFile,nowpath] = uigetfile('*.txt','Select One RIST Output File', ...
'MultiSelect', 'off');
%eval(['cd ' csvfilepath(1:length(csvfilepath)-1)]);
[ filelines ] = file2cell(RISTOutputFile,false);% Read the whole file into a cell array
numlines=length(filelines);
hdrline4=filelines{4,1};
hdrline5=filelines{5,1};
inewsection=0;
isection=0;
ictr5=0;
irepeat=0;
for n=6:numlines
    teststr=filelines{n,1};
    tf=contains(teststr,'-------------------');
    tf1=contains(teststr,'Reporting Period:');
    if(tf1==1)
        teststrlen=length(teststr);
        [icolon]=strfind(teststr,':');
        [idash]=strfind(teststr,'-');
        is=icolon(1)+2;
        ie=idash(1)-1;
        StartPeriodStr=teststr(is:ie);
        [islash]=strfind(StartPeriodStr,'/');
        is=islash(1)+1;
        ie=is+3;
        StartPeriod=str2double(StartPeriodStr(is:ie));
        is=1;
        ie=is+1;
        StartMonth=str2double(StartPeriodStr(is:ie));
        is=idash(1)+1;
        ie=is+7;
        EndPeriodStr=teststr(is:ie);
        [islash2]=strfind(EndPeriodStr,'/');
        is=islash2(1)+1;
        ie=is+3;
        EndPeriod=str2double(EndPeriodStr(is:ie));
        is=2;
        ie=is+1;
        EndMonth=str2double(EndPeriodStr(is:ie));
        YearPeriod=EndPeriod-StartPeriod+1;
        EMYrs=EndPeriod+EndMonth/12;
        SMYrs=StartPeriod+StartMonth/12;
        totalperiod=EMYrs-SMYrs;
        total5minper=totalperiod*min5peryear;
        periodstr=strcat('Data Spanned-',StartPeriodStr,'-to-',EndPeriodStr,'-or-',num2str(YearPeriod),'-Years');
        irepeat=irepeat+1;
        if(irepeat==1)
            fprintf(fid,'%s\n',periodstr);
        end
        
    end
    if(tf==1)
        inewsection=inewsection+1;
        if(inewsection==1)
           isection=1;
            isec1ctr=0;
        end
        if(inewsection>1)
            inewssection=0;
            isection=isection+1;
            if(isection==2)
                inArray=Precip;
                [Precip] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=Duration;
                [Duration] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=MAX_5;
                [MAX_5] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=MAX_10;
                [MAX_10] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=MAX_15;
                [MAX_15] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=MAX_30;
                [MAX_30] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=MAX_60;
                [MAX_60] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=ENERGY;
                [ENERGY] = DeleteBlankRows(inArray,isec1ctr,10000);
                inArray=EI130;
                [EI130] = DeleteBlankRows(inArray,isec1ctr,10000);
                
            end
        end
    end
    if(tf~=1) % This section contains data
        if(isection==1)
            [nowdate,values] = ParseRistSection1(teststr);
            isec1ctr=isec1ctr+1;
            [islash]=strfind(nowdate,'/');
            numslash=length(islash);
            is=islash(1);
            nowdate2=nowdate;
            nowdate2(is:is)='-';
            is=islash(2);
            nowdate2(is:is)='-';
            if(isec1ctr==1)
                nowdate3=nowdate2;
            else
                nowdate3=strvcat(nowdate3,nowdate2);
            end

            Precip(isec1ctr,1)=values(1,1);
            Duration(isec1ctr,1)=values(2,1);
            MAX_5(isec1ctr,1)=values(3,1);
            MAX_10(isec1ctr,1)=values(4,1);
            MAX_15(isec1ctr,1)=values(5,1);
            MAX_30(isec1ctr,1)=values(6,1);
            MAX_60(isec1ctr,1)=values(7,1);
            ENERGY(isec1ctr,1)=values(8,1);
            EI130(isec1ctr,1)=values(9,1);
            ab=2;
        elseif(isection==2)
            ab=1;
        elseif(isection==3)
            ab=1;
            [nowpart,values] = ParseRistSection3(teststr);
            Period(nowpart,1)=nowpart;
            Precip24(nowpart,1)=values(1,1);
            Energy24(nowpart,1)=values(2,1);
            EI3024(nowpart,1)=values(3,1);
            EI24(nowpart,1)=values(4,1);
            ACC24_EI(nowpart,1)=values(5,1);
            ErosDensity24(nowpart,1)=values(6,1);
            if(nowpart==24)
                ab=1;
            end
        elseif(isection==4)
            ab=1;
        elseif(isection==5)
            ab=1;
            ictr5=ictr5+1;
            [values] = ParseRistSection5(teststr);
            Month12(ictr5,1)=values(1,1);
            Precip12(ictr5,1)=values(2,1);
            Energy12(ictr5,1)=values(3,1);
            EI13012(ictr5,1)=values(4,1);
            ErosDensity12(ictr5,1)=values(5,1);

        end
    end
end
TotalPrecipSec1=sum(Precip);
TotalRainTimeSec1=sum(Duration);
TotalRain5minPeriodsSec1=12*TotalRainTimeSec1;
RainFracSection1=TotalRain5minPeriodsSec1/total5minper;
EventTimes = datetime(nowdate3,'InputFormat','MM-dd-yyyy','Format','preserveinput');
ab=1;
fileoutstr=strcat('Finished Decoding data file-',RISTOutputFile);
fprintf(fid,'%s\n',fileoutstr);
fprintf(fid,'%s\n','---------- Start Section 1 Output---------');
totprecipstr=strcat('Total Precip-',num2str(TotalPrecipSec1),'-of rain in mm');
fprintf(fid,'%s\n',totprecipstr);
totprecipstr1=strcat('Total Precip-',num2str(TotalPrecipSec1/25.4),'-of rain in inches');
fprintf(fid,'%s\n',totprecipstr1);
totprecipstr2=strcat('Total Precip-',num2str(TotalPrecipSec1/(25.4*totalperiod)),'-of rain in inches-per year');
fprintf(fid,'%s\n',totprecipstr2);
rainfracstr=strcat('Fraction Of Time Rain Falling=',num2str(RainFracSection1));
fprintf(fid,'%s\n',rainfracstr);
fprintf(fid,'%s\n','---------- End Section 1 Output---------');
CalculateDescriptiveStats1()
% Create a file stub to be used for future file names
[iunder]=strfind(RISTOutputFile,'_');
is=1;
ie=iunder(2);
numunder=length(iunder);
FileStub=RISTOutputFile(is:ie);
%% Now Build a Table to hold the data from Section 1 this csn be used in some plots
Section1Table=table(Precip(:,1),Duration(:,1),MAX_5(:,1),MAX_10(:,1),MAX_15(:,1), ...
    MAX_30(:,1),MAX_60(:,1),ENERGY(:,1),EI130(:,1),EventTimes,'VariableNames',{'Precip','Duration',...
    'MAX_5','MAX_10','MAX_15','MAX_30','MAX_60','ENERGY','EI130','EventTimes'});
Section1TT = table2timetable(Section1Table,'RowTimes','EventTimes');
% Create another time table based on sorting the original table by Total
% Precip in Ascending Order
[Section1STT,~] = sortrows(Section1TT,1,'descend');
[Section1DurTT,~] = sortrows(Section1TT,2,'descend');
nrows2=height(Section1STT);
% Create a smaller verion of this sorted array with only the bigest
% nsortlim retained
Section1SATT=Section1STT;
Section1SATT(25:nrows2,:)=[];
Section1DurSTT=Section1DurTT;
Section1DurSTT(25:nrows2,:)=[];
% % Rename the ExcelFile
% %copyfile RistTemplate.xlsm myfile2.m
% Save this table as a standalone MatFile
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='Section1Table Section1TT Section1STT Section1SATT Section1DurSTT';
MatFileName=strcat(FileStub,'Section1Table.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created Section1TT-','Contains Basic RainFall Data');
fprintf(fid,'%\n');
fprintf(fid,'%s\n',silstr);
fprintf(fid,'%\n');
%% Start Creating Plots for Section 1 Data
% Plot this data-Start with the total Storm Precip
[iunder]=strfind(RISTOutputFile,'_');
is=1;
ie=iunder(2);
numunder=length(iunder);
%FileStub=RISTOutputFile(is:ie);
titlestr1=strcat(FileStub,'TotalStormPrecip');
titlestr=RemoveUnderScores(titlestr1);
ikind=1;
PlotRistSection1Table(titlestr,ikind)
titlestr1=strcat(FileStub,'RainFallDuration');
titlestr=RemoveUnderScores(titlestr1);
ikind=2;
PlotRistSection1Table(titlestr,ikind)
% Plot some histograms of selected quantities
% Start with MAX-5
numpts2=length(MAX_5);
ikind=1;
titlestr1=strcat(FileStub,'-MAX-5-RainFall');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with MAX-10
numpts2=length(MAX_10);
ikind=2;
titlestr1=strcat(FileStub,'-MAX-10-RainFall');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with MAX-15
numpts2=length(MAX_15);
ikind=3;
titlestr1=strcat(FileStub,'-MAX-15-RainFall');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with MAX-30
numpts2=length(MAX_30);
ikind=4;
titlestr1=strcat(FileStub,'-MAX-30-RainFall');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with MAX-60
numpts2=length(MAX_60);
ikind=5;
titlestr1=strcat(FileStub,'-MAX-60-RainFall');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with ENERGY
numpts2=length(ENERGY);
ikind=6;
titlestr1=strcat(FileStub,'-ENERGY');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with EI130
numpts2=length(EI130);
ikind=7;
titlestr1=strcat(FileStub,'-EI130');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Continue with Precip
numpts2=length(Precip);
ikind=8;
titlestr1=strcat(FileStub,'-Precip');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)

% Continue with Duration
%numpts2=length(Precip);
ikind=9;
titlestr1=strcat(FileStub,'-Storm-Duration');
titlestr=RemoveUnderScores(titlestr1);
PlotRainFallHistogram(ikind,titlestr)
% Compute some basic stats of these values
% Also use CDF plot
%% Create a timetable to hold the section 3 results BiMonthly Binned Data
% Generate table data
yd=StartPeriod;
md=1;
dd=1;
stime=datetime(yd,md,dd);
timestep=days(15);
Section3Table=table(Precip24(:,1),Energy24(:,1),EI3024(:,1),EI24(:,1),ACC24_EI(:,1), ...
     ErosDensity24(:,1),'VariableNames',{'Precip24','Energy24',...
    'EI3024','EI24','ACC24_EI','ErosDensity24'});
Section3TT = table2timetable(Section3Table,'TimeStep',timestep,'StartTime',stime);
%% Create a timetable to hold the section 5 results Monthly Binned Data
% Generate table data
yd=StartPeriod;
md=1;
dd=15;
stime=datetime(yd,md,dd);
timestep=days(30);
Section5Table=table(Precip12(:,1),Energy12(:,1),EI13012(:,1),ErosDensity12(:,1),...
     'VariableNames',{'Precip12','Energy12','EI3012','ErosDensity12'});
Section5TT = table2timetable(Section5Table,'TimeStep',timestep,'StartTime',stime);
ab=1;
% Write This timetable to an Excel File
eval(['cd ' excelpath(1:length(excelpath)-1)]);
%ExcelFileName=strcat(FileStub,'Section1Table.xlsm');
if(iRunExcelMacro==1)
    ExcelFileName='RistTemplate.xlsm';
else
    ExcelFileName=strcat(FileStub,'Section1Table.xlsm');
end
writetimetable(Section1TT,ExcelFileName,'Sheet','Section1Results');
dispstr=strcat('Wrote Table-',ExcelFileName,'-To Spreadsheet');
disp(dispstr);
fprintf(fid,'%\n');
fprintf(fid,'%s\n','------ Wrote RIST Section1Results----- To Excel');
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'%\n');
%ExcelFileName=strcat(FileStub,'Section1Table.xlsx');
writetable(Section1BasicStatsTable,ExcelFileName,'Sheet','Section1Stats');
dispstr=strcat('Wrote Section 1 Basic Stats Table-',ExcelFileName,'-To Spreadsheet');
disp(dispstr);
fprintf(fid,'%\n');
fprintf(fid,'%s\n','------ Wrote RIST Section1Stats----- To Excel');
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'%\n');
writetimetable(Section1SATT,ExcelFileName,'Sheet','Section1TopStorms');
dispstr=strcat('Wrote Table-',ExcelFileName,'-To Spreadsheet');
disp(dispstr);
fprintf(fid,'%\n');
fprintf(fid,'%s\n','------ Wrote RIST Section1 Top Storms----- To Excel');
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'%\n');
writetimetable(Section1DurSTT,ExcelFileName,'Sheet','Section1LongStorms');
dispstr=strcat('Wrote Table-',ExcelFileName,'-To Spreadsheet');
disp(dispstr);
fprintf(fid,'%\n');
fprintf(fid,'%s\n','------ Wrote RIST Section1 Long Storms----- To Excel');
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'%\n');
writetimetable(Section3TT,ExcelFileName,'Sheet','Section3Results');
dispstr=strcat('Wrote TimeTableSection3-',ExcelFileName,'-To Spreadsheet');
disp(dispstr);
fprintf(fid,'%\n');
fprintf(fid,'%s\n','------ Wrote RIST Section3 Results----- To Excel');
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'%\n');
writetimetable(Section5TT,ExcelFileName,'Sheet','Section5Results');
dispstr=strcat('Wrote TimeTableSection5-',ExcelFileName,'-To Spreadsheet');
disp(dispstr);
fprintf(fid,'%\n');
fprintf(fid,'%s\n','------ Wrote RIST Section5 Results----- To Excel');
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'%\n');
% Try to Execute Macro From Matlab

if(iRunExcelMacro==1)
    % Create object.
    disp='Starting to Execute Macro to Format Excel File';
    ExcelApp = actxserver('Excel.Application');
    % Show window (optional).
    ExcelApp.Visible = 1;
    % Open file located in the current folder.
    ExcelApp.Workbooks.Open(fullfile(pwd,'\RistTemplate.xlsm'));
    % Run Macro1, defined in "ThisWorkBook" with one parameter. A return value cannot be retrieved.
    ExcelApp.Run('FormatRistTable1');
    ExcelApp.Run('RistStatsTable2');
    % % Run Macro2, defined in "Sheet1" with two parameters. A return value cannot be retrieved.
    % ExcelApp.Run('Sheet1.Macro2', parameter1, parameter2);
    % % Run Macro3, defined in the module "Module1" with no parameters and a return value.
    % retVal = ExcelApp.Run('Macro3');
    % Quit application and release object.
    ExcelApp.Quit;
    ExcelApp.release;
    disp('Finished Formatting Excel Output Using Macros');
end
% Rename the ExcelFile
%copyfile RistTemplate.xlsm myfile2.m
% if(iRunExcelMacro==1)
%     ExcelFileName='RistTemplate.xlsm';
% else
%     ExcelFileName=strcat(FileStub,'Section3Table.xlsm');
% end
% writetimetable(Section3TT,ExcelFileName,'Sheet','Section3Results');
% dispstr=strcat('Wrote TimeTableSection3-',ExcelFileName,'-To Spreadsheet');
% disp(dispstr);
% fprintf(fid,'%\n');
% fprintf(fid,'%s\n','------ Wrote RIST Section3 Results----- To Excel');
% fprintf(fid,'%s\n',dispstr);
% fprintf(fid,'%\n');
% Save this table as a standalone MatFile
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='Section3Table Section3TT Section5Table Section5TT';
MatFileName=strcat(FileStub,'Section3_5Tables.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created Section3TT-','Contains Rain Fall BiMonthly Stats');
fprintf(fid,'%\n');
fprintf(fid,'%s\n',silstr);
fprintf(fid,'%\n');
% Now make plots from this table% Now make plots from this table
% Star with the Bi Monthly Precip
titlestr1=strcat(FileStub,'TotalStormPrecip-15Days');
titlestr=RemoveUnderScores(titlestr1);
ikind=1;
PlotRistSection3Table(titlestr,ikind)
titlestr1=strcat(FileStub,'StormEnergy-15Days');
ikind=2;
titlestr=RemoveUnderScores(titlestr1);
PlotRistSection3Table(titlestr,ikind)

% Closeout Activities
elapsed_time=toc;
dispstr=strcat('Run Complete with an elapsed time of-',num2str(elapsed_time),'-seconds');
disp(dispstr);
fprintf(fid,'\n');
fprintf(fid,'%s\n',dispstr);
fclose(fid);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
if(iRunExcelMacro==1)
    winopen('RistTemplate.xlsm');
end
ab=1;
