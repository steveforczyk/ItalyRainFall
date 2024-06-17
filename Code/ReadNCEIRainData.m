% Read NCI CSV Files
% Contains 15 Min Precip Data for a single COOP Station

% Written By: Stephen Forczyk/Joydeb Saha
% Created:June 14,2024
% Revised: 
%
% Classification: Unclassified/Public Domain


global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable COOPActiveStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile StateBoundaryData;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0 selectedState;
global StateFIPSFile USCountiesShapeFile SC nactiveStations;
global iDTEDMap DTEDFileName Alabama AlabamaRB;
global StationName StationLat StationLon StationElev Element StationDlySum;
global StationDlySumMF StationDlySumQF StationDlySumS1 StationDlySumS2;
global YearN MonthN DayN HoursN MinutesN SecN YearRec MonthRec DayRec RecordTimes;
global RainFallTable RainFallTT RainFallTimes RainVals SourceFlag1 SourceFlag2;
global RecordTable RecordTT;
global HPDStationFile numCOOPStations StationMetaData;
global StnID LatStn LonStn ElvStn StateStn NameStn WMO_ID Sample_Interval UTC_Offset;
global POR_Date_Range PCT_POR_Good Last_Half_POR PCT_Last_Half_Good;
global Last_QTR_POR PCT_Last_Qtr_Good HPDStationTable;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath matlabdata cooppath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath statedtedpath specialcountiespath;
global fid fid2;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global iMethod iCalif;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig iExcel iRunExcelMacro;
global iCreateMap;



%% Paths
datapath='K:\Joydeb\Alabama_Precip\';
matlabpath='K:\Joydeb\NCEI_Data\Mat_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='D:\Joydeb\LogFiles\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
matlabdata='K:\Joydeb\Matlab_Data\';
tablepath='K:\Joydeb\NCEI_Data\Tables\';
jpegpath='K:\Joydeb\Jpeg_Files\';
jpegpath='D:\Joydeb\Jpeg_COOP\';
govjpegpath='D:\Joydeb\gov_jpeg\';
dailyfilepath='D:\Joydeb\Daily_Files\';
rainfalldatapath='K:\Joydeb\RainFall_Files\';
csvfilepath='K:\Joydeb\CSV_Files\';
excelpath='K:\Joydeb\Excel_Files\';
countyshapepath='D:\Forczyk\Map_Data\MAT_Files_Geographic\';
USshapefilepath='D:\Forczyk\Map_Data\USStateShapeFiles\';
CountyBoundaryFile='CountyBoundingBoxes';
stateboundarypath='D:\Forczyk\Map_Data\USStateBoundaryFinalFiles\';
statedtedpath='D:\Forczyk\Map_Data\State_DTED_Files\';
specialcountiespath='D:\Forczyk\Map_Data\Special_County_ShapeFiles\';
cooppath='K:\Joydeb\NCEI_Data\COOP_Data\';
%% Default Values
COOPFileName='Alabama_COOP_Stations.txt';
HPDStationFile='HPD_StationInventory.mat';

% Flag values
idecode=0;
iMovie=1;
iCreateMap=1;
iExcel=1;
iCalif=0;
iRunExcelMacro=0;
iFastSave=1;
iLogo=1;
iMethod=2;
iDTEDMap=0;
DTEDFileName='UnifiedAlabamaDTED.mat';
LogoFileName1='UPadua_Logo3.jpg';
isumhourlyfiles=1;
iCheckConfig=0;
nsortlim=25;
sf1=.039370;
min5peryear=365*24*12;
FoundData=zeros(60,3);
USAStatesFileName='USAStatesShapeFileMapListRev4.mat';
CountyBoundaryFile='CountyBoundingBoxes';
AllStateBoundaries='All_USCounties_BoundaryData.mat';
StateFIPSFile='StateFIPCodeDataRev1.mat';
USCountiesShapeFile='tl_2023_us_county.shp';
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Reading NCEI Rain File at-',startruntime);
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
logfilename=strcat('COOPCSVFileInport-',logfilename,'.txt');
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
SetUpExtraColors();
almond=[LandColors(1,1) LandColors(1,2) LandColors(1,3)];
beige=[LandColors(3,1) LandColors(3,2) LandColors(3,3)];
wheat=[LandColors(5,1) LandColors(5,2) LandColors(5,3)];
butterscotch=[LandColors(8,1) LandColors(8,2) LandColors(8,3)];

%% Select a single file csv text file
eval(['cd ' cooppath(1:length(cooppath)-1)]);
[COOPOutputFile,nowpath] = uigetfile('*.csv','Select One Station List File', ...
'MultiSelect', 'off');
tic;
readfilestr=strcat('Selected File-',COOPOutputFile,'-For Reading');
fprintf(fid,'%s\n',readfilestr);
%% Now import it
eval(['cd ' nowpath(1:length(nowpath)-1)]);
delimiter = ',';
opts = delimitedTextImportOptions('Delimiter',delimiter);
data = readmatrix(COOPOutputFile,opts);
[nrows,ncols]=size(data);
datastr=strcat('File Had-',num2str(nrows-1),'-Records on it');
fprintf(fid,'%s\n',datastr);
nowHour=0;
nowMin=0;
ihrs=0;
imins=0;
nvals=96*(nrows-1);
HoursN=zeros(nvals,1);
MinutesN=zeros(nvals,1);
SecN=zeros(nvals,1);
RainVals=zeros(nvals,1);
SourceFlag1=zeros(nvals,1);
SourceFlag2=zeros(nvals,1);
YearRec=zeros(nrows-1,1);
MonthRec=zeros(nrows-1,1);
DayRec=zeros(nrows-1,1);
StationDlySum=zeros(nrows-1,1);
StationDlySumQF=zeros(nrows-1,1);
for kk=1:nvals
    HoursN(kk,1)=nowHour;
    imins=mod(kk,4);
    if(imins==1)
        imin=0;
    elseif(imins==2)
        imin=15;
    elseif(imins==3)
        imin=30;
    elseif(imins==0)
        imin=45;
        nowHour=nowHour+1;
    end
    MinutesN(kk,1)=imin;
    ab=1;
end
ik=0;
waitstr='Importing Data From NCEI CSV File';
hfs=waitbar(0,waitstr);
for n=2:nrows
    waitbar(n/nrows);
    if(n==2)
        StationName=data{n,1};
        StationLat=data{n,2};
        StationLon=data{n,3};
        StationElev=data{n,4};
    end
    RowDate=data{n,5};
    Element=data{n,6};
    StationDlySum(n-1,1)=str2double(data{n,487});
    % StationDlySumMF(n,1)=data{n,488};
    qfsumstr=char(data{n,489});
    a1=isempty(qfsumstr);
    if(a1==1)
       StationDlySumQF(n-1,1)=96;
    else
       StationDlySumQF(n-1,1)=1;
    end
    % StationDlySumS1(n,1)=data{n,490};
    % StationDlySumS2(n,1)=data{n,491};
    if(ik<5)% Get the times for each data point
        YearN(1,1)=str2double(RowDate(1:4));
        MonthN(1,1)=str2double(RowDate(6:7));
        DayN(1,1)=str2double(RowDate(9:10));
    end
    % Get the start time of each record
    YearRec(n-1,1)=str2double(RowDate(1:4));
    MonthRec(n-1,1)=str2double(RowDate(6:7));
    DayRec(n-1,1)=str2double(RowDate(9:10));
    for k=7:5:482
        ik=ik+1;
        val=str2double(data{n,k});
        if(val<-9998)
            val=NaN;
        end
        RainVals(ik,1)=val;
        str1=char(data{n,k+3});
        str2=char(data{n,k+4});
        a11=strcmpi(str1,'4');
        a12=strcmpi(str1,'6');
        a13=strcmpi(str1,'H');
        if(a11==1)
            SourceFlag1(ik,1)=4;
        elseif(a12==1)
            SourceFlag1(ik,1)=6;
        elseif(a13==1)
            SourceFlag1(ik,1)=2;
        else
            SourceFlag1(ik,1)=0;
        end
        a21=strcmpi(str2,'4');
        a22=strcmpi(str2,'6');
        a23=strcmpi(str2,'H');
        if(a21==1)
            SourceFlag2(ik,1)=4;
        elseif(a22==1)
            SourceFlag2(ik,1)=6;
        elseif(a23==1)
            SourceFlag2(ik,1)=2;
        else
            SourceFlag2(ik,1)=0;
        end
        if(ik>=2)
            YearN(ik,1)=YearN(1,1);
            MonthN(ik,1)=MonthN(1,1);
            DayN(ik,1)=DayN(1,1);
        end
    end

end
close(hfs);
RainFallTimes = datetime(YearN,MonthN,DayN,HoursN,MinutesN,SecN);
RecordTimes=datetime(YearRec,MonthRec,DayRec);
dispstr='Now Creating RainFallTable';
disp(dispstr);
% Create a Table of This data which has 96 measurements per record
RainFallTable=table(RainVals(:,1),SourceFlag1(:,1),SourceFlag2(:,1),RainFallTimes,...
    'VariableNames',{'RainTot-in/100','SourceFlag1','SourceFlag2','RainFallTimes'});
RainFallTT = table2timetable(RainFallTable,'RowTimes','RainFallTimes');
dispstr='Finished Creating RainFallTable';
disp(dispstr);
fprintf(fid,'%s\n','Created RainFallTable');
%% Now pull the station metadata from the HPDStationFile
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load('HPD_StationInventory.mat');
numCOOPStations=length(StnID);
dispstr=strcat('Successfully read HPD Station Inventory File-HPD_StationInventory.mat','-which has-',...
    num2str(numCOOPStations),'-Stations');
disp(dispstr)
fprintf(fid,'%s\n',dispstr);
imatch=1;
for j=1:numCOOPStations
    nowStation=StnID{j,1};
    tf=contains(StationName,nowStation);
    if(tf==1)
        imatch=j;
    end
end
ab=2;
StationMetaData.ID=StationName;
StationMetaData.Lat=LatStn(imatch,1);
StationMetaData.Lon=LonStn(imatch,1);
StationMetaData.NameStn=NameStn{imatch,1};
StationMetaData.StateStn=StateStn{imatch,1};
StationMetaData.SampleRate=Sample_Interval{imatch,1};
StationMetaData.PORDateRange=POR_Date_Range{imatch,1};
StationMetaData.PCTPORGOOD=PCT_POR_Good(imatch,1);
StationMetaData.LastHalfPOR=Last_Half_POR{imatch,1};
StationMetaData.PCT_Last_Half_Good=PCT_Last_Half_Good(imatch,1);
StationMetaData.LastQTRPOR=Last_QTR_POR{imatch,1};
StationMetaData.PCT_Last_Qtr_Good=PCT_Last_Qtr_Good(imatch,1);
%% Create a separate Table that has the record level values
RecordTable=table(StationDlySum(:,1),StationDlySumQF(:,1),RecordTimes,...
    'VariableNames',{'DailySum-in/100','DlySumQF','RecordTimes'});
RecordTT = table2timetable(RecordTable,'RowTimes','RecordTimes');
dispstr='Finished Creating RecordTable';
disp(dispstr);
fprintf(fid,'%s\n','Created RecordTable');
ab=2;
%% Save this Table
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RainFallTable RainFallTT RainFallTimes RainVals';
varstr2=' SourceFlag1 SourceFlag2 COOPOutputFile nowpath';
varstr3=' RecordTable RecordTT StationDlySum StationDlySumQF RecordTimes';
varstr=strcat(varstr1,varstr2,varstr3);
MatFileName=strcat('Station-',StationName,'-RainFallTable','.mat');
dispstr=strcat('Now Saving Table-',MatFileName,'-which contains two tables');
disp(dispstr);
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved Output Tables to File-',MatFileName);
fprintf(fid,'%s\n',dispstr);
disp(dispstr);
% End Of Run Closelout
elapsed_time=toc;
estr=strcat('Run Took-',num2str(elapsed_time),'-to complete');
disp(estr)
fprintf(fid,'%s\n',estr);
fclose(fid);
ab=2;