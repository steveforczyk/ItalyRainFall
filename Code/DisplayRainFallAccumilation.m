function  DisplayRainFallAccumilation(itype,DailyPrecip)
% Display the RainFall Accumilation. This was created by summing up the
% hourly rainfall data for each of 24 hours and converting kg/m^ to inches
% Written By: Stephen Forczyk
% Created: Apr 17,2024
% Revised: -----
% Classification: Unclassified/Public Domain
global BandDataS MetaDataS framecounter;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons;
global numlat numlon Rpix latlim lonlim rasterSize;
global StatCompTimes StatValues DateTimeHold;
global nowFile;

global westEdge eastEdge southEdge northEdge FillValue Rpix;
global vTemp TempMovieName iMovie iCityPlot;
global vTemp17 TempMovieName17;
global vTemp34 TempmovieName34;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global idebug iCityPlot World200TopCities maxCities framecounter;
global YearMonthStr YearStr MonthStr DayStr YearMonthDayStr FullTimeStr;
global iLogo LogoFileName1 LogoFileName2;

% additional paths needed for mapping
global matpath1 mappath govjpegpath;
global jpegpath savepath tiffpath;
global fid isavefiles iFastSave;
global vTemp TempMovieName iMovie;



global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath ;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global gridpath;
global matpath1 mappath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global govjpegpath;
global westEdge eastEdge northEdge southEdge;

global ItalyCityLats ItalyCityLons ItalyCityName;
global ItalyLats ItalyLons FranceLat FranceLon AustriaLat AustriaLon;
global SwitzerLandLat SwitzerLandLon SerbiaLat SerbiaLon CroatiaLat CroatiaLon;
global AlbaniaLat AlbaniaLon GreeceLat GreeceLon BosniaLat BoosniaLon;
global SloveniaLat SloveniaLon MontenegroLat MontenegroLon;
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
global AfricanCities numAfricanCities AfricanCitiesList;
global AustralianCities numAustralianCities AustralianCitiesList;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch;
persistent xlogo numcalled;

[nrows,ncols]=size(DailyPrecip);

%% Set Up titles and units
desc='DailyRainFallAmount';
units='inches/day';
titlestr=strcat('DailyRainFall-TotAccumilation-For-',nowFile);
figstr=strcat(titlestr,'jpg');
descstr=strcat('Basic stats monthly follow for-',titlestr);
ikind=1;
%% Fetch the map limits
if((framecounter==1) && (ikind==1))
    maplimitstr1='****Map Limits Follow*****';
    fprintf(fid,'%s\n',maplimitstr1);
    maplimitstr2=strcat('WestEdge=',num2str(westEdge,7),'-EastEdge=',num2str(eastEdge));
    fprintf(fid,'%s\n',maplimitstr2);
    maplimitstr3=strcat('SouthEdge=',num2str(southEdge,7),'-NorthEdge=',num2str(northEdge));
    fprintf(fid,'%s\n',maplimitstr3);
    maplimitstr4='****Map Limits End*****';
    fprintf(fid,'%s\n',maplimitstr4);
end
%% Set up the map axis
if(itype==1)
    axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
        'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
elseif(itype==2)
    axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',20,'mlabellocation',30,...
     'MLabelParallel','south');    
elseif(itype==3)
   h1= axesm('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',3,'mlabellocation',3,...
     'MLabelParallel','south','GColor',[1 0 0],'GLineWidth',2,'MLineLocation',3,'PLineLocation',3);
end
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
colormap jet
% Remove NaNs andf very low values from the plot
DailyPrecip(DailyPrecip==0)=NaN;
%% Plot the Selected parameter on the map on the map
geoshow(DailyPrecip,Rpix,'DisplayType','texturemap');
maxval=4;
minval=-2;
maxval2=25;
incsize=(maxval-minval)/256;
demcmap('inc',[maxval minval],incsize);
hc = colorbar;
hc.Label.String = 'RainFallAccumilation';
ylabel(hc,units,'FontWeight','bold');
tightmap
hold on

% Add the countrys to the map
plot3m(FranceLat,FranceLon,maxval2,'Color',beige);
plot3m(SwitzerLandLat,SwitzerLandLon,maxval2,'Color',almond);
plot3m(AustriaLat,AustriaLon,maxval2,'Color',beige);
plot3m(SerbiaLat,SerbiaLon,maxval2,'Color',almond)
plot3m(CroatiaLat,CroatiaLon,maxval2,'c--');
plot3m(SloveniaLat,SloveniaLon,maxval2,'Color',wheat);
plot3m(AlbaniaLat,AlbaniaLon,maxval2,'Color',butterscotch);
plot3m(MontenegroLat,MontenegroLon,maxval2,'Color',almond);
plot3m(GreeceLat,GreeceLon,maxval2,'Color',beige);
plot3m(ItalyLats,ItalyLons,maxval2,'r','Linewidth',2);
% plot3m(AbruzzoProvinceLat,AbruzzoProvinceLon,maxval2,'w');
% plot3m(ApuliaProvinceLat,ApuliaProvinceLon,maxval2,'w');
% plot3m(BasilicataProvinceLat,BasilicataProvinceLon,maxval2,'w');
% plot3m(CalabriaProvinceLat,CalabriaProvinceLon,maxval2,'w');
% plot3m(CampaniaProvinceLat,CampaniaProvinceLon,maxval2,'w');
% plot3m(EmiliaProvinceLat,EmiliaProvinceLon,maxval2,'w');
% plot3m(FriuliProvinceLat,FriuliProvinceLon,maxval2,'w');
% plot3m(LazioProvinceLat,LazioProvinceLon,maxval2,'w');
% plot3m(LiguriaProvinceLat,LiguriaProvinceLon,maxval2,'w');
% plot3m(LombardiaProvinceLat,LombardiaProvinceLon,maxval2,'w');
% plot3m(MarcheProvinceLat,MarcheProvinceLon,maxval2,'w');
% plot3m(MoliseProvinceLat,MoliseProvinceLon,maxval2,'w');
% plot3m(PiemonteProvinceLat,PiemonteProvinceLon,maxval2,'w');
% plot3m(SardegnaProvinceLat,SardegnaProvinceLon,maxval2,'w');
% plot3m(SicilyProvinceLat,SicilyProvinceLon,maxval2,'w');
% plot3m(ToscanaProvinceLat,ToscanaProvinceLon,maxval2,'w');
% plot3m(TrentinoProvinceLat,TrentinoProvinceLon,maxval2,'w');
% plot3m(UmbriaProvinceLat,UmbriaProvinceLon,maxval2,'w');
% plot3m(VallaProvinceLat,VallaProvinceLon,maxval2,'w');
plot3m(VenetoProvinceLat,VenetoProvinceLon,maxval2,'y');


%% Add Cities to the plot is desired
if(iCityPlot>0)
    maxCities=length(ItalyCityLats);
    for k=1:maxCities
        nowLat=ItalyCityLats(k,1);
        nowLon=ItalyCityLons(k,1);
        nowName=char(ItalyCityName(k,1));
        plot3m(nowLat,nowLon,11,'w+');
        textm(nowLat,nowLon+0.2,11,nowName,'Color','white','FontSize',8);
    end
end
title(titlestr)
hold off
% Put a distance scale on the chart

gs1 = scaleruler('Units','km');
setm(gs1,'Color',[1 1 0],'Label','Dist-km','XLoc',-.1208,'YLoc',.6451,'RulerStyle','patches');
% Add a logo
if((iLogo==1) && (framecounter==1))
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
   [xlogo, ~]=imread(LogoFileName1);
   numcalled=1;
end
if(iLogo==1)
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.08, .16,.08,]);
    imshow(xlogo);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
timestr=char(DateTimeHold);
[idash]=strfind(timestr,'-');
is=idash(1)+1;
ie=idash(2)-1;
MonthStr=timestr(is:ie);
is=idash(2)+1;
ie=is+3;
YearStr=timestr(is:ie);
is=1;
ie=idash(1)-1;
DayStr=timestr(is:ie);
FrameTime=strcat(MonthStr,'-',DayStr,'-',YearStr);
tx1=.10;
ty1=.08;
txtstr1=strcat('Time Period-',FrameTime);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.10;
ty2=.05;
% conversion found on this source
% https://www.metric-conversions.org/pressure/kilogram-force-per-square-meter-to-inches-of-water.htm
% maxdepth=val100*.039370;% this last number to depth of water in inches
txtstr2=strcat('Rain Accumil-','95 ptile=',num2str(StatValues(6,1),4),...
    '-98 ptile=',num2str(StatValues(8,1),4),'-inches');
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');

% Grab a movie frame
  if(iMovie==1)
    frame=getframe(gcf);
    writeVideo(vTemp,frame);
  end


% Save this chart
rem=mod(framecounter,20);
if((iFastSave==0)  && (rem==0))
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);
    close('all');
elseif(rem==0)
% Try a screencapture
    figstrlen=length(figstr);
    is=1;
    ie=figstrlen-4;
    tiffstub=figstr(is:ie);
    figstr2=strcat(tiffstub,'.tif');
    eval(['cd ' tiffpath(1:length(tiffpath)-1)]);
    screencapture('handle',gcf,'target',figstr2);
end
pause(chart_time);

close('all');
end

