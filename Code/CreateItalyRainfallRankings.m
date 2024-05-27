% This script will create plots of selected rainfall data for Italy.
% This a test script and the code here is meant to be added to the script
% Create DailyRainFall Movie
%
% Written By: Stephen Forczyk
% Created: April 27,2024
% Revised:
% Classification: Unclassified/Public Domain
global ItalyRainFallFile ItalyProvinceRankFile;
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
global ProvinceRainFallRankedData ProvinceAvgRainFallRank;


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
ItalyProvinceRankFile='RankedRainFallStats.mat';
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
startrunstr=strcat('Start Create RainFall Rankings Run at-',startruntime);
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
% Load the Ranked Rain Fall Data
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
load(ItalyProvinceRankFile);
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
% X = reordercats(ProvCat,{char(ProvinceNames(ind(1))),char(ProvinceNames(ind(2))),char(ProvinceNames(ind(3))),...
%     char(ProvinceNames(ind(4))),char(ProvinceNames(ind(5))),...
%     char(ProvinceNames(ind(6))),char(ProvinceNames(ind(7))),char(ProvinceNames(ind(8))),...
%     char(ProvinceNames(ind(9))),char(ProvinceNames(ind(10))),char(ProvinceNames(ind(11))),...
%     char(ProvinceNames(ind(12))),char(ProvinceNames(ind(13))),char(ProvinceNames(ind(14))),
%     char(ProvinceNames(ind(15))),char(ProvinceNames(ind(16))),char(ProvinceNames(ind(17))),...
%     char(ProvinceNames(ind(18))),char(ProvinceNames(ind(19))),char(ProvinceNames(ind(20)))});
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
% Print these province is Rank Order

fclose(fid);

ab=1;