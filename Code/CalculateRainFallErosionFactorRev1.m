% This script will calculation the R factor for the Rusle Equation
% The Rev 1 version was created for the purpose of defining the time
% periods when the rainfall is sufficient to be called a storm
% Written By Stephen Forczyk and Dr Joydeb Saha
% Created: May 7,2024
% Revised: May 9,2024 added Excel File Creation and an Excelfolder
% Source:Rainfall erosivity in Italy: a national scale spatio-
% temporal assessment https://doi.org/10.1080/17538947.2016.1148203

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
excelpath='K:\Joydeb\Excel_Files\';
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
iStorms=1;% Calculate Storms
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
logfilename=strcat('ErosionFactor-',logfilename,'.txt');
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
ab=2;
% If the file is cataloged-skip the next step
% Now scan the data to find what years are available and the start and end
% indices for each year
if(icataloged~=1)
    numend=length(RainFallAmt);
    oldYear=1940;
    ind=0;
    for i=1:numend-1
        teststr=(RainFallTime(i));
        teststr2=(RainFallTime(i+1));
        nowstr=char(teststr);
        nowstrlen=length(teststr);
        idash=strfind(nowstr,'-');
        numdash=length(idash);
        is=idash(2)+1;
        ie=is+3;
        nowyearstr=nowstr(is:ie);
        nowYear=str2double(nowstr(is:ie));
        nowstr2=char(teststr2);
        nowstrlen2=length(teststr2);
        idash=strfind(nowstr2,'-');
        numdash=length(idash);
        is=idash(2)+1;
        ie=is+3;
        nextyearstr=nowstr2(is:ie);
        nextYear=str2double(nowstr2(is:ie));
        if(nowYear>oldYear)
            ind=ind+1;
            FoundData(ind,1)=nowYear;
            FoundData(ind,2)=i;
            istart=i;
            oldYear=nowYear;
            dispstr=strcat('Found start of data for Year-',num2str(nowYear));
            disp(dispstr);
        elseif(nextYear>nowYear)
            FoundData(ind,3)=i;
            iend=i;
            numptsfound=iend-istart+1;
            ab=1;
            dispstr=strcat('Found end of data for Year-',num2str(nowYear),'-which had-',num2str(numptsfound),'-timeslices');
            disp(dispstr);
        end
    
    end
    % Clip off and blank years
    TempFoundData=FoundData;
    [nrows,ncols]=size(FoundData);
    igood=0;
    for i=1:nrows
        nowYear=TempFoundData(i,1);
        if(nowYear>0)
            igood=igood+1;
        end
    end
    FoundData=zeros(igood,3);
    for i=1:igood
        for j=1:3
            FoundData(i,j)=TempFoundData(i,j);
        end
    end
%% Now define time regions that can be called storms
%      [ibig]=find(RainFallAmt>0);
%      numbig=length(ibig);
    
    %% Now create a cataloged file which has all the original data on it plus the Found Data array
    eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
    actionstr='save';
    varstr1='S FoundData';
    MatFileName=RainFallCatalogedFile;
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Created a Catalog file-',MatFileName);
    disp(dispstr);
    fprintf(fid,'%30s\n',dispstr);
else
    dispstr=strcat('File-',RainFallFile,'-was already cataloged');
    disp(dispstr);
    fprintf(fid,'%30s\n',dispstr);
end
% Show the years that data is available for
fprintf(fid,'%s\n','List Of Years that have available data');
fprintf(fid,'%s\n','Entry Number  Year'); 
[nrows,ncols]=size(FoundData);
for kk=1:nrows
    fprintf(fid,'%d    %20d\n',kk,FoundData(kk,1));
end
fprintf(fid,'%s\n','End Of Years that have available data');
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
[nrows,ncols]=size(FoundData);
firstAvailYear=FoundData(1,1);
lastAvailYear=FoundData(nrows,1);
ListYears=cell(nrows,1);
for i=1:nrows
    ListYears{i,1}=num2str(FoundData(i,1));
end
%% Select Years to be used
[indx,tf] = listdlg('PromptString',{'Start and End Years'},...
'SelectionMode','multiple','ListString',ListYears,'ListSize',[360,300]);
a1=isempty(indx);
if(a1==1)
    igo=0;
else
    igo=1;
    numYears=length(indx);
    SelectedYears=zeros(numYears,1);
    indx=indx';
    for ik=1:numYears
        nowInd=indx(ik,1);
        selstr=char(ListYears{nowInd});
        SelectedYears(ik,1)=str2double(selstr);
        if(ik==1)
            SelStartIndex=FoundData(nowInd,2);
        elseif(ik==numYears)
            SelEndIndex=FoundData(nowInd,3);
        end
    end
end
% Show the years that data is available for
fprintf(fid,'%s\n','User Selected to Process The Following Years');
fprintf(fid,'%s\n','Entry Number              Year'); 
for kk=1:numYears
    fprintf(fid,'%d    %25d\n',kk,SelectedYears(kk,1));
end
fprintf(fid,'%s\n','End Of List Of Selected Years')';
%% Now define time regions that can be called storms
if(iStorms>0)
    [ibig]=find(RainFallAmt>0);
    numbig=length(ibig);
    PotentialStorms=cell(numbig,16);
    PotentialStorms{1,1}='DateTime';
    PotentialStorms{1,2}='Sample';
    PotentialStorms{1,3}='RainFallRate-mm/hr';
    PotentialStorms{1,4}='OccurInRow';
    PotentialStorms{1,5}='Sum5Min';
    PotentialStorms{1,6}='Sum10Min';
    PotentialStorms{1,7}='Sum15Min';
    PotentialStorms{1,8}='Sum30Min';
    PotentialStorms{1,9}='Sum60Min';
    PotentialStorms{1,10}='Sum360Min';
    PotentialStorms{1,11}='Max5Min';
    PotentialStorms{1,12}='Max10Min';
    PotentialStorms{1,13}='Max15Min';
    PotentialStorms{1,14}='Max30Min';
    PotentialStorms{1,15}='Max60Min';
    PotentialStorms{1,16}='Max360Min';
    ictr=0;
    waitstr='Making an initial pass through the Rain Data';
    hfs=waitbar(0,waitstr);
    DetectTime=RainFallTime(ibig);
    for i=1:numbig% Loop over all exceedences
        ibignow=ibig(i);
        waitbar(i/numbig);
        if(ibignow>=(numtimesstep-12))% skip the exceedence is this is near the end of the data
    
        else
            ictr=ictr+1;
            teststr=char(RainFallTime(ibignow));
            DetectTimeInd(ictr,1)=ibignow;
            PotentialStorms{1+ictr,1}=teststr;
            PotentialStorms{1+ictr,2}=ibignow;
            PotentialStorms{1+ictr,3}=RainFallAmt(ibignow);
            inRow=1;
            sumRain=RainFallAmt(ibignow);
            PotentialStorms{1+ictr,5}=sumRain;
            PotentialStorms{1+ictr,11}=sumRain;
            ictr2=1;
            if(ictr2==1)
                HoldArray=zeros(72,1);
                HoldArray(1,1)=sumRain;
            end
            for kk=ibignow+1:1:ibignow+71 % Get rain fall sum
                ictr2=ictr2+1;
                sumRain=sumRain+RainFallAmt(kk);
                HoldArray(ictr2,1)=RainFallAmt(kk);
                maxRain=max(HoldArray);
                if(ictr2==2)
                    PotentialStorms{1+ictr,6}=sumRain;
                    PotentialStorms{1+ictr,12}=maxRain;
                end
                if(ictr2==3)
                    PotentialStorms{1+ictr,7}=sumRain;
                    PotentialStorms{1+ictr,13}=maxRain;
                end
                if(ictr2==6)
                    PotentialStorms{1+ictr,8}=sumRain;
                    PotentialStorms{1+ictr,14}=maxRain;
                end
                if(ictr2==12)
                    PotentialStorms{1+ictr,9}=sumRain;
                    PotentialStorms{1+ictr,15}=maxRain;
                end
                if(ictr2==72)
                    PotentialStorms{1+ictr,10}=sumRain;
                    PotentialStorms{1+ictr,16}=maxRain;
                end
            end
            for kk=ibignow+1:1:ibignow+71
                if(RainFallAmt(kk)>0)
                    inRow=inRow+1;
                    if(inRow>20)
                        ab=3;
                    end
                else
                    break
                end
    
            end
            PotentialStorms{1+ictr,4}=inRow;
        end
        ab=1;
    end
    close(hfs);
end
ab=1;
%% Main Program Loop
if(igo==1)% Start processing this data
    waitstr='Resampling 5 min data to 30 minutes';
    hfs=waitbar(0,waitstr);
% Start by creating 30 minute files
    numused=SelEndIndex-SelStartIndex+1;
    numused30=ceil(numused/6);
    I30=zeros(numused30,1);
    SumRain30=zeros(numused30,1);
    I30max=zeros(numused30,1);
    SUMKE30=zeros(numused30,1);
    ER30=zeros(numused30,1);
    ictr=0;
    for i=SelStartIndex:6:SelEndIndex
        [EI30x,SumKE,ER,VR,maxI30,sumRainFallAmt,teststr1]=Asemble30MinFiles(i);
        ictr=ictr+1;
        I30(ictr,1)=sumRainFallAmt;
        SUMKE30(ictr,1)=SumKE;
        I30max(ictr,1)=maxI30*60/30;
        ER30(ictr,1)=ER;
        SumRain30(ictr,1)=sumRainFallAmt;
        waitbar(ictr/numused30);
    end
    close(hfs);
end
yd=SelectedYears(1);
md=1;
dd=1;
stime=datetime(yd,md,dd);
timestep=minutes(30);
fprintf(fid,'%s\n','Rain Counter values');
statestr=strcat('Rain Detected In-',num2str(eventctr),'-30 Minute Intervals');
fprintf(fid,'%s\n',statestr);
statestr='No Rain Detected';
statestr=strcat('No Rain Detected In-',num2str(norainctr),'-30 Minute Intervals');
fprintf(fid,'%s\n',statestr);
fprintf(fid,'%s\n','End Rain Counter Details');
%% Create the The R Factor Table
RFactorTable=table(I30(:,1),I30max(:,1),SUMKE30(:,1),ER30(:,1),...
    'VariableNames',{'Int30','I30max','SUMKE30','ER30'});
RFactorTT = table2timetable(RFactorTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RFactorTable RFactorTT';
MatFileName=strcat('RFactorTable',num2str(yd),'-30min','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
%% Create a diagnostic table
RainRate=I30;
KEnergy=SUMKE30.*SumRain30;
DiagTable=table(RainRate(:,1),SumRain30(:,1),I30max(:,1),SUMKE30(:,1),KEnergy(:,1),...
    'VariableNames',{'RainRate-mm/hr','RainAccumil-mm','I30max','SUMKE30','KEnergy-MJ/ha'});
DiagTT = table2timetable(DiagTable,'TimeStep',timestep,'StartTime',stime);
% Now write this as a table that can be imported by Excel
eval(['cd ' excelpath(1:length(excelpath)-1)]);
ExcelFileName=strcat('DiagnosticTable',num2str(yd),'-30min','.xlsx');
writetimetable(DiagTT,ExcelFileName);
disp('Wrote Excel File');
%% Now plot this data-start with the I30 value for a 30 min slice
ikind=1;
titlestr=strcat('RainFall30MinRate-','Station-Number-',num2str(StationNum),'-StartYear-',num2str(yd));
PlotSingleStationRainFallTable(titlestr,ikind)
% Continue with the max rainfall rate in a 30 min slice
ikind=2;
titlestr=strcat('RainFall30MinMaxRate-','Station-Number-',num2str(StationNum),'-StartYear-',num2str(yd));
PlotSingleStationRainFallTable(titlestr,ikind)
% Continue with the max rainfall rate in a 30 min slice
ikind=3;
titlestr=strcat('RainKineticEnery30Min-','Station-Number-',num2str(StationNum),'-StartYear-',num2str(yd));
PlotSingleStationRainFallTable(titlestr,ikind)
%% close out activities
endruntime=deblank(datestr(now));
endrunstr=strcat('End CalculateRainFallErosion Factor at-',startruntime);
fprintf(fid,'%50s\n',endrunstr);
fclose(fid);
ab=3;