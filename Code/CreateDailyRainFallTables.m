% This script will read the Italy Rainfall
% The data for this set is contained in one enourmous 6 Gb file
%
% Written By: Stephen Forczyk
% Created: April 6,2024
% Revised:
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
global VenetoProvinceLat VenetoProvinceLon AbruzzoProvinceLat AbruzzoProvinceLon;
global ApuliaProvinceLat ApuliaProvinceLon BasilicataProvinceLat BasilicataProvinceLon;
global CalabriaProvinceLat CalabriaProvinceLon CampaniaProvinceLat CampaniaProvinceLon ;
global EmiliaProvinceLat EmiliaProvinceLon FriuliProvinceLat FriuliProvinceLon;
global LazioProvinceLat LazioProvinceLon LiguriaProvinceLat LiguriaProvinceLon;
global LombardiaProvinceLat LombardiaProvinceLon MarcheProvinceLat MarcheProvinceLon;
global MoliseProvinceLat MoliseProvinceLon PiemonteProvinceLat PiemonteProvinceLon;
global SardegnaProvinceLat SardegnaProvinceLon SicilyProvinceLat SicilyProvinceLon;
global ToscanaProvinceLat ToscanaProvinceLon TrentinoProvinceLat TrentinoProvinceLon;
global UmbriaProvinceLat UmbriaProvinceLon VallaProvinceLat VallaProvinceLon;

global ERA5ItalyMask ERA5VenetoProvinceMask ERA5AbruzzoProvinceMask ERA5ApuliaProvinceMask;
global ERA5BasilicataProvinceMask ERA5CalabriaProvinceMask ERA5CampaniaProvinceMask;
global ERA5EmiliaProvinceMask ERA5FriuliProvinceMask ERA5LazioProvinceMask ERA5LiguriaProvinceMask;
global ERA5LombardiaProvinceMask ERA5MarcheProvinceMask ERA5MoliseProvinceMask ERA5PiemonteProvinceMask;
global ERA5SardegnaProvinceMask ERA5SicilyProvinceMask ERA5ToscanaProvinceMask ERA5TrentinoProvinceMask;
global ERA5UmbriaProvinceMask ERA5VallaProvinceMask;
global RainFallProv1Table RainFallProv1TT RainFallProv2Table RainFallProv2TT;
global RainFallProv3Table RainFallProv3TT RainFallProv4Table RainFallProv4TT;
global DailyRainFallProv1Table DailyRainFallProv1TT;
global DailyRainFallProv2Table DailyRainFallProv2TT;
global DailyRainFallProv3Table DailyRainFallProv3TT;
global DailyRainFallProv4Table DailyRainFallProv4TT;



global TotPrecipItaly TotPrecipAbruzzo TotPrecipApulia TotPrecipBasilicata;
global TotPrecipCalabria TotPrecipCampania TotPrecipEmilia TotPrecipFriuli;
global TotPrecipLazio TotPrecipLiguria TotPrecipLombardia TotPrecipMarche;
global TotPrecipMolise TotPrecipPiemonte TotPrecipSardegna TotPrecipSicily;
global TotPrecipToscana TotPrecipTrentino TotPrecipUmbria TotPrecipValla TotPrecipVeneto;
global startindex endindex;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch


global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath;
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
%% Load an Hourly Rain Fall Tablen For Province 1
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load('RainFallProv1Table-1980--Hourly4344Fr.mat');
numrec=height(RainFallProv1TT);
ab=1;
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
        ab=1;
    end

end
ab=2;
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
    ab=5;
end
yd=1981;
md=1;
dd=1;
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
MatFileName=strcat('DailyRainFallProv1Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
% silstr=strcat('Created RainFallProv2TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(2));
% fprintf(fid,'%s\n',silstr);
ab=7;
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
figstr=strcat('Italy-Prov1-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 1')
ab=8;
%% Load an Hourly Rain Fall Table For Province 2
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load('RainFallProv2Table-1980--Hourly4344Fr.mat');
numrec=height(RainFallProv2TT);
ab=1;
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
ab=2;
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
    ab=5;
end
ab=6;
yd=1981;
md=1;
dd=1;
stime=datetime(yd,md,dd);
timestep=caldays(1);

%% Create the The RainFallTable for Italy and the second 5 provinces
DailyRainFallProv2Table=table(DayTotals(:,1),DayTotals(:,2),DayTotals(:,3),DayTotals(:,4),...
    DayTotals(:,5),DayTotals(:,6),...
    'VariableNames',{'Italy','Emilia','Friuli',...
     'Lazio','Liguria','Lombardia'});
DailyRainFallProv2TT = table2timetable( DailyRainFallProv2Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallProv2Table DailyRainFallProv2TT';
MatFileName=strcat('DailyRainFallProv2Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallProv2TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(2));
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
figstr=strcat('Italy-Prov2-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 2')
close('all');

%% Load an Hourly Rain Fall Table For Province 3
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load('RainFallProv3Table-1980--Hourly4344Fr.mat');
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
        ab=1;
    end

end
ab=2;
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
    ab=5;
end
yd=1981;
md=1;
dd=1;
stime=datetime(yd,md,dd);
timestep=caldays(1);

%% Create the The RainFallTable for Italy and the second 3 provinces
DailyRainFallProv3Table=table(DayTotals(:,1),DayTotals(:,2),DayTotals(:,3),DayTotals(:,4),...
    DayTotals(:,5),DayTotals(:,6),...
    'VariableNames',{'Italy','Marche','Molise',...
     'Piemonte','Sardegna','Sicily'});
DailyRainFallProv3TT = table2timetable( DailyRainFallProv3Table,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='DailyRainFallProv3Table DailyRainFallProv3TT';
MatFileName=strcat('DailyRainFallProv3Table','-1980-','-Hourly','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
silstr=strcat('Created DailyRainFallProv3TT-','Contains Rainfall data for Italy and 5 Provinces-',num2str(3));
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
figstr=strcat('Italy-Prov3-Daily-RainFall','.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
disp('Saved Daily Rain Fall Charts For Province Group 3')
close('all');