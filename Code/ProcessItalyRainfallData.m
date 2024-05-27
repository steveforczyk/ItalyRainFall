% This script will read the Italy Rainfall
% The data for this set is contained in one enourmous 6 Gb file
%
% Written By: Stephen Forczyk
% Created: April 6,2024
% Revised: April 15,2024 added code to change hourly rain tables
% Revised: April 16,2024 allow to the user to sum up 24 hourly files
% to create a daily file. Save these files to allow for some daily
% processing
% to daily tables
% Revised: April 18,2024 added fix to how start dates are calculated so
% that the tables don't have to begin on Jan 1 but at any time. However the
% data selected for analysis SHOULD begin of GMT-0 Hrs on date selected

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
global DailyPrecip DateTimeHold yrs mds ds;
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
global DailyRainFallFiles;
global rainAccItaly rainAccAbruzzo rainAccApulia  rainAccBasilicata ;
global rainAccCalabria rainAccCampania rainAccEmilia rainAccFriuli;
global rainAccLazio rainAccLiguria rainAccLombardia rainAccMarche;
global rainAccMolise rainAccPiemonte rainAccSardegna rainAccSicily;
global rainAccToscana rainAccTrentino rainAccUmbria rainAccValla rainAccVeneto;
global rainTotItaly rainTotAbruzzo rainTotApulia  rainTotBasilicata;
global rainTotCalabria rainTotCampania rainTotEmilia rainTotFriuli;
global rainTotLazio rainTotLiguria rainTotLombardia rainTotMarche;
global rainTotMolise rainTotPiemonte rainTotSardegna rainTotSicily;
global rainTotToscana rainTotTrentino rainTotUmbria rainTotValla;
global rainTotVeneto;
global startindex endindex TdmyhrminsecStart;
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
iCheckConfig=1;
sf1=.039370;
% Set Cells
MaskPoints=cell(22,2);
MaskPoints{1,1}='MaskName';
MaskPoints{1,2}='Number of Values';
MaskPoints{1,3}='Mask Area km^2';
% Load in some needed files just 1 time
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
load('ItalyERA5RasterData.mat');
load('ItalyRainFallConstants.mat');
eval(['cd ' maskpath(1:length(maskpath)-1)]);
load('ItalyMasks.mat');

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

%% This section is a one time use batch of code to create selected files idecode shpuld be set to zero to skip this
if(idecode==1) %% Do not run this as a matter of course. This section included to create selectd files
% Reading the large combined data file
    eval(['cd ' datapath(1:length(datapath)-1)]);
    finfo = ncinfo(ItalyRainFallFile);
    ItalyPrecipLats=ncread(ItalyRainFallFile,'lat');
    ItalyPrecipLons=ncread(ItalyRainFallFile,'lon');
    ItalyPrecipTimes=ncread(ItalyRainFallFile,'time');
    disp('Read Total Precip')
    ItalyTotPrecip=ncread(ItalyRainFallFile,'TOT_PREC');
    disp('Finished Reading Tot precip')
% Now turn this into 1 time slice per file
    eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
% Create the Constant File first
    for n=1:4344
        Tdmyhrminsec = datetime(ItalyPrecipTimes(n,1),'ConvertFrom',...
        'epochtime','Epoch','1980-01-01','Format','d-MMM-y HH:mm:ss Z');
        ItalySliceTimes{n,1}=Tdmyhrminsec;
    end
        MatFileName='ItalyRainFallConstants.mat';
        actionstr='save';
        varstr='ItalySliceTimes ItalyPrecipLats ItalyPrecipLons ItalyPrecipTimes';
        qualstr='-v7.3';
        [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
        eval(cmdString)
        disp('Saved Italy ConstantsFile')
% Now create an individual file for each time slice    
    for n=1:4344
        tslice=n;
        TslicePrecip=ItalyTotPrecip(:,:,n);
        Tdmyhrminsec = datetime(ItalyPrecipTimes(n,1),'ConvertFrom',...
        'epochtime','Epoch','1980-01-01','Format','d-MMM-y HH:mm:ss Z');
        MatFileName=strcat('TimeSlice-',num2str(tslice),'-ItalyRainFall.mat');
        actionstr='save';
        varstr='TslicePrecip ItalyRainFallFile Tdmyhrminsec';
        qualstr='-v7.3';
        [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
        eval(cmdString)
         if(mod(n,50)==0)
            dispstr=strcat('Writing Slice-',num2str(n),'-to File-',MatFileName);
            disp(dispstr)
        end
    end
    disp('all done')
end

%% List of the needed shape files
if(iprecomputed==0)
    Shapefile0Name='ITA_adm0.shp';
    Shapefile1Name='ITA_adm1.shp';
    Shapefile2Name='ITA_adm2.shp';
    Shapefile3Name='ITA_adm3.shp';
    Shapefile4Name='ItalyCities.shp';
    eval(['cd ' mappath(1:length(mappath)-1)]);
    warning('off'); 
    S0 = shaperead(Shapefile0Name,'UseGeoCoords',true);
    ItalyLats=S0.Lat';
    ItalyLons=S0.Lon';
    SC= shaperead(Shapefile4Name,'UseGeoCoords',true);
    nrank4=0;
    for k=1:101
        WholeCityLat(k,1)=SC(k).Lat;
        WholeCityLon(k,1)=SC(k).Lon;
        nowRank=SC(k).RANK;
        if(nowRank<5)
            nrank4=nrank4+1;
        end
        WholeCityRank(k,1)=nowRank;
    end
    ItalyCityLats=zeros(nrank4,1);
    ItalyCityLons=zeros(nrank4,1);
    ItalyCityName=cell(nrank4,1);
    nr=0;
    for k=1:101
        nowRank=WholeCityRank(k,1);
        if(nowRank<5)
            nr=nr+1;
            ItalyCityLats(nr,1)=WholeCityLat(k,1);
            ItalyCityLons(nr,1)=WholeCityLon(k,1);
            ItalyCityName{nr,1}=SC(k).Name;
        end
    end
    S1 = shaperead(Shapefile1Name,'UseGeoCoords',true);
    ab=1;
    AbruzzoProvinceLat=S1(1).Lat';
    AbruzzoProvinceLon=S1(1).Lon';
    ApuliaProvinceLat=S1(2).Lat';
    ApuliaProvinceLon=S1(2).Lon';
    BasilicataProvinceLat=S1(3).Lat';
    BasilicataProvinceLon=S1(3).Lon';
    CalabriaProvinceLat=S1(4).Lat';
    CalabriaProvinceLon=S1(4).Lon';
    CampaniaProvinceLat=S1(5).Lat';
    CampaniaProvinceLon=S1(5).Lon';
    EmiliaProvinceLat=S1(6).Lat';
    EmiliaProvinceLon=S1(6).Lon';
    FriuliProvinceLat=S1(7).Lat';
    FriuliProvinceLon=S1(7).Lon';
    LazioProvinceLat=S1(8).Lat';
    LazioProvinceLon=S1(8).Lon';
    LiguriaProvinceLat=S1(9).Lat';
    LiguriaProvinceLon=S1(9).Lon';
    LombardiaProvinceLat=S1(10).Lat';
    LombardiaProvinceLon=S1(10).Lon';
    MarcheProvinceLat=S1(11).Lat';
    MarcheProvinceLon=S1(11).Lon';
    MoliseProvinceLat=S1(12).Lat';
    MoliseProvinceLon=S1(12).Lon';
    PiemonteProvinceLat=S1(13).Lat';
    PiemonteProvinceLon=S1(13).Lon';
    SardegnaProvinceLat=S1(14).Lat';
    SardegnaProvinceLon=S1(14).Lon';
    SicilyProvinceLat=S1(15).Lat';
    SicilyProvinceLon=S1(15).Lon';
    ToscanaProvinceLat=S1(16).Lat';
    ToscanaProvinceLon=S1(16).Lon';
    TrentinoProvinceLat=S1(17).Lat';
    TrentinoProvinceLon=S1(17).Lon';
    UmbriaProvinceLat=S1(18).Lat';
    UmbriaProvinceLon=S1(18).Lon';
    VallaProvinceLat=S1(19).Lat';
    VallaProvinceLon=S1(19).Lon';
    VenetoProvinceLat=S1(20).Lat';
    VenetoProvinceLon=S1(20).Lon';
% save this data to a file

end

% Load the constants File
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
load(RainFallConstantsFile);
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
%% Now calculate the area of each Raster point if the data file does not already exist. This on varies by latitude
% but not very much as the latitude spread is small
% If the data file has already been saved skip this step and load the file
% Get the area of each cell based on the latitude-this is hardwired for the
% ERA5 grid for Italy which is nlats=652 nlons 570 
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
a2=exist('ItalyERA5RasterData.mat');
if(a2~=2)
    nlats=652;
    nlons=570;
    ItalyRasterAreas=4.84*ones(nlons,nlats);

    for i=1:nlats-1
        for j=1:nlons-1
            lat1=ItalyPrecipLats(i);
            lat2=ItalyPrecipLats(i+1);
            lon1=ItalyPrecipLons(j);
            lon2=ItalyPrecipLons(j+1);
            [arclen1,~]=distance(lat1,lon1,lat2,lon2);
            arclen1=abs(arclen1);
            radius = geocradius(lat1);
            distlat=radius*arclen1*deg2rad;
            [arclen2,~]=distance(lat1,lon1,lat2,lon2);
            arclen2=abs(arclen2);
            distlon=radius*arclen2*deg2rad;
            areakm=distlat*distlon/1E6;
            ab=1;
            ItalyRasterAreas(j,i)=areakm;
        end
    end

% Now save this raster data
      eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
      actionstr='save';
      varstr1='ItalyRasterAreas VenetoProvinceLat VenetoProvinceLon AbruzzoProvinceLat AbruzzoProvinceLon';
      varstr2=' ApuliaProvinceLat ApuliaProvinceLon BasilicataProvinceLat BasilicataProvinceLon';
      varstr3=' CalabriaProvinceLat CalabriaProvinceLon CampaniaProvinceLat CampaniaProvinceLon';
      varstr4=' EmiliaProvinceLat EmiliaProvinceLon FriuliProvinceLat FriuliProvinceLon';
      varstr5= ' LazioProvinceLat LazioProvinceLon LiguriaProvinceLat LiguriaProvinceLon';
      varstr6= ' LombardiaProvinceLat LombardiaProvinceLon MarcheProvinceLat MarcheProvinceLon ';
      varstr7='  MoliseProvinceLat MoliseProvinceLon PiemonteProvinceLat PiemonteProvinceLon';
      varstr8='  SardegnaProvinceLat SardegnaProvinceLon SicilyProvinceLat SicilyProvinceLon';
      varstr9=' ToscanaProvinceLat ToscanaProvinceLon TrentinoProvinceLat TrentinoProvinceLon';
      varstr10=' UmbriaProvinceLat UmbriaProvinceLon VallaProvinceLat VallaProvinceLon';
      varstr11=' ItalyCityLats ItalyCityLons ItalyCityName ItalyLats ItalyLons';
      varstr=strcat(varstr1,varstr2,varstr3,varstr4,varstr5);
      varstr=strcat(varstr,varstr6,varstr7,varstr8,varstr9,varstr10,varstr11);
      MatFileName=strcat('ItalyERA5RasterData','.mat');
      qualstr='-v7.3';
      [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
      eval(cmdString)
      dispstr=strcat('Saved File-',MatFileName);
      disp(dispstr);
else % This will load the precomputed raster data
        load('ItalyERA5RasterData.mat');
        dispstr=strcat('ERA5 Raster Data Loaded From File-','ItalyERA5RasterData.mat');
        disp(dispstr);
end
ab=1;
%% Create Masks for Italy and Italian Provinces
% Now calculate the Province Boundaries for Italy (20 Provinces)
if(iCreateMasks==1)
    CreateERA5ItalyMasks()
end
ab=2;
% Load the ItalyMask along with the 20 Italian ProvinceMasks
eval(['cd ' maskpath(1:length(maskpath)-1)]);
load('ItalyMasks.mat');
disp('loaded all Italy Masks')

% Now select files to read
tic;
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
[RainFallFiles,nowpath] = uigetfile('*ItalyRainFall.mat','Select Multiple Files', ...
'MultiSelect', 'on');
RainFallFiles=RainFallFiles';
numRainFallFiles=length(RainFallFiles);
[idash]=strfind(RainFallFiles{1,1},'-');
numdash=(length(idash));
is=idash(1)+1;
ie=idash(2)-1;
nowFile=char(RainFallFiles{1,1});
starttimestr=nowFile(is:ie);
startindex=str2num(starttimestr);
[idash]=strfind(RainFallFiles{numRainFallFiles,1},'-');
numdash=(length(idash));
is=idash(1)+1;
ie=idash(2)-1;
nowFile=char(RainFallFiles{numRainFallFiles,1});
endtimestr=nowFile(is:ie);
endindex=str2num(endtimestr);
datetime1=ItalySliceTimes{1,1};
datestr1=string(datetime1);
datechrstr=char(datestr1);
[idash]=strfind(datechrstr,'-');
numdash=length(idash);
is=1;
ie=idash(1)-1;
daystr=datechrstr(is:ie);
dd=str2double(daystr);
is=ie+2;
ie=idash(2)-1;
MonthStr=datechrstr(is:ie);
[md] = ConvertMonthStrToNumber(MonthStr);
is=ie+2;
ie=is+3;
yearstr=datechrstr(is:ie);
yd=str2double(yearstr);
[icolon]=strfind(datechrstr,':');
numcolon=length(icolon);
is=icolon(1)-2;
ie=is+1;
hourstr=datechrstr(is:ie);
hrd=str2double(hourstr);
mind=0;
secd=0;
stime=datetime(yd,md,dd,hrd,mind,secd);
timestep=hours(1);
ab=1;
%% Set Up Log File-text based file to store critical data about run for analysis purposes-this is the normal entry point
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start ProcessItalyRainFallData Run at-',startruntime);
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
logfilename=strcat('RainFallAmount-',logfilename,'.txt');
%pdffilename=strcat('Merra2-',datetimestr);
fid=fopen(logfilename,'w');
dispstr=strcat('Opened Log file-',logfilename,'-for writing');
disp(dispstr);
fprintf(fid,'%50s\n',startrunstr);
%% Get the Run Configuration Data
if(iCheckConfig==1)
    SpecifyMatlabConfiguration('ProcessItalyRainfallData.m');
end
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
%% Print a list of files to be processed
fprintf(fid,'\n');
fprintf(fid,'%s\n','----- List of Files to Be processed-----');
for nn=1:numRainFallFiles
    nowFile=char(RainFallFiles{n,1});
    filestr=strcat('File Num-',num2str(nn),'--',nowFile);       
    fprintf(fid,'%s\n',filestr);
end       
fprintf(fid,'%s\n','----- End List of Files to Be processed-----');

%% Start a movieFile
if(iMovie==1)
    eval(['cd ' moviepath(1:length(moviepath)-1)]);
    TempMovieName=strcat('ItalyPrecipTotals-',num2str(numRainFallFiles));
    vTemp = VideoWriter(TempMovieName,'MPEG-4');
    vTemp.Quality=100;
    vTemp.FrameRate=5;
    open(vTemp);
end
%% initialize arrays to hold data
TotPrecipItaly=zeros(numRainFallFiles,1);
TotPrecipAbruzzo=zeros(numRainFallFiles,1);
TotPrecipApulia=zeros(numRainFallFiles,1);
TotPrecipBasilicata=zeros(numRainFallFiles,1);
TotPrecipCalabria=zeros(numRainFallFiles,1);
TotPrecipCampania=zeros(numRainFallFiles,1);
TotPrecipEmilia=zeros(numRainFallFiles,1);
TotPrecipFriuli=zeros(numRainFallFiles,1);
TotPrecipLazio=zeros(numRainFallFiles,1);
TotPrecipLiguria=zeros(numRainFallFiles,1);
TotPrecipLombardia=zeros(numRainFallFiles,1);
TotPrecipMarche=zeros(numRainFallFiles,1);
TotPrecipMolise=zeros(numRainFallFiles,1);
TotPrecipPiemonte=zeros(numRainFallFiles,1);
TotPrecipSardegna=zeros(numRainFallFiles,1);
TotPrecipSicily=zeros(numRainFallFiles,1);
TotPrecipToscana=zeros(numRainFallFiles,1);
TotPrecipTrentino=zeros(numRainFallFiles,1);
TotPrecipUmbria=zeros(numRainFallFiles,1);
TotPrecipValla=zeros(numRainFallFiles,1);
TotPrecipVeneto=zeros(numRainFallFiles,1);
icycle=0; % This counter will control saving 24 frames of data
% purpose is to create a daily file from 24 hourly files saved together
%% Start main data loop
for n=1:numRainFallFiles% Loop over the data
    eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
    nowFile=RainFallFiles{n,1};
    load(nowFile);
    if(n==1)
% Get the time of date of the first file-this will be used in subsequent
% tables
        TdmyhrminsecStart=Tdmyhrminsec;
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

    end
    [nnrows,nncols]=size(TslicePrecip);
    icycle=icycle+1;
    lowcutoff=0;
    highcutoff=100;
    framecounter=framecounter+1;
    [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(TslicePrecip,lowcutoff,highcutoff);
    StatValues(1,1)=val10;
    StatValues(2,1)=val20;
    StatValues(3,1)=val30;
    StatValues(4,1)=val40;
    StatValues(5,1)=val50;
    StatValues(6,1)=val60;
    StatValues(7,1)=val70;
    StatValues(8,1)=val80;
    StatValues(9,1)=val90;
    StatValues(10,1)=val100;
    StatValues(11,1)=fraclow;
    StatValues(12,1)=frachigh;
    StatValues(13,1)=fracNaN;

    if((isumhourlyfiles==1) && (icycle==1))
        DailyPrecip(:,:)=TslicePrecip(:,:); 
    end
    if((icycle>1) && (icycle<24))
       DailyPrecip(:,:)=DailyPrecip(:,:)+TslicePrecip(:,:);
       DateTimeHold=Tdmyhrminsec;
    end
    if(icycle==24)
         eval(['cd ' dailyfilepath(1:length(dailyfilepath)-1)]);
         DailyPrecip(:,:)=DailyPrecip(:,:)+TslicePrecip(:,:);
         DailyPrecip=sf1*DailyPrecip;
        [MatFileName] = CreateFileNameFromDatestr(DateTimeHold,'-DailyAcumil.mat'); 
         actionstr='save';
         varstr='DailyPrecip DateTimeHold sf1 nowFile';
         qualstr='-v7.3';
         [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
         eval(cmdString)
         icycle=0;
    end

% Calculate accumilated rainfall for selected regions
% Start With all of Italy
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5ItalyMask;
    rainTotItaly=sum(sum(rainTotArray));
    TotPrecipItaly(framecounter,1)=rainTotItaly;
% Next with Abruzzo Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5AbruzzoProvinceMask;
    rainTotAbruzzo=sum(sum(rainTotArray));
    TotPrecipAbruzzo(framecounter,1)=rainTotAbruzzo;
% Next with Apulia Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5ApuliaProvinceMask;
    rainTotApulia=sum(sum(rainTotArray));
    TotPrecipApulia(framecounter,1)=rainTotApulia;
% Next with Basilicata Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5BasilicataProvinceMask;
    rainTotBasilicata=sum(sum(rainTotArray));
    TotPrecipBasilicata(framecounter,1)=rainTotBasilicata;
% Next with Calabria Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5CalabriaProvinceMask;
    rainTotCalabria=sum(sum(rainTotArray));
    TotPrecipCalabria(framecounter,1)=rainTotCalabria;
% Next with Campania Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5CampaniaProvinceMask;
    rainTotCampania=sum(sum(rainTotArray));
    TotPrecipCampania(framecounter,1)=rainTotCampania;
% Next with Emilia Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5EmiliaProvinceMask;
    rainTotEmilia=sum(sum(rainTotArray));
    TotPrecipEmilia(framecounter,1)=rainTotEmilia;
% Next with Friuli Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5FriuliProvinceMask;
    rainTotFriuli=sum(sum(rainTotArray));
    TotPrecipFriuli(framecounter,1)=rainTotFriuli;
% Next with Lazio Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5LazioProvinceMask;
    rainTotLazio=sum(sum(rainTotArray));
    TotPrecipLazio(framecounter,1)=rainTotLazio;
% Next with Liguria Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5LiguriaProvinceMask;
    rainTotLiguria=sum(sum(rainTotArray));
    TotPrecipLiguria(framecounter,1)=rainTotLiguria;
% Next with Lombardia Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5LombardiaProvinceMask;
    rainTotLombardia=sum(sum(rainTotArray));
    TotPrecipLombardia(framecounter,1)=rainTotLombardia;
% Next with Marche Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5MarcheProvinceMask;
    rainTotMarche=sum(sum(rainTotArray));
    TotPrecipMarche(framecounter,1)=rainTotMarche;
% Next with Molise Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5MoliseProvinceMask;
    rainTotMolise=sum(sum(rainTotArray));
    TotPrecipMolise(framecounter,1)=rainTotMolise;
% Next with Piemonte Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5PiemonteProvinceMask;
    rainTotPiemonte=sum(sum(rainTotArray));
    TotPrecipPiemonte(framecounter,1)=rainTotPiemonte;
% Next with Sardegna Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5SardegnaProvinceMask;
    rainTotSardegna=sum(sum(rainTotArray));
    TotPrecipSardegna(framecounter,1)=rainTotSardegna;
% Next with Sicily Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5SicilyProvinceMask;
    rainTotSicily=sum(sum(rainTotArray));
    TotPrecipSicily(framecounter,1)=rainTotSicily;
% Next with Toscana Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5ToscanaProvinceMask;
    rainTotToscana=sum(sum(rainTotArray));
    TotPrecipToscana(framecounter,1)=rainTotToscana;
% Next with Trentino Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5TrentinoProvinceMask;
    rainTotTrentino=sum(sum(rainTotArray));
    TotPrecipTrentino(framecounter,1)=rainTotTrentino;
% Next with Umbria Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5UmbriaProvinceMask;
    rainTotUmbria=sum(sum(rainTotArray));
    TotPrecipUmbria(framecounter,1)=rainTotUmbria;
% Next with Valla Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5VallaProvinceMask;
    rainTotValla=sum(sum(rainTotArray));
    TotPrecipValla(framecounter,1)=rainTotValla;
% Next with Veneto Province
    rainTotArray=TslicePrecip.*ItalyRasterAreas.*ERA5VenetoProvinceMask;
    rainTotVeneto=sum(sum(rainTotArray));
    TotPrecipVeneto(framecounter,1)=rainTotVeneto;

% Display One frame of Data
    itype=3;
    DisplayRainFall(itype,TslicePrecip,Tdmyhrminsec)
    dispstr=strcat('Finished processing frame-',num2str(n),'-of-',num2str(numRainFallFiles),'-total frames');
    disp(dispstr)
end % End Main Proceesing Loop
if(iMovie==1)
    close(vTemp);
end
% Generate table data
stime=datetime(yd,md,dd,hrd,mind,secd);
timestep=hours(1);
%% Create the The RainFallTable for Italy and the first 5 provinces
RainFallProv1Table=table(TotPrecipItaly(:,1),TotPrecipAbruzzo(:,1),TotPrecipApulia(:,1),TotPrecipBasilicata(:,1),...
    TotPrecipCalabria(:,1),TotPrecipCampania(:,1),...
    'VariableNames',{'Italy','Abruzzo','Apulia',...
     'Basilicata','Calabria','Campania'});
RainFallProv1TT = table2timetable( RainFallProv1Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RainFallProv1Table RainFallProv1TT';
MatFileName=strcat('RainFallProv1Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created RainFallProv1TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(1));
fprintf(fid,'%s\n',silstr);
%% Now Plot This
titlestr='ItalyRainFall-Province-Group-1';
ikind=1;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5RainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create the The RainFallTable for Italy and the second 5 provinces
RainFallProv2Table=table(TotPrecipItaly(:,1),TotPrecipEmilia(:,1),TotPrecipFriuli(:,1),TotPrecipLazio(:,1),...
    TotPrecipLiguria(:,1),TotPrecipLombardia(:,1),...
    'VariableNames',{'Italy','Emilia','Friuli',...
     'Lazio','Liguria','Lombardia'});
RainFallProv2TT = table2timetable( RainFallProv2Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RainFallProv2Table RainFallProv2TT';
MatFileName=strcat('RainFallProv2Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created RainFallProv2TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(2));
fprintf(fid,'%s\n',silstr);
%% Now Plot This
titlestr='ItalyRainFall-Province-Group-2';
ikind=2;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5RainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create the The RainFallTable for Italy and the third 5 provinces
RainFallProv3Table=table(TotPrecipItaly(:,1),TotPrecipMarche(:,1),TotPrecipMolise(:,1),TotPrecipPiemonte(:,1),...
    TotPrecipSardegna(:,1),TotPrecipSicily(:,1),...
    'VariableNames',{'Italy','Marche','Molise',...
     'Piemonte','Sardegna','Sicily'});
RainFallProv3TT = table2timetable( RainFallProv3Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RainFallProv3Table RainFallProv3TT';
MatFileName=strcat('RainFallProv3Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created RainFallProv3TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(3));
fprintf(fid,'%s\n',silstr);
%% Now Plot This
titlestr='ItalyRainFall-Province-Group-3';
ikind=3;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5RainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Create the The RainFallTable for Italy and the fourth 5 provinces
RainFallProv4Table=table(TotPrecipItaly(:,1),TotPrecipToscana(:,1),TotPrecipTrentino(:,1),TotPrecipUmbria(:,1),...
    TotPrecipValla(:,1),TotPrecipVeneto(:,1),...
    'VariableNames',{'Italy','Toscana','Trentino',...
     'Umbria','Valla','Veneto'});
RainFallProv4TT = table2timetable( RainFallProv4Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RainFallProv4Table RainFallProv4TT';
MatFileName=strcat('RainFallProv4Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created RainFallProv4TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(4));
fprintf(fid,'%s\n',silstr);
%% Now Plot This
titlestr='ItalyRainFall-Province-Group-4';
ikind=4;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotERA5RainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Start changing the Hourly RainFall Tables to Daily Rain Tables
%% Load an Hourly Rain Fall Table For Province 1
eval(['cd ' tablepath(1:length(tablepath)-1)]);
%load('RainFallProv1Table-1980--Hourly4344Fr.mat');
numrec=height(RainFallProv1TT);
numUnique=0;
uniqueDates=cell(1,1);
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv1TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        numUnique=numUnique+1;
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        uniqueDates{numUnique,1}=MMMYYYYDD;
    end
end
DayRecords=zeros(numUnique,2);
idayRec=0;
% Now make another pass to get the record break points
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv1TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        idayRec=idayRec+1;
        DayRecords(idayRec,1)=n;
        ab=1;
    elseif(str1len>=13)
        str1=RainFallProv1TT.Time(n);
        str2=char(str1);
        str3=str2(13:14);
        hour=str2double(str3);
        if(hour==23)
             DayRecords(idayRec,2)=n;
        end
    end
end
DayTotals=zeros(idayRec,6);
for i=1:idayRec% Loop over all the days
    RainSubTotals=zeros(24,6);
    is=DayRecords(i,1);
    ie=DayRecords(i,2);
    for j=is:ie
        for m=1:6 %Loop of the 6 Columns of data
            if(m==1)
                currValue=RainFallProv1TT.Italy(j);
            elseif(m==2)
                currValue=RainFallProv1TT.Abruzzo(j);
            elseif(m==3)
                currValue=RainFallProv1TT.Apulia(j);
            elseif(m==4)
                currValue=RainFallProv1TT.Basilicata(j);
            elseif(m==5)
                currValue=RainFallProv1TT.Calabria(j);
            elseif(m==6)
                currValue=RainFallProv1TT.Campania(j);
            end
            if(j<=24)
                jx=j;
            else
                jx=mod(j,24);
                if(jx==0)
                    jx=24;
                end
            end
            RainSubTotals(jx,m)=RainSubTotals(jx,m)+currValue;
        end        
    end% Sum over the 24 hours
    DayTotals(i,1)=sum(RainSubTotals(1:24,1));
    DayTotals(i,2)=sum(RainSubTotals(1:24,2));
    DayTotals(i,3)=sum(RainSubTotals(1:24,3));
    DayTotals(i,4)=sum(RainSubTotals(1:24,4));
    DayTotals(i,5)=sum(RainSubTotals(1:24,5));
    DayTotals(i,6)=sum(RainSubTotals(1:24,6));
end
% yd=1981;
% md=1;
% dd=1;
yd=yrs;
md=mds;
dd=ds;
stime=datetime(yd,md,dd);
timestep=caldays(1);
%% Create the The Daily RainFallTable for Italy and the first 5 provinces
DailyRainFallProv1Table=table(DayTotals(:,1),DayTotals(:,2),DayTotals(:,3),DayTotals(:,4),...
    DayTotals(:,5),DayTotals(:,6),...
    'VariableNames',{'Italy','Abruzzo','Apulia','Basilicata','Calabria','Campania'});
DailyRainFallProv1TT = table2timetable( DailyRainFallProv1Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallProv1Table DailyRainFallProv1TT';
%MatFileName=strcat('HourlyRainFallProv1Table','-1980-','-Hourly-For-Month',num2str(md),'-Month'.mat');
MatFileName=strcat('HourlyRainFallProv1Table','-',num2str(yd),'-Month-',num2str(md),'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created RainFallProv1TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(1));
fprintf(fid,'%s\n',silstr);
%% Plot the Province 1 Data
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
titlestr='Daily RainFall Accumilation For Province Group 1';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])

% Plot the Daily RainFall Accumilation for Italy and the Prov1 counties
plot(DailyRainFallProv1TT.Time,(DailyRainFallProv1TT.Italy)/5,'b',DailyRainFallProv1TT.Time,DailyRainFallProv1TT.Abruzzo,'g',...
    DailyRainFallProv1TT.Time,DailyRainFallProv1TT.Apulia,'k',DailyRainFallProv1TT.Time,DailyRainFallProv1TT.Basilicata,'r',...
    DailyRainFallProv1TT.Time,DailyRainFallProv1TT.Calabria,'c',DailyRainFallProv1TT.Time,DailyRainFallProv1TT.Campania,'r+');
hl=legend('Italy/5','Abruzzo','Apulia','Basilicata','Calabria','Campania');
xlabel('Date','FontWeight','bold','FontSize',12);
ylabel('DailyRainfall Acumilation-kg/m^2','FontWeight','bold','FontSize',12);
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
% Add a logo
framecounter=1;
if((iLogo==1) && (framecounter==1))
   eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
   [xlogo, ~]=imread(LogoFileName1);
   numcalled=1;
end
if(iLogo==1)
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.09, .16,.08,]);
    imshow(xlogo);
    set(ha2,'handlevisibility','off','visible','off')
end
pause(5)
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat('Italy-Prov1-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 1')
%% Load an Hourly Rain Fall Table For Province 2
eval(['cd ' tablepath(1:length(tablepath)-1)]);
%load('RainFallProv2Table-1980--Hourly4344Fr.mat');
numrec=height(RainFallProv2TT);
numUnique=0;
uniqueDates=cell(1,1);
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv2TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        numUnique=numUnique+1;
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        uniqueDates{numUnique,1}=MMMYYYYDD;
        ab=1;
    end

end
DayRecords=zeros(numUnique,2);
idayRec=0;
% Now make another pass to get the record break points
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv2TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        idayRec=idayRec+1;
        DayRecords(idayRec,1)=n;
    elseif(str1len>=13)
        str1=RainFallProv2TT.Time(n);
        str2=char(str1);
        str3=str2(13:14);
        hour=str2double(str3);
        if(hour==23)
             DayRecords(idayRec,2)=n;
        end
    end

end
DayTotals=zeros(idayRec,6);
for i=1:idayRec % Loop over all the days
    RainSubTotals=zeros(24,6);
    is=DayRecords(i,1);
    ie=DayRecords(i,2);
    for j=is:ie
        for m=1:6 %Loop of the 6 Columns of data
            if(m==1)
                currValue=RainFallProv2TT.Italy(j);
            elseif(m==2)
                currValue=RainFallProv2TT.Emilia(j);
            elseif(m==3)
                currValue=RainFallProv2TT.Friuli(j);
            elseif(m==4)
                currValue=RainFallProv2TT.Lazio(j);
            elseif(m==5)
                currValue=RainFallProv2TT.Liguria(j);
            elseif(m==6)
                currValue=RainFallProv2TT.Lombardia(j);
            end
            if(j<=24)
                jx=j;
            else
                jx=mod(j,24);
                if(jx==0)
                    jx=24;
                end
            end
            RainSubTotals(jx,m)=RainSubTotals(jx,m)+currValue;
        end
        
    end% Sum over the 24 hours
    DayTotals(i,1)=sum(RainSubTotals(1:24,1));
    DayTotals(i,2)=sum(RainSubTotals(1:24,2));
    DayTotals(i,3)=sum(RainSubTotals(1:24,3));
    DayTotals(i,4)=sum(RainSubTotals(1:24,4));
    DayTotals(i,5)=sum(RainSubTotals(1:24,5));
    DayTotals(i,6)=sum(RainSubTotals(1:24,6));
end
yd=yrs;
md=mds;
dd=ds;
stime=datetime(yd,md,dd);
timestep=caldays(1);

%% Create the The DailyRainFallTable for Italy and the second 5 provinces
DailyRainFallProv2Table=table(DayTotals(:,1),DayTotals(:,2),DayTotals(:,3),DayTotals(:,4),...
    DayTotals(:,5),DayTotals(:,6),...
    'VariableNames',{'Italy','Emilia','Friuli',...
     'Lazio','Liguria','Lombardia'});
DailyRainFallProv2TT = table2timetable( DailyRainFallProv2Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallProv2Table DailyRainFallProv2TT';
%MatFileName=strcat('DailyRainFallProv2Table','-1980-','-Hourly','.mat');
MatFileName=strcat('HourlyRainFallProv2Table','-',num2str(yd),'-Month-',num2str(md),'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallProv2TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(2));
fprintf(fid,'%s\n',silstr);
%% Plot the Province 2 Data
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
titlestr='Daily RainFall Accumilation For Province Group 2';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
% Plot the Daily RainFall Accumilation for Italy and the Prov1 counties
plot(DailyRainFallProv2TT.Time,(DailyRainFallProv2TT.Italy)/5,'b',DailyRainFallProv2TT.Time,DailyRainFallProv2TT.Emilia,'g',...
    DailyRainFallProv2TT.Time,DailyRainFallProv2TT.Friuli,'k',DailyRainFallProv2TT.Time,DailyRainFallProv2TT.Lazio,'r',...
    DailyRainFallProv2TT.Time,DailyRainFallProv2TT.Liguria,'c',DailyRainFallProv2TT.Time,DailyRainFallProv2TT.Lombardia,'r+');
hl=legend('Italy/5','Emilia','Friuli','Lazio','Liguria','Lombardia');
xlabel('Date','FontWeight','bold','FontSize',12);
ylabel('DailyRainfall Acumilation-kg/m^2','FontWeight','bold','FontSize',12);
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
% Add a logo
framecounter=1;
if((iLogo==1) && (framecounter==1))
   eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
   [xlogo, ~]=imread(LogoFileName1);
   numcalled=1;
end
if(iLogo==1)
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.09, .16,.08,]);
    imshow(xlogo);
    set(ha2,'handlevisibility','off','visible','off')
end
pause(5)
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat('Italy-Prov2-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 2')
%% Load an Hourly Rain Fall Table For Province 3
eval(['cd ' tablepath(1:length(tablepath)-1)]);
%load('RainFallProv3Table-1980--Hourly4344Fr.mat');
numrec=height(RainFallProv3TT);
ab=1;
numUnique=0;
uniqueDates=cell(1,1);
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv3TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        numUnique=numUnique+1;
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        uniqueDates{numUnique,1}=MMMYYYYDD;
    end
end
DayRecords=zeros(numUnique,2);
idayRec=0;
% Now make another pass to get the record break points
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv3TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        idayRec=idayRec+1;
        DayRecords(idayRec,1)=n;
    elseif(str1len>=13)
        str1=RainFallProv3TT.Time(n);
        str2=char(str1);
        str3=str2(13:14);
        hour=str2double(str3);
        if(hour==23)
             DayRecords(idayRec,2)=n;
        end
    end

end
DayTotals=zeros(idayRec,6);
for i=1:idayRec % Loop over all the days
    RainSubTotals=zeros(24,6);
    is=DayRecords(i,1);
    ie=DayRecords(i,2);
    for j=is:ie
        for m=1:6 %Loop of the 6 Columns of data
            if(m==1)
                currValue=RainFallProv3TT.Italy(j);
            elseif(m==2)
                currValue=RainFallProv3TT.Marche(j);
            elseif(m==3)
                currValue=RainFallProv3TT.Molise(j);
            elseif(m==4)
                currValue=RainFallProv3TT.Piemonte(j);
            elseif(m==5)
                currValue=RainFallProv3TT.Sardegna(j);
            elseif(m==6)
                currValue=RainFallProv3TT.Sicily(j);
            end
            if(j<=24)
                jx=j;
            else
                jx=mod(j,24);
                if(jx==0)
                    jx=24;
                end
            end
            RainSubTotals(jx,m)=RainSubTotals(jx,m)+currValue;
        end
        
    end% Sum over the 24 hours
    DayTotals(i,1)=sum(RainSubTotals(1:24,1));
    DayTotals(i,2)=sum(RainSubTotals(1:24,2));
    DayTotals(i,3)=sum(RainSubTotals(1:24,3));
    DayTotals(i,4)=sum(RainSubTotals(1:24,4));
    DayTotals(i,5)=sum(RainSubTotals(1:24,5));
    DayTotals(i,6)=sum(RainSubTotals(1:24,6));
end
yd=yrs;
md=mds;
dd=ds;
stime=datetime(yd,md,dd);
timestep=caldays(1);
%% Create the The DailyRainFallTable for Italy and the third 5 provinces
DailyRainFallProv3Table=table(DayTotals(:,1),DayTotals(:,2),DayTotals(:,3),DayTotals(:,4),...
    DayTotals(:,5),DayTotals(:,6),...
    'VariableNames',{'Italy','Marche','Molise',...
     'Piemonte','Sardegna','Sicily'});
DailyRainFallProv3TT = table2timetable( DailyRainFallProv3Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallProv3Table DailyRainFallProv3TT';
%MatFileName=strcat('DailyRainFallProv3Table','-1980-','-Hourly','.mat');
MatFileName=strcat('HourlyRainFallProv3Table','-',num2str(yd),'-Month-',num2str(md),'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallProv3TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(3));
fprintf(fid,'%s\n',silstr);
%% Plot the Province 3 Data
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
titlestr='Daily RainFall Accumilation For Province Group 3';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
% Plot the Daily RainFall Accumilation for Italy and the Prov1 counties
plot(DailyRainFallProv3TT.Time,(DailyRainFallProv3TT.Italy)/5,'b',DailyRainFallProv3TT.Time,DailyRainFallProv3TT.Marche,'g',...
    DailyRainFallProv3TT.Time,DailyRainFallProv3TT.Molise,'k',DailyRainFallProv3TT.Time,DailyRainFallProv3TT.Piemonte,'r',...
    DailyRainFallProv3TT.Time,DailyRainFallProv3TT.Sardegna,'c',DailyRainFallProv3TT.Time,DailyRainFallProv3TT.Sicily,'r+');
hl=legend('Italy/5','Marche','Molise','Piemonte','Sardegna','Sicily');
xlabel('Date','FontWeight','bold','FontSize',12);
ylabel('DailyRainfall Acumilation-kg/m^2','FontWeight','bold','FontSize',12);
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
% Add a logo
framecounter=1;
if((iLogo==1) && (framecounter==1))
   eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
   [xlogo, ~]=imread(LogoFileName1);
   numcalled=1;
end
if(iLogo==1)
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.09, .16,.08,]);
    imshow(xlogo);
    set(ha2,'handlevisibility','off','visible','off')
end
pause(5)
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat('Italy-Prov3-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 3')
%% Load an Hourly Rain Fall Table For Province 4
eval(['cd ' tablepath(1:length(tablepath)-1)]);
numrec=height(RainFallProv4TT);
numUnique=0;
uniqueDates=cell(1,1);
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv4TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        numUnique=numUnique+1;
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        uniqueDates{numUnique,1}=MMMYYYYDD;
    end

end
DayRecords=zeros(numUnique,2);
idayRec=0;
% Now make another pass to get the record break points
% Now march through the table to find the unique Dates
for n=1:numrec
    str1=char(RainFallProv4TT.Time(n));
    str1len=length(str1);
    if(str1len<13)
        dd=str1(1:2);
        mm=str1(4:6);
        yr=str1(8:11);
        MMMYYYYDD=strcat(mm,'-',dd,'-',yr);
        idayRec=idayRec+1;
        DayRecords(idayRec,1)=n;
    elseif(str1len>=13)
        str1=RainFallProv4TT.Time(n);
        str2=char(str1);
        str3=str2(13:14);
        hour=str2double(str3);
        if(hour==23)
             DayRecords(idayRec,2)=n;
        end
    end

end
DayTotals=zeros(idayRec,6);
for i=1:idayRec % Loop over all the days
    RainSubTotals=zeros(24,6);
    is=DayRecords(i,1);
    ie=DayRecords(i,2);
    for j=is:ie
        for m=1:6 %Loop of the 6 Columns of data
            if(m==1)
                currValue=RainFallProv4TT.Italy(j);
            elseif(m==2)
                currValue=RainFallProv4TT.Toscana(j);
            elseif(m==3)
                currValue=RainFallProv4TT.Trentino(j);
            elseif(m==4)
                currValue=RainFallProv4TT.Umbria(j);
            elseif(m==5)
                currValue=RainFallProv4TT.Valla(j);
            elseif(m==6)
                currValue=RainFallProv4TT.Veneto(j);
            end
            if(j<=24)
                jx=j;
            else
                jx=mod(j,24);
                if(jx==0)
                    jx=24;
                end
            end
            RainSubTotals(jx,m)=RainSubTotals(jx,m)+currValue;
        end        
    end% Sum over the 24 hours
    DayTotals(i,1)=sum(RainSubTotals(1:24,1));
    DayTotals(i,2)=sum(RainSubTotals(1:24,2));
    DayTotals(i,3)=sum(RainSubTotals(1:24,3));
    DayTotals(i,4)=sum(RainSubTotals(1:24,4));
    DayTotals(i,5)=sum(RainSubTotals(1:24,5));
    DayTotals(i,6)=sum(RainSubTotals(1:24,6));
end
yd=yrs;
md=mds;
dd=ds;
stime=datetime(yd,md,dd);
timestep=caldays(1);

%% Create the The DailyRainFallTable for Italy and the fourth 5 provinces
DailyRainFallProv4Table=table(DayTotals(:,1),DayTotals(:,2),DayTotals(:,3),DayTotals(:,4),...
    DayTotals(:,5),DayTotals(:,6),...
    'VariableNames',{'Italy','Toscana','Trentino',...
     'Umbria','Valla','Veneto'});
DailyRainFallProv4TT = table2timetable(DailyRainFallProv4Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallProv4Table DailyRainFallProv4TT';
%MatFileName=strcat('DailyRainFallProv4Table','-1980-','-Hourly','.mat');
MatFileName=strcat('HourlyRainFallProv4Table','-',num2str(yd),'-Month-',num2str(md),'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallProv4TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(4));
fprintf(fid,'%s\n',silstr);
%% Plot the Province 4 Data
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
titlestr='Daily RainFall Accumilation For Province Group 4';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
% Plot the Daily RainFall Accumilation for Italy and the Prov4 counties
plot(DailyRainFallProv4TT.Time,(DailyRainFallProv4TT.Italy)/5,'b',DailyRainFallProv4TT.Time,DailyRainFallProv4TT.Toscana,'g',...
    DailyRainFallProv4TT.Time,DailyRainFallProv4TT.Trentino,'k',DailyRainFallProv4TT.Time,DailyRainFallProv4TT.Umbria,'r',...
    DailyRainFallProv4TT.Time,DailyRainFallProv4TT.Valla,'c',DailyRainFallProv4TT.Time,DailyRainFallProv4TT.Veneto,'r+');
hl=legend('Italy/5','Toscana','Trentino','Umbria','Valla','Veneto');
xlabel('Date','FontWeight','bold','FontSize',12);
ylabel('DailyRainfall Acumilation-kg/m^2','FontWeight','bold','FontSize',12);
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
ab=1;
% Add a logo
framecounter=1;
if((iLogo==1) && (framecounter==1))
   eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
   [xlogo, ~]=imread(LogoFileName1);
   numcalled=1;
end
if(iLogo==1)
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.09, .16,.08,]);
    imshow(xlogo);
    set(ha2,'handlevisibility','off','visible','off')
end
pause(5)
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat('Italy-Prov4-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 4')
ab=1;
%% Now put some summary data based on the daily rainfall data
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
% Rank the data so that the highest weighted rainfall is displayed first
[SortedRank,ind]=sort(RankOverData,'descend');
ProvCat=categorical({char(ProvinceNames(ind(1))), char(ProvinceNames(ind(2))),...
   char(ProvinceNames(ind(3))),char(ProvinceNames(ind(4))),...
   char(ProvinceNames(ind(5))),char(ProvinceNames(ind(6))),...
   char(ProvinceNames(ind(7))),char(ProvinceNames(ind(8))),...
   char(ProvinceNames(ind(9))),char(ProvinceNames(ind(10))),char(ProvinceNames(ind(11))),...
   char(ProvinceNames(ind(12))),char(ProvinceNames(ind(13))),char(ProvinceNames(ind(14))),...
   char(ProvinceNames(ind(15))),char(ProvinceNames(ind(16))),char(ProvinceNames(ind(17))),...
   char(ProvinceNames(ind(18))),char(ProvinceNames(ind(19))),char(ProvinceNames(ind(20)))});

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
b=bar(ProvCat,SortedRank,'g');
grid on
%set(b.CData(7,:)) = [1 0 0];% Not working
ax=gca;
ax.XTickLabelRotation = 75;
ylabel('Scaled Rain Fall-inches')
ht=title('Scaled RainFall In Inches For 20 Italian Provinces');
figstr='ItalyScaledRainfallByProvince.jpg';
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
close('all');
% Now look at the ranking by data
ProvinceAvgRainFallRank=zeros(20,1);
for n=1:20
    avgRank=mean(RankByDate(:,n));
    ProvinceAvgRainFallRank(n,1)=avgRank;
end
% Now print these provinces in descending Rank Order 
fprintf(fid,'%s\n','----- Province List in Descending Rank Order------')
[SortedRankOrder,ind]=sort(RankOverData,'ascend');
for k=1:20
    indx=ind(k);
    nowRank=k;
    nowRankScore=SortedRankOrder(k);
    nowProvince=ProvinceNames{indx,1};
    fprintf(fid,'%d    %8.2f      %s\n',nowRank,nowRankScore,nowProvince);
    dispstr=strcat('nowRank-',num2str(nowRank),'-nowRankScore-',num2str(nowRankScore,4),...
        '=Province-',nowProvince);
    disp(dispstr)
end
fprintf(fid,'%s\n','----- End Province List in Descending Rank Order------')
%% Now start creating the Daily RainFall Movie
% First get the available Files
dailyfilepath='D:\Joydeb\Daily_Files\';
namelen=length(dailyfilepath);
is=1;
ie=namelen-1;
topDir=dailyfilepath(is:ie);
[ LongFileList ] = getfilelist(topDir,'DailyAcumil.mat',1 );
numRainFallFiles=length(LongFileList);

for k=1:numRainFallFiles
    [filepath,name,ext] = fileparts(LongFileList{k,1});
    FileList{k,1}=strcat(name,'.mat');
end
[DailyRainFallFiles] = SortDailyFilesInTimeOrder(FileList);
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
    TempMovieName=strcat('ItalyDailyRainFallTotalsRev8-',num2str(numRainFallFiles));
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
%% Closeout Activities
elapsed_time=toc;
dispstr=strcat('Processing-',num2str(numRainFallFiles),'-took-',num2str(elapsed_time),'-seconds');
disp(dispstr)
fprintf(fid,'%s\n',dispstr);
fclose(fid);

