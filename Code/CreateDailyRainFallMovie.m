% This script will read Daily Rain Fall Accumilations and make a movie of
% them

% Written By: Stephen Forczyk
% Created: April 6,2024
% Revised: April 15,2024 added code to change hourly rain tables
% Revised: April 16,2024 allow to the user to sum up 24 hourly files
% to create a daily file. Save these files to allow for some daily
% processing
% to daily tables
% Revised:April 22,2024 Created Variables for RainFall Accumilation and Totals
% Revised: added tables for Province sets 2 3 and 4.
% For Italy and the 20 separate provinces
% Classification: Unclassified/Public Domain
global ItalyRainFallFile;
global ItalyPrecipLats ItalyPrecipLons ItalyPrecipTimes ItalyRasterAreas;
global ItalyLats ItalyLons FranceLat FranceLon AustriaLat AustriaLon;
global SwitzerLandLat SwitzerLandLon SerbiaLat SerbiaLon CroatiaLat CroatiaLon;
global AlbaniaLat AlbaniaLon GreeceLat GreeceLon BosniaLat BoosniaLon;
global SloveniaLat SloveniaLon MontenegroLat MontenegroLon;

global ItalyTotPrecip ItalySliceTimes RainFallFiles;
global ItalyRasterDataFile;
global StatValues framecounter;
global numRainFallFiles RainFallConstantsFile nowFile;
global idecode iCityPlot iprecomputed iCreateMasks;
global westEdge eastEdge northEdge southEdge Rpix;
global ItalyCityLats ItalyCityLons ItalyCityName;
global AbruzzoProvinceLat AbruzzoProvinceLon;
global ApuliaProvinceLat ApuliaProvinceLon BasilicataProvinceLat BasilicataProvinceLon;
global CalabriaProvinceLat CalabriaProvinceLon CampaniaProvinceLat CampaniaProvinceLon ;
global EmiliaProvinceLat EmiliaProvinceLon FriuliProvinceLat FriuliProvinceLon;
global LazioProvinceLat LazioProvinceLon LiguriaProvinceLat LiguriaProvinceLon;
global LombardiaProvinceLat LombardiaProvinceLon MarcheProvinceLat MarcheProvinceLon;
global MoliseProvinceLat MoliseProvinceLon PiemonteProvinceLat PiemonteProvinceLon;
global SardegnaProvinceLat SardegnaProvinceLon SicilyProvinceLat SicilyProvinceLon;
global ToscanaProvinceLat ToscanaProvinceLon TrentinoProvinceLat TrentinoProvinceLon;
global UmbriaProvinceLat UmbriaProvinceLon VallaProvinceLat VallaProvinceLon;
global VenetoProvinceLat VenetoProvinceLon;

global ERA5ItalyMask ERA5VenetoProvinceMask ERA5AbruzzoProvinceMask ERA5ApuliaProvinceMask;
global ERA5BasilicataProvinceMask ERA5CalabriaProvinceMask ERA5CampaniaProvinceMask;
global ERA5EmiliaProvinceMask ERA5FriuliProvinceMask ERA5LazioProvinceMask ERA5LiguriaProvinceMask;
global ERA5LombardiaProvinceMask ERA5MarcheProvinceMask ERA5MoliseProvinceMask ERA5PiemonteProvinceMask;
global ERA5SardegnaProvinceMask ERA5SicilyProvinceMask ERA5ToscanaProvinceMask ERA5TrentinoProvinceMask;
global ERA5UmbriaProvinceMask ERA5VallaProvinceMask MaskPoints;
global RainFallProv1Table RainFallProv1TT RainFallProv2Table RainFallProv2TT;
global RainFallProv3Table RainFallProv3TT RainFallProv4Table RainFallProv4TT;
global DailyRainFallProv1Table DailyRainFallProv1TT;
global DailyRainFallProv2Table DailyRainFallProv2TT;
global DailyRainFallProv3Table DailyRainFallProv3TT;
global DailyRainFallProv4Table DailyRainFallProv4TT;
global DailyPrecip DateTimeHold;
global DailyRainFallFiles;
global DailyRainFallTotalProv1Table DailyRainFallTotalProv1TT;
global DailyRainFallTotalProv2Table DailyRainFallTotalProv2TT;
global DailyRainFallTotalProv3Table DailyRainFallTotalProv3TT;
global DailyRainFallTotalProv4Table DailyRainFallTotalProv4TT;
global DailyRainFallAllProvTable DailyRainFallAllProvTT;
global ProvinceRainFallTotals ProvinceNames RankByDate RankOverData;
global ProvinceRainFallRankedData;


global TotPrecipItaly TotPrecipAbruzzo TotPrecipApulia TotPrecipBasilicata;
global TotPrecipCalabria TotPrecipCampania TotPrecipEmilia TotPrecipFriuli;
global TotPrecipLazio TotPrecipLiguria TotPrecipLombardia TotPrecipMarche;
global TotPrecipMolise TotPrecipPiemonte TotPrecipSardegna TotPrecipSicily;
global TotPrecipToscana TotPrecipTrentino TotPrecipUmbria TotPrecipValla TotPrecipVeneto;
global TotAccumilItaly TotAccumilAbruzzo TotAccumilApulia TotAccumilBasilicata;
global TotAccumilCalabria TotAccumilCampania TotAccumilEmilia TotAccumilFriuli;
global TotAccumilLiguria TotAccumilLazio TotAccumilLombardia;
global TotAccumilMarche TotAccumilMolise TotAccumilPiemonte TotAccumilSardegna;
global TotAccumilSicily TotAccumilToscana TotAccumilTrentino TotAccumilUmbria;
global TotAccumilValla TotAccumilVeneto;
global rainAccItaly rainAccAbruzzo rainAccApulia  rainAccBasilicata ;
global rainAccCalabria rainAccCampania rainAccEmilia rainAccFriuli;
global rainAccLazio rainAccLiguria rainAccLombardia rainAccMarche;
global rainAccMolise rainAccPiemonte rainAccSardegna rainAccSicily;
global rainAccToscana rainAccTrentino rainAccUmbria rainAccValla rainAccVeneto;
global numItalyMask numAbruzzoProvMask numApuliaProvMask numBasilicataProvMask;
global numCalabriaProvMask numCampaniaProvMask numEmiliaProvMask;
global numFriuliProvMask numLazioProvMask numLiguriaProvMask numLombardiaProvMask;
global numMarcheProvMask numMoliseProvMask numPiemonteProvMask numSardegnaProvMask;
global numSicilyProvMask numToscanaProvMask numTrentinoProvMask numUmbriaProvMask;
global numVallaProvMask numVenetoProvMask;
global rainTotItaly rainTotAbruzzo rainTotApulia  rainTotBasilicata;
global rainTotCalabria rainTotCampania rainTotEmilia rainTotFriuli;
global rainTotLazio rainTotLiguria rainTotLombardia rainTotMarche;
global rainTotMolise rainTotPiemonte rainTotSardegna rainTotSicily;
global rainTotToscana rainTotTrentino rainTotUmbria rainTotValla;
global rainTotVeneto;
global TdmyhrminsecStart;
global startindex endindex;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch


global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath;
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
global iLogo LogoFileName1;
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
%% Default Values
ItalyRainFallFile='CMCC_italy-hist-1981-1.nc';
ItalyRasterDataFile='ItalyERA5RasterData.mat';
% Store The Map Boundaries
westEdge=0;
eastEdge=22;
northEdge=50;
southEdge=35.;
idecode=0;
framecounter=0;
iMovie=1;
iCityPlot=1;
RainFallConstantsFile='ItalyRainFallConstants.mat';
StatValues=zeros(13,1);
deg2rad=pi/180;
iprecomputed=0;
iCreateMasks=0;
iFastSave=1;
iLogo=1;
LogoFileName1='Copernicus_Logo.jpg';
isumhourlyfiles=1;
sf1=.039370;
% Set Cells
MaskPoints=cell(22,2);
MaskPoints{1,1}='MaskName';
MaskPoints{1,2}='Number of Values';
MaskPoints{1,3}='Mask Area km^2';
% Set up the cell array for the Province RainFall Totals in weight inches
% over the selected study time period
ProvinceRainFallTotals=cell(20,1);
for kk=1:20
    ProvinceRainFallTotals{kk,1}=0;
end

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
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Create DailyRainFallMovie Run at-',startruntime);
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
logfilename=strcat('DailyRainFallAmount-',logfilename,'.txt');
fid=fopen(logfilename,'w');
dispstr=strcat('Opened Log file-',logfilename,'-for writing');
disp(dispstr);
fprintf(fid,'%50s\n',startrunstr);
% Read in the desired files
eval(['cd ' dailyfilepath(1:length(dailyfilepath)-1)]);
% Now select files to read
tic;
[DailyRainFallFiles,nowpath] = uigetfile('*.mat','Select Multiple Files', ...
'MultiSelect', 'on');
DailyRainFallFiles=DailyRainFallFiles';
numRainFallFiles=length(DailyRainFallFiles);
[NewFileList] = SortDailyFilesInTimeOrder(DailyRainFallFiles);
DailyRainFallFiles=NewFileList;
%% Print a list of files to be processed
fprintf(fid,'\n');
fprintf(fid,'%s\n','----- List of Files to Be processed-----');
for nn=1:numRainFallFiles
    nowFile=char(DailyRainFallFiles{n,1});
    filestr=strcat('File Num-',num2str(nn),'--',nowFile);       
    fprintf(fid,'%s\n',filestr);
end       
fprintf(fid,'%s\n','----- End List of Files to Be processed-----');
%% Start a movieFile
if(iMovie==1)
    eval(['cd ' moviepath(1:length(moviepath)-1)]);
    TempMovieName=strcat('ItalyDailyRainFallTotalsRev7-',num2str(numRainFallFiles));
    vTemp = VideoWriter(TempMovieName,'MPEG-4');
    vTemp.Quality=100;
    vTemp.FrameRate=3;
    open(vTemp);
end
%% Create Georeference object Rpix
latlim=[36.3355 49.6124];
lonlim=[2.9719 20.3513];
numlon=652;
numlat=570;
rasterSize=[numlat numlon];
Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','south','RowsStartFrom','west');
westEdge=2.9719;
eastEdge=20.3513;
southEdge=36.3355;
northEdge=49.6124;
% Load in some needed files just 1 time
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
load('ItalyERA5RasterData.mat');
load('ItalyRainFallConstants.mat');
eval(['cd ' maskpath(1:length(maskpath)-1)]);
load('ItalyMasks.mat');
framecounter=0;
%% initialize arrays to hold data
TotAccumilItaly=zeros(numRainFallFiles,10);
TotPrecipItaly=zeros(numRainFallFiles,1);
TotAccumilAbruzzo=zeros(numRainFallFiles,10);
TotPrecipAbruzzo=zeros(numRainFallFiles,1);
TotAccumilApulia=zeros(numRainFallFiles,10);
TotPrecipApulia=zeros(numRainFallFiles,1);
TotAccumilBasilicata=zeros(numRainFallFiles,10);
TotPrecipBasilicata=zeros(numRainFallFiles,1);
TotAccumilCalabria=zeros(numRainFallFiles,10);
TotPrecipCalabria=zeros(numRainFallFiles,1);
TotAccumilCampania=zeros(numRainFallFiles,10);
TotPrecipCampania=zeros(numRainFallFiles,1);
TotAccumilEmilia=zeros(numRainFallFiles,10);
TotPrecipEmilia=zeros(numRainFallFiles,1);
TotAccumilFriuli=zeros(numRainFallFiles,10);
TotPrecipFriuli=zeros(numRainFallFiles,1);
TotAccumilLazio=zeros(numRainFallFiles,10);
TotPrecipLazio=zeros(numRainFallFiles,1);
TotAccumilLiguria=zeros(numRainFallFiles,10);
TotPrecipLiguria=zeros(numRainFallFiles,1);
TotAccumilLombardia=zeros(numRainFallFiles,10);
TotPrecipLombardia=zeros(numRainFallFiles,1);
TotAccumilMarche=zeros(numRainFallFiles,10);
TotPrecipMarche=zeros(numRainFallFiles,1);
TotAccumilMolise=zeros(numRainFallFiles,10);
TotPrecipMolise=zeros(numRainFallFiles,1);
TotAccumilPiemonte=zeros(numRainFallFiles,10);
TotPrecipPiemonte=zeros(numRainFallFiles,1);
TotAccumilSardegna=zeros(numRainFallFiles,10);
TotPrecipSardegna=zeros(numRainFallFiles,1);
TotAccumilSicily=zeros(numRainFallFiles,10);
TotPrecipSicily=zeros(numRainFallFiles,1);
TotAccumilToscana=zeros(numRainFallFiles,10);
TotPrecipToscana=zeros(numRainFallFiles,1);
TotAccumilTrentino=zeros(numRainFallFiles,10);
TotPrecipTrentino=zeros(numRainFallFiles,1);
TotAccumilUmbria=zeros(numRainFallFiles,10);
TotPrecipUmbria=zeros(numRainFallFiles,1);
TotAccumilValla=zeros(numRainFallFiles,10);
TotPrecipValla=zeros(numRainFallFiles,1);
TotAccumilVeneto=zeros(numRainFallFiles,10);
TotPrecipVeneto=zeros(numRainFallFiles,1);
%% Calculate active Mask Points
MaskPoints{2,1}='ERA5ItalyMask';
numItalyMask=sum(sum(ERA5ItalyMask));
MaskPoints{2,2}=numItalyMask;
MaskPoints{2,3}=sum(sum(ERA5ItalyMask.*ItalyRasterAreas));
MaskPoints{3,1}='ERA5AbruzzoProvinceMaskMask';
numAbruzzoProvMask=sum(sum(ERA5AbruzzoProvinceMask));
MaskPoints{3,2}=numAbruzzoProvMask;
MaskPoints{3,3}=sum(sum(ERA5AbruzzoProvinceMask.*ItalyRasterAreas));
MaskPoints{4,1}='ERA5ApuliaProvinceMaskMask';
numApuliaProvMask=sum(sum(ERA5ApuliaProvinceMask));
MaskPoints{4,2}=numApuliaProvMask;
MaskPoints{4,3}=sum(sum(ERA5ApuliaProvinceMask.*ItalyRasterAreas));
MaskPoints{5,1}='ERA5BasilicataProvinceMaskMask';
numBasilicataProvMask=sum(sum(ERA5BasilicataProvinceMask));
MaskPoints{5,2}=numBasilicataProvMask;
MaskPoints{5,3}=sum(sum(ERA5BasilicataProvinceMask.*ItalyRasterAreas));
MaskPoints{6,1}='ERA5CalabriaProvinceMaskMask';
numCalabriaProvMask=sum(sum(ERA5CalabriaProvinceMask));
MaskPoints{6,2}=numCalabriaProvMask;
MaskPoints{6,3}=sum(sum(ERA5CalabriaProvinceMask.*ItalyRasterAreas));
MaskPoints{7,1}='ERA5CampaniaProvinceMaskMask';
numCampaniaProvMask=sum(sum(ERA5CampaniaProvinceMask));
MaskPoints{7,2}=numCampaniaProvMask;
MaskPoints{7,3}=sum(sum(ERA5CampaniaProvinceMask.*ItalyRasterAreas));
MaskPoints{8,1}='ERA5EmiliaProvinceMask';
numEmiliaProvMask=sum(sum(ERA5EmiliaProvinceMask));
MaskPoints{8,2}=numEmiliaProvMask;
MaskPoints{8,3}=sum(sum(ERA5EmiliaProvinceMask.*ItalyRasterAreas));
MaskPoints{9,1}='ERA5FriuliProvinceMask';
numFriuliProvMask=sum(sum(ERA5FriuliProvinceMask));
MaskPoints{9,2}=numFriuliProvMask;
MaskPoints{9,3}=sum(sum(ERA5FriuliProvinceMask.*ItalyRasterAreas));
MaskPoints{10,1}='ERA5LazioProvinceMask';
numLazioProvMask=sum(sum(ERA5LazioProvinceMask));
MaskPoints{10,2}=numLazioProvMask;
MaskPoints{10,3}=sum(sum(ERA5LazioProvinceMask.*ItalyRasterAreas));
MaskPoints{11,1}='ERA5LiguriaProvinceMask';
numLiguriaProvMask=sum(sum(ERA5LiguriaProvinceMask));
MaskPoints{11,2}=numLiguriaProvMask;
MaskPoints{11,3}=sum(sum(ERA5LiguriaProvinceMask.*ItalyRasterAreas));
MaskPoints{12,1}='ERA5LombardiaProvinceMask';
numLombardiaProvMask=sum(sum(ERA5LombardiaProvinceMask));
MaskPoints{12,2}=numLombardiaProvMask;
MaskPoints{12,3}=sum(sum(ERA5LombardiaProvinceMask.*ItalyRasterAreas));
MaskPoints{13,1}='ERA5MarcheProvinceMask';
numMarcheProvMask=sum(sum(ERA5MarcheProvinceMask));
MaskPoints{13,2}=numMarcheProvMask;
MaskPoints{13,3}=sum(sum(ERA5MarcheProvinceMask.*ItalyRasterAreas));
MaskPoints{14,1}='ERA5MoliseProvinceMask';
numMoliseProvMask=sum(sum(ERA5MoliseProvinceMask));
MaskPoints{14,2}=numMoliseProvMask;
MaskPoints{14,3}=sum(sum(ERA5MoliseProvinceMask.*ItalyRasterAreas));
MaskPoints{15,1}='ERA5PiemonteProvinceMask';
numPiemonteProvMask=sum(sum(ERA5PiemonteProvinceMask));
MaskPoints{15,2}=numPiemonteProvMask;
MaskPoints{15,3}=sum(sum(ERA5PiemonteProvinceMask.*ItalyRasterAreas));
MaskPoints{16,1}='ERA5SardegnaProvinceMask';
numSardegnaProvMask=sum(sum(ERA5SardegnaProvinceMask));
MaskPoints{16,2}=numSardegnaProvMask;
MaskPoints{16,3}=sum(sum(ERA5SardegnaProvinceMask.*ItalyRasterAreas));
MaskPoints{17,1}='ERA5SicilyProvinceMask';
numSicilyProvMask=sum(sum(ERA5SicilyProvinceMask));
MaskPoints{17,2}=numSicilyProvMask;
MaskPoints{17,3}=sum(sum(ERA5SicilyProvinceMask.*ItalyRasterAreas));
MaskPoints{18,1}='ERA5ToscanaProvinceMask';
numToscanaProvMask=sum(sum(ERA5ToscanaProvinceMask));
MaskPoints{18,2}=numToscanaProvMask;
MaskPoints{18,3}=sum(sum(ERA5ToscanaProvinceMask.*ItalyRasterAreas));
MaskPoints{19,1}='ERA5TrentinoProvinceMask';
numTrentinoProvMask=sum(sum(ERA5TrentinoProvinceMask));
MaskPoints{19,2}=numTrentinoProvMask;
MaskPoints{19,3}=sum(sum(ERA5TrentinoProvinceMask.*ItalyRasterAreas));
MaskPoints{20,1}='ERA5UmbriaProvinceMask';
numUmbriaProvMask=sum(sum(ERA5UmbriaProvinceMask));
MaskPoints{20,2}=numUmbriaProvMask;
MaskPoints{20,3}=sum(sum(ERA5UmbriaProvinceMask.*ItalyRasterAreas));
MaskPoints{21,1}='ERA5VallaProvinceMask';
numVallaProvMask=sum(sum(ERA5VallaProvinceMask));
MaskPoints{21,2}=numVallaProvMask;
MaskPoints{21,3}=sum(sum(ERA5VallaProvinceMask.*ItalyRasterAreas));
MaskPoints{22,1}='ERA5VenetoProvinceMask';
numVenetoProvMask=sum(sum(ERA5VenetoProvinceMask));
MaskPoints{22,2}=numVenetoProvMask;
MaskPoints{22,3}=sum(sum(ERA5VenetoProvinceMask.*ItalyRasterAreas));
ab=2;
fprintf(fid,'%s\n','------- Mask Info ------');
for kk=2:22
    maskFile=char(MaskPoints{kk,1});
    numpts=(MaskPoints{kk,2});
    area=MaskPoints{kk,3};
    fprintf(fid,'%s   %8.0f  %8.4e\n',maskFile,numpts,area);    
end
fprintf(fid,'%s\n','------- End Mask Info ------');
%% Main Program Loop
for n=1:numRainFallFiles% Loop over the data
    eval(['cd ' dailyfilepath(1:length(dailyfilepath)-1)]);
    nowFile=DailyRainFallFiles{n,1};
    load(nowFile);
    framecounter=framecounter+1;
    if(n==1)
        TdmyhrminsecStart=DateTimeHold;
    end
% Display One frame of Data
    itype=3;
    lowcutoff=0;
    highcutoff=10;
    rainAccItaly=DailyPrecip.*ERA5ItalyMask;
    rainAccAbruzzo=DailyPrecip.*ERA5AbruzzoProvinceMask;
    rainAccApulia=DailyPrecip.*ERA5ApuliaProvinceMask;
    rainAccBasilicata=DailyPrecip.*ERA5BasilicataProvinceMask;
    rainAccCalabria=DailyPrecip.*ERA5CalabriaProvinceMask;
    rainAccCampania=DailyPrecip.*ERA5CampaniaProvinceMask;
    rainAccEmilia=DailyPrecip.*ERA5EmiliaProvinceMask;
    rainAccFriuli=DailyPrecip.*ERA5FriuliProvinceMask;
    rainAccLazio=DailyPrecip.*ERA5LazioProvinceMask;
    rainAccLiguria=DailyPrecip.*ERA5LiguriaProvinceMask;
    rainAccLombardia=DailyPrecip.*ERA5LombardiaProvinceMask;
    rainAccMarche=DailyPrecip.*ERA5MarcheProvinceMask;
    rainAccMolise=DailyPrecip.*ERA5MoliseProvinceMask;
    rainAccPiemonte=DailyPrecip.*ERA5PiemonteProvinceMask;
    rainAccSardegna=DailyPrecip.*ERA5SardegnaProvinceMask;
    rainAccSicily=DailyPrecip.*ERA5SicilyProvinceMask;
    rainAccToscana=DailyPrecip.*ERA5ToscanaProvinceMask;
    rainAccTrentino=DailyPrecip.*ERA5TrentinoProvinceMask;
    rainAccUmbria=DailyPrecip.*ERA5UmbriaProvinceMask;
    rainAccValla=DailyPrecip.*ERA5VallaProvinceMask;
    rainAccVeneto=DailyPrecip.*ERA5VenetoProvinceMask;
    rainTotItaly=sum(sum(rainAccItaly))/numItalyMask;
    rainTotAbruzzo=sum(sum(rainAccAbruzzo)/numAbruzzoProvMask);
    rainTotApulia=sum(sum(rainAccApulia)/numApuliaProvMask);
    rainTotBasilicata=sum(sum(rainAccBasilicata)/numBasilicataProvMask);
    rainTotCalabria=sum(sum(rainAccCalabria)/numCalabriaProvMask);
    rainTotCampania=sum(sum(rainAccCampania)/numCampaniaProvMask);
    rainTotEmilia=sum(sum(rainAccEmilia)/numEmiliaProvMask);
    rainTotFriuli=sum(sum(rainAccFriuli)/numFriuliProvMask);
    rainTotLazio=sum(sum(rainAccLazio)/numLazioProvMask);
    rainTotLiguria=sum(sum(rainAccLiguria)/numLiguriaProvMask);
    rainTotLombardia=sum(sum(rainAccLombardia)/numLombardiaProvMask);
    rainTotMarche=sum(sum(rainAccMarche)/numMarcheProvMask);
    rainTotMolise=sum(sum(rainAccMolise)/numMoliseProvMask);
    rainTotPiemonte=sum(sum(rainAccPiemonte)/numPiemonteProvMask);
    rainTotSardegna=sum(sum(rainAccSardegna)/numSardegnaProvMask);
    rainTotSicily=sum(sum(rainAccSicily))/numSicilyProvMask;
    rainTotToscana=sum(sum(rainAccToscana))/numToscanaProvMask;
    rainTotTrentino=sum(sum(rainAccTrentino))/numTrentinoProvMask;
    rainTotUmbria=sum(sum(rainAccUmbria))/numUmbriaProvMask;
    rainTotValla=sum(sum(rainAccValla))/numVallaProvMask;
    rainTotVeneto=sum(sum(rainAccVeneto))/numVenetoProvMask;
    TotPrecipItaly(framecounter,1)=rainTotItaly;
    TotPrecipAbruzzo(framecounter,1)=rainTotAbruzzo;
    TotPrecipApulia(framecounter,1)=rainTotApulia;
    TotPrecipBasilicata(framecounter,1)=rainTotBasilicata;
    TotPrecipCalabria(framecounter,1)=rainTotCalabria;
    TotPrecipCampania(framecounter,1)=rainTotCampania;
    TotPrecipEmilia(framecounter,1)=rainTotEmilia;
    TotPrecipFriuli(framecounter,1)=rainTotFriuli;
    TotPrecipLazio(framecounter,1)=rainTotLazio;
    TotPrecipLiguria(framecounter,1)=rainTotLiguria;
    TotPrecipLombardia(framecounter,1)=rainTotLombardia;
    TotPrecipMarche(framecounter,1)=rainTotMarche;
    TotPrecipMolise(framecounter,1)=rainTotMolise;
    TotPrecipPiemonte(framecounter,1)=rainTotPiemonte;
    TotPrecipSardegna(framecounter,1)=rainTotSardegna;
    TotPrecipSicily(framecounter,1)=rainTotSicily;
    TotPrecipToscana(framecounter,1)=rainTotToscana;
    TotPrecipTrentino(framecounter,1)=rainTotTrentino;
    TotPrecipUmbria(framecounter,1)=rainTotUmbria;
    TotPrecipValla(framecounter,1)=rainTotValla;
    TotPrecipVeneto(framecounter,1)=rainTotVeneto;
%% Calculate Italy RainFall Stats
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccItaly,lowcutoff,highcutoff);
    TotAccumilItaly(framecounter,1)=val50;
    TotAccumilItaly(framecounter,2)=val75;
    TotAccumilItaly(framecounter,3)=val90;
    TotAccumilItaly(framecounter,4)=val92;
    TotAccumilItaly(framecounter,5)=val95;
    TotAccumilItaly(framecounter,6)=val96;
    TotAccumilItaly(framecounter,7)=val97;
    TotAccumilItaly(framecounter,8)=val98;
    TotAccumilItaly(framecounter,9)=val99;
    TotAccumilItaly(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
% Display One frame of Data for all Italy
    DisplayRainFallAccumilation(itype,DailyPrecip)
% Get the Accumilation data for Abruzzo Province
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccAbruzzo,lowcutoff,highcutoff);
    TotAccumilAbruzzo(framecounter,1)=val50;
    TotAccumilAbruzzo(framecounter,2)=val75;
    TotAccumilAbruzzo(framecounter,3)=val90;
    TotAccumilAbruzzo(framecounter,4)=val92;
    TotAccumilAbruzzo(framecounter,5)=val95;
    TotAccumilAbruzzo(framecounter,6)=val96;
    TotAccumilAbruzzo(framecounter,7)=val97;
    TotAccumilAbruzzo(framecounter,8)=val98;
    TotAccumilAbruzzo(framecounter,9)=val99;
    TotAccumilAbruzzo(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
% Get the Accumilation data for Apulia Province
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccApulia,lowcutoff,highcutoff);
    TotAccumilApulia(framecounter,1)=val50;
    TotAccumilApulia(framecounter,2)=val75;
    TotAccumilApulia(framecounter,3)=val90;
    TotAccumilApulia(framecounter,4)=val92;
    TotAccumilApulia(framecounter,5)=val95;
    TotAccumilApulia(framecounter,6)=val96;
    TotAccumilApulia(framecounter,7)=val97;
    TotAccumilApulia(framecounter,8)=val98;
    TotAccumilApulia(framecounter,9)=val99;
    TotAccumilApulia(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
 % Get the Accumilation data for Basilicata Province
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccBasilicata,lowcutoff,highcutoff);
    TotAccumilBasilicata(framecounter,1)=val50;
    TotAccumilBasilicata(framecounter,2)=val75;
    TotAccumilBasilicata(framecounter,3)=val90;
    TotAccumilBasilicata(framecounter,4)=val92;
    TotAccumilBasilicata(framecounter,5)=val95;
    TotAccumilBasilicata(framecounter,6)=val96;
    TotAccumilBasilicata(framecounter,7)=val97;
    TotAccumilBasilicata(framecounter,8)=val98;
    TotAccumilBasilicata(framecounter,9)=val99;
    TotAccumilBasilicata(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Calabria Province
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccCalabria,lowcutoff,highcutoff);
    TotAccumilCalabria(framecounter,1)=val50;
    TotAccumilCalabria(framecounter,2)=val75;
    TotAccumilCalabria(framecounter,3)=val90;
    TotAccumilCalabria(framecounter,4)=val92;
    TotAccumilCalabria(framecounter,5)=val95;
    TotAccumilCalabria(framecounter,6)=val96;
    TotAccumilCalabria(framecounter,7)=val97;
    TotAccumilCalabria(framecounter,8)=val98;
    TotAccumilCalabria(framecounter,9)=val99;
    TotAccumilCalabria(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Campania Province
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccCampania,lowcutoff,highcutoff);
    TotAccumilCampania(framecounter,1)=val50;
    TotAccumilCampania(framecounter,2)=val75;
    TotAccumilCampania(framecounter,3)=val90;
    TotAccumilCampania(framecounter,4)=val92;
    TotAccumilCampania(framecounter,5)=val95;
    TotAccumilCampania(framecounter,6)=val96;
    TotAccumilCampania(framecounter,7)=val97;
    TotAccumilCampania(framecounter,8)=val98;
    TotAccumilCampania(framecounter,9)=val99;
    TotAccumilCampania(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Emilia Province-Prov 2
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccEmilia,lowcutoff,highcutoff);
    TotAccumilEmilia(framecounter,1)=val50;
    TotAccumilEmilia(framecounter,2)=val75;
    TotAccumilEmilia(framecounter,3)=val90;
    TotAccumilEmilia(framecounter,4)=val92;
    TotAccumilEmilia(framecounter,5)=val95;
    TotAccumilEmilia(framecounter,6)=val96;
    TotAccumilEmilia(framecounter,7)=val97;
    TotAccumilEmilia(framecounter,8)=val98;
    TotAccumilEmilia(framecounter,9)=val99;
    TotAccumilEmilia(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Friuli Province-Prov 2
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccFriuli,lowcutoff,highcutoff);
    TotAccumilFriuli(framecounter,1)=val50;
    TotAccumilFriuli(framecounter,2)=val75;
    TotAccumilFriuli(framecounter,3)=val90;
    TotAccumilFriuli(framecounter,4)=val92;
    TotAccumilFriuli(framecounter,5)=val95;
    TotAccumilFriuli(framecounter,6)=val96;
    TotAccumilFriuli(framecounter,7)=val97;
    TotAccumilFriuli(framecounter,8)=val98;
    TotAccumilFriuli(framecounter,9)=val99;
    TotAccumilFriuli(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Lazio Province-Prov 2
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccLazio,lowcutoff,highcutoff);
    TotAccumilLazio(framecounter,1)=val50;
    TotAccumilLazio(framecounter,2)=val75;
    TotAccumilLazio(framecounter,3)=val90;
    TotAccumilLazio(framecounter,4)=val92;
    TotAccumilLazio(framecounter,5)=val95;
    TotAccumilLazio(framecounter,6)=val96;
    TotAccumilLazio(framecounter,7)=val97;
    TotAccumilLazio(framecounter,8)=val98;
    TotAccumilLazio(framecounter,9)=val99;
    TotAccumilLazio(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Liguria Province-Prov 2
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccLiguria,lowcutoff,highcutoff);
    TotAccumilLiguria(framecounter,1)=val50;
    TotAccumilLiguria(framecounter,2)=val75;
    TotAccumilLiguria(framecounter,3)=val90;
    TotAccumilLiguria(framecounter,4)=val92;
    TotAccumilLiguria(framecounter,5)=val95;
    TotAccumilLiguria(framecounter,6)=val96;
    TotAccumilLiguria(framecounter,7)=val97;
    TotAccumilLiguria(framecounter,8)=val98;
    TotAccumilLiguria(framecounter,9)=val99;
    TotAccumilLiguria(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Lombardia Province-Prov 2
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccLombardia,lowcutoff,highcutoff);
    TotAccumilLombardia(framecounter,1)=val50;
    TotAccumilLombardia(framecounter,2)=val75;
    TotAccumilLombardia(framecounter,3)=val90;
    TotAccumilLombardia(framecounter,4)=val92;
    TotAccumilLombardia(framecounter,5)=val95;
    TotAccumilLombardia(framecounter,6)=val96;
    TotAccumilLombardia(framecounter,7)=val97;
    TotAccumilLombardia(framecounter,8)=val98;
    TotAccumilLombardia(framecounter,9)=val99;
    TotAccumilLombardia(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Marche Province-Prov 3
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccMarche,lowcutoff,highcutoff);
    TotAccumilMarche(framecounter,1)=val50;
    TotAccumilMarche(framecounter,2)=val75;
    TotAccumilMarche(framecounter,3)=val90;
    TotAccumilMarche(framecounter,4)=val92;
    TotAccumilMarche(framecounter,5)=val95;
    TotAccumilMarche(framecounter,6)=val96;
    TotAccumilMarche(framecounter,7)=val97;
    TotAccumilMarche(framecounter,8)=val98;
    TotAccumilMarche(framecounter,9)=val99;
    TotAccumilMarche(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Molise Province-Prov 3
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccMolise,lowcutoff,highcutoff);
    TotAccumilMolise(framecounter,1)=val50;
    TotAccumilMolise(framecounter,2)=val75;
    TotAccumilMolise(framecounter,3)=val90;
    TotAccumilMolise(framecounter,4)=val92;
    TotAccumilMolise(framecounter,5)=val95;
    TotAccumilMolise(framecounter,6)=val96;
    TotAccumilMolise(framecounter,7)=val97;
    TotAccumilMolise(framecounter,8)=val98;
    TotAccumilMolise(framecounter,9)=val99;
    TotAccumilMolise(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
 % Get the Accumilation data for Piemonte Province-Prov 3
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccPiemonte,lowcutoff,highcutoff);
    TotAccumilPiemonte(framecounter,1)=val50;
    TotAccumilPiemonte(framecounter,2)=val75;
    TotAccumilPiemonte(framecounter,3)=val90;
    TotAccumilPiemonte(framecounter,4)=val92;
    TotAccumilPiemonte(framecounter,5)=val95;
    TotAccumilPiemonte(framecounter,6)=val96;
    TotAccumilPiemonte(framecounter,7)=val97;
    TotAccumilPiemonte(framecounter,8)=val98;
    TotAccumilPiemonte(framecounter,9)=val99;
    TotAccumilPiemonte(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Sardegna Province 3
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccSardegna,lowcutoff,highcutoff);
    TotAccumilSardegna(framecounter,1)=val50;
    TotAccumilSardegna(framecounter,2)=val75;
    TotAccumilSardegna(framecounter,3)=val90;
    TotAccumilSardegna(framecounter,4)=val92;
    TotAccumilSardegna(framecounter,5)=val95;
    TotAccumilSardegna(framecounter,6)=val96;
    TotAccumilSardegna(framecounter,7)=val97;
    TotAccumilSardegna(framecounter,8)=val98;
    TotAccumilSardegna(framecounter,9)=val99;
    TotAccumilSardegna(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
 % Get the Accumilation data for Sicily Province 3
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccSicily,lowcutoff,highcutoff);
    TotAccumilSicily(framecounter,1)=val50;
    TotAccumilSicily(framecounter,2)=val75;
    TotAccumilSicily(framecounter,3)=val90;
    TotAccumilSicily(framecounter,4)=val92;
    TotAccumilSicily(framecounter,5)=val95;
    TotAccumilSicily(framecounter,6)=val96;
    TotAccumilSicily(framecounter,7)=val97;
    TotAccumilSicily(framecounter,8)=val98;
    TotAccumilSicily(framecounter,9)=val99;
    TotAccumilSicily(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
 % Get the Accumilation data for Toscana Province 4
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccToscana,lowcutoff,highcutoff);
    TotAccumilToscana(framecounter,1)=val50;
    TotAccumilToscana(framecounter,2)=val75;
    TotAccumilToscana(framecounter,3)=val90;
    TotAccumilToscana(framecounter,4)=val92;
    TotAccumilToscana(framecounter,5)=val95;
    TotAccumilToscana(framecounter,6)=val96;
    TotAccumilToscana(framecounter,7)=val97;
    TotAccumilToscana(framecounter,8)=val98;
    TotAccumilToscana(framecounter,9)=val99;
    TotAccumilToscana(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Trentino Province 4
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccTrentino,lowcutoff,highcutoff);
    TotAccumilTrentino(framecounter,1)=val50;
    TotAccumilTrentino(framecounter,2)=val75;
    TotAccumilTrentino(framecounter,3)=val90;
    TotAccumilTrentino(framecounter,4)=val92;
    TotAccumilTrentino(framecounter,5)=val95;
    TotAccumilTrentino(framecounter,6)=val96;
    TotAccumilTrentino(framecounter,7)=val97;
    TotAccumilTrentino(framecounter,8)=val98;
    TotAccumilTrentino(framecounter,9)=val99;
    TotAccumilTrentino(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Umbria Province 4
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccUmbria,lowcutoff,highcutoff);
    TotAccumilUmbria(framecounter,1)=val50;
    TotAccumilUmbria(framecounter,2)=val75;
    TotAccumilUmbria(framecounter,3)=val90;
    TotAccumilUmbria(framecounter,4)=val92;
    TotAccumilUmbria(framecounter,5)=val95;
    TotAccumilUmbria(framecounter,6)=val96;
    TotAccumilUmbria(framecounter,7)=val97;
    TotAccumilUmbria(framecounter,8)=val98;
    TotAccumilUmbria(framecounter,9)=val99;
    TotAccumilUmbria(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
  % Get the Accumilation data for Valla Province 4
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccValla,lowcutoff,highcutoff);
    TotAccumilValla(framecounter,1)=val50;
    TotAccumilValla(framecounter,2)=val75;
    TotAccumilValla(framecounter,3)=val90;
    TotAccumilValla(framecounter,4)=val92;
    TotAccumilValla(framecounter,5)=val95;
    TotAccumilValla(framecounter,6)=val96;
    TotAccumilValla(framecounter,7)=val97;
    TotAccumilValla(framecounter,8)=val98;
    TotAccumilValla(framecounter,9)=val99;
    TotAccumilValla(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
% Get the Accumilation data for Veneto Province 4
    [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(rainAccVeneto,lowcutoff,highcutoff);
    TotAccumilVeneto(framecounter,1)=val50;
    TotAccumilVeneto(framecounter,2)=val75;
    TotAccumilVeneto(framecounter,3)=val90;
    TotAccumilVeneto(framecounter,4)=val92;
    TotAccumilVeneto(framecounter,5)=val95;
    TotAccumilVeneto(framecounter,6)=val96;
    TotAccumilVeneto(framecounter,7)=val97;
    TotAccumilVeneto(framecounter,8)=val98;
    TotAccumilVeneto(framecounter,9)=val99;
    TotAccumilVeneto(framecounter,10)=val100;
    StatValues(1,1)=val50;
    StatValues(2,1)=val75;
    StatValues(3,1)=val90;
    StatValues(4,1)=val92;
    StatValues(5,1)=val95;
    StatValues(6,1)=val96;
    StatValues(7,1)=val97;
    StatValues(8,1)=val98;
    StatValues(9,1)=val99;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;
    dispstr=strcat('Finished processing frame-',num2str(n),'-of-',num2str(numRainFallFiles),'-total frames');
    disp(dispstr)    
end

if(iMovie==1)
    close(vTemp);
end
%% Create Tabular data of the DailyRainFall Data by Province
% Get the time of date of the first file-this will be used in subsequent
% tables
%TdmyhrminsecStart=Tdmyhrminsec;
startst=char(TdmyhrminsecStart);
idash=strfind(startst,'-');
is=1;
ie=idash(1)-1;
ds=str2double(startst(is:ie));
is=idash(1)+1;
ie=idash(2)-1;
MonthStr=(startst(is:ie));
mds= ConvertMonthStrToNumber(MonthStr);
is=idash(2)+1;
ie=is+3;
yrs=str2double(startst(is:ie));
ab=1;
stime=datetime(yrs,mds,ds);
timestep=days(1);
%% Create the The Daily RainFall Totals Table for Italy and the first 5 provinces
DailyRainFallTotalProv1Table=table(TotPrecipItaly(:,1),TotPrecipAbruzzo(:,1),TotPrecipApulia(:,1),TotPrecipBasilicata(:,1),...
    TotPrecipCalabria(:,1),TotPrecipCampania(:,1),...
    'VariableNames',{'Italy','Abruzzo','Apulia',...
     'Basilicata','Calabria','Campania'});
DailyRainFallTotalProv1TT = table2timetable( DailyRainFallTotalProv1Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallTotalProv1Table DailyRainFallTotalProv1TT';
MatFileName=strcat('DailyRainFallTotalProv1Table-',num2str(yrs),'-DailyAvgSum','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallTotalProv1TT-','Contains Daily Rainfall data for Italy and 5 Provinces-',num2str(1));
fprintf(fid,'%s\n',silstr);

% Now plot this data
titlestr='DailyRainFallAverageProv1';
ikind=1;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5TotalRainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create the The Daily RainFall Totals Table for Italy and the second 5 provinces
DailyRainFallTotalProv2Table=table(TotPrecipItaly(:,1),TotPrecipEmilia(:,1),TotPrecipFriuli(:,1),TotPrecipLazio(:,1),...
    TotPrecipLiguria(:,1),TotPrecipLombardia(:,1),...
    'VariableNames',{'Italy','Emilia','Friuli',...
     'Lazio','Liguria','Lombardia'});
DailyRainFallTotalProv2TT = table2timetable( DailyRainFallTotalProv2Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallTotalProv2Table DailyRainFallTotalProv2TT';
MatFileName=strcat('DailyRainFallTotalProv2Table-',num2str(yrs),'-DailyAvgSum','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallTotalProv2TT-','Contains Daily Rainfall data for Italy and 5 Provinces-',num2str(2));
fprintf(fid,'%s\n',silstr);
% Now plot this data
titlestr='DailyRainFallAverageProv2';
ikind=2;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5TotalRainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create the The Daily RainFall Totals Table for Italy and the third 5 provinces
DailyRainFallTotalProv3Table=table(TotPrecipItaly(:,1),TotPrecipMarche(:,1),TotPrecipMolise(:,1),TotPrecipPiemonte(:,1),...
    TotPrecipSardegna(:,1),TotPrecipSicily(:,1),...
    'VariableNames',{'Italy','Marche','Molise',...
     'Piemonte','Sardegna','Sicily'});
DailyRainFallTotalProv3TT = table2timetable( DailyRainFallTotalProv3Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallTotalProv3Table DailyRainFallTotalProv3TT';
MatFileName=strcat('DailyRainFallTotalProv3Table-',num2str(yrs),'-DailyAvgSum','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallTotalProv3TT-','Contains Daily Rainfall data for Italy and 5 Provinces-',num2str(3));
fprintf(fid,'%s\n',silstr);
% Now plot this data
titlestr='DailyRainFallAverageProv3';
ikind=3;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5TotalRainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create the The Daily RainFall Totals Table for Italy and the fourth 5 provinces
DailyRainFallTotalProv4Table=table(TotPrecipItaly(:,1),TotPrecipToscana(:,1),TotPrecipTrentino(:,1),TotPrecipUmbria(:,1),...
      TotPrecipValla(:,1),TotPrecipVeneto(:,1),...
      'VariableNames',{'Italy','Toscana','Trentino',...
     'Umbria','Valla','Veneto'});
DailyRainFallTotalProv4TT = table2timetable( DailyRainFallTotalProv4Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallTotalProv4Table DailyRainFallTotalProv4TT';
MatFileName=strcat('DailyRainFallTotalProv4Table-',num2str(yrs),'-DailyAvgSum','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallTotalProv4TT-','Contains Daily Rainfall data for Italy and 5 Provinces-',num2str(4));
fprintf(fid,'%s\n',silstr);
%close(fid);
% Now plot this data
titlestr='DailyRainFallAverageProv4';
ikind=4;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5TotalRainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create a master table with data from each province but not from Italy as a whole
DailyRainFallAllProvTable=table(TotPrecipAbruzzo(:,1),TotPrecipApulia(:,1),TotPrecipBasilicata(:,1),...
    TotPrecipCalabria(:,1),TotPrecipCampania(:,1),TotPrecipEmilia(:,1),TotPrecipFriuli(:,1),...
    TotPrecipLazio(:,1),TotPrecipLiguria(:,1),TotPrecipLombardia(:,1),...
    TotPrecipMarche(:,1),TotPrecipMolise(:,1),TotPrecipPiemonte(:,1),...
    TotPrecipSardegna(:,1),TotPrecipSicily(:,1),...
    TotPrecipToscana(:,1),TotPrecipTrentino(:,1),TotPrecipUmbria(:,1),...
      TotPrecipValla(:,1),TotPrecipVeneto(:,1),...
    'VariableNames',{'Abruzzo','Apulia','Basilicata','Calabria','Campania',...
    'Emilia','Friuli','Lazio','Liguria','Lombardia','Marche','Molise','Piemonte',...
    'Sardegna','Sicily','Toscana','Trentino','Umbria','Valla','Veneto'});
DailyRainFallAllProvTT=table2timetable(DailyRainFallAllProvTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallAllProvTT DailyRainFallAllProvTable';
MatFileName=strcat('DailyRainFallTotalMasterTable-',num2str(yrs),'-DailyAvgSum','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallTotal Master Table-','Contains Daily Rainfall data all 20 Italian Provinces',num2str(5));
fprintf(fid,'%s\n',silstr);
%% Now see which provinces have the most rainful accumilation
[nrows]=height(DailyRainFallAllProvTable);
[ncols]=width(DailyRainFallAllProvTable);
xval=zeros(ncols,1);
RankByDate=zeros(nrows,ncols);
RankOverData=zeros(ncols,1);
ProvinceRainFallRankedData=cell(1+ncols,2);
ProvinceRainFallRankedData{1,1}='Province';
ProvinceRainFallRankedData{1,2}='RainFallMetric';
for n=1:nrows
    xt=DailyRainFallAllProvTable(n,1);
    xval(1,1)=xt.Abruzzo;
    xt=DailyRainFallAllProvTable(n,2);
    xval(2,1)=xt.Apulia;
    xt=DailyRainFallAllProvTable(n,3);
    xval(3,1)=xt.Basilicata;
    xt=DailyRainFallAllProvTable(n,4);
    xval(4,1)=xt.Calabria;
    xt=DailyRainFallAllProvTable(n,5);
    xval(5,1)=xt.Campania;
    xt=DailyRainFallAllProvTable(n,6);
    xval(6,1)=xt.Emilia;
    xt=DailyRainFallAllProvTable(n,7);
    xval(7,1)=xt.Friuli;
    xt=DailyRainFallAllProvTable(n,8);
    xval(8,1)=xt.Lazio;
    xt=DailyRainFallAllProvTable(n,9);
    xval(9,1)=xt.Liguria;
    xt=DailyRainFallAllProvTable(n,10);
    xval(10,1)=xt.Lombardia;
    xt=DailyRainFallAllProvTable(n,11);
    xval(11,1)=xt.Marche;
    xt=DailyRainFallAllProvTable(n,12);
    xval(12,1)=xt.Molise;
    xt=DailyRainFallAllProvTable(n,13);
    xval(13,1)=xt.Piemonte;
    xt=DailyRainFallAllProvTable(n,14);
    xval(14,1)=xt.Sardegna;
    xt=DailyRainFallAllProvTable(n,15);
    xval(15,1)=xt.Sicily;
    xt=DailyRainFallAllProvTable(n,16);
    xval(16,1)=xt.Toscana;
    xt=DailyRainFallAllProvTable(n,17);
    xval(17,1)=xt.Trentino;
    xt=DailyRainFallAllProvTable(n,18);
    xval(18,1)=xt.Umbria;
    xt=DailyRainFallAllProvTable(n,19);
    xval(19,1)=xt.Valla;
    xt=DailyRainFallAllProvTable(n,20);
    xval(20,1)=xt.Veneto;
    [Sortxval,ind]=sort(xval,'descend');
    for j=1:ncols
        indx=ind(j);
        RankByDate(n,indx)=j;
    end
end
%% Sort based on the whole dataset
RankOverData(1,1)=sum(TotPrecipAbruzzo(:,1));
RankOverData(2,1)=sum(TotPrecipApulia(:,1));
RankOverData(3,1)=sum(TotPrecipBasilicata(:,1));
RankOverData(4,1)=sum(TotPrecipCalabria(:,1));
RankOverData(5,1)=sum(TotPrecipCampania(:,1));
RankOverData(6,1)=sum(TotPrecipEmilia(:,1));
RankOverData(7,1)=sum(TotPrecipFriuli(:,1));
RankOverData(8,1)=sum(TotPrecipLazio(:,1));
RankOverData(9,1)=sum(TotPrecipLiguria(:,1));
RankOverData(10,1)=sum(TotPrecipLombardia(:,1));
RankOverData(11,1)=sum(TotPrecipMarche(:,1));
RankOverData(12,1)=sum(TotPrecipMolise(:,1));
RankOverData(13,1)=sum(TotPrecipPiemonte(:,1));
RankOverData(14,1)=sum(TotPrecipSardegna(:,1));
RankOverData(15,1)=sum(TotPrecipSicily(:,1));
RankOverData(16,1)=sum(TotPrecipToscana(:,1));
RankOverData(17,1)=sum(TotPrecipTrentino(:,1));
RankOverData(18,1)=sum(TotPrecipUmbria(:,1));
RankOverData(19,1)=sum(TotPrecipValla(:,1));
RankOverData(20,1)=sum(TotPrecipVeneto(:,1));
[SortRank,indx]=sort(RankOverData,'descend');
for j=1:ncols
    inds=indx(j);
    nowVal=SortRank(j);
    nowProvince=ProvinceNames{inds,1};
    ProvinceRainFallRankedData{j+1,1}=nowProvince;
    ProvinceRainFallRankedData{j+1,2}=nowVal;

end
% Save this latest data
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
actionstr='save';
varstr1='DailyRainFallAllProvTT DailyRainFallAllProvTable RankOverData RankByDate ProvinceRainFallRankedData';
MatFileName='RankedRainFallStats.mat';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
corrstr=strcat('Saved Ranked Rainfall Data in File-',MatFileName);
disp(corrstr)
fprintf(fid,'%s\n',corrstr);
ab=1;
disp('Run Complete')
