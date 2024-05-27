function  DisplayRainFall(itype,TslicePrecip,Tdmyhrminsec)
% Display the RainFall Accumilation
% Written By: Stephen Forczyk
% Created: Apr 06,2024
% Revised: 
% Classification: Unclassified/Public Domain
global BandDataS MetaDataS framecounter;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons;
global numlat numlon Rpix latlim lonlim rasterSize;
global StatCompTimes StatValues;
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
% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     import mlreportgen.dom.*;
%     import mlreportgen.report.*;
% end
% StatValues(1,1)=val10;
% StatValues(2,1)=val20;
% StatValues(3,1)=val30;
% StatValues(4,1)=val40;
% StatsValues(5,1)=val50;
% StatValues(6,1)=val60;
% StatValues(7,1)=val70;
% StatValues(8,1)=val80;
% StatValues(9,1)=val90;
% StatValues(10,1)=val100;
% StatValues(11,1)=fraclow;
% StatValues(12,1)=frachigh;
% StatValues(13,1)=fracNaN;
val50=StatValues(5,1);
val90=StatValues(9,1);
val100=StatValues(10,1);
[nrows,ncols]=size(TslicePrecip);

%% Set Up titles and units
desc='RainFallAmount';
units='kg/m^2';
titlestr=strcat('RainFall For-',nowFile);
figstr=strcat(titlestr,'jpg');
descstr=strcat('Basic stats monthly follow for-',titlestr);
%% List of the needed shape files
Shapefile0Name='ITA_adm0.shp';
Shapefile1Name='ITA_adm1.shp';
Shapefile2Name='ITA_adm2.shp';
Shapefile3Name='ITA_adm3.shp';
Shapefile4Name='ItalyCities.shp';

ab=1;
%% Fetch the map limits
ikind=7;
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
%geolimits([20 40],[0 30])
%TslicePrecip(TslicePrecip==0)=-0.5;
TslicePrecip(TslicePrecip==0)=NaN;
%% Plot the Selected parameter on the map on the map
geoshow(TslicePrecip,Rpix,'DisplayType','texturemap');
maxval=20;
minval=-5;
maxval2=25;
incsize=(maxval-minval)/256;
demcmap('inc',[maxval minval],incsize);
hc = colorbar;
hc.Label.String = 'RainFallAccumilation';
ylabel(hc,units,'FontWeight','bold');
tightmap
hold on

% load the country borders from a single larger file and plot them
% a1=isempty(MexicoLat);
% if(a1==1)
% load the country borders and plot them-pull them all from the same file
% if they are not currently in memory
%     eval(['cd ' mappath(1:length(mappath)-1)]);
%     load('WorldMercatorBoundaries.mat');
% end
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
%patchesm(ItalyLats,ItalyLons,0,'r','FaceAlpha',.2);% Not happy with this
%patchesm(FranceLat,FranceLon,0.5,'FaceColor',beige,'FaceAlpha',.5);
%patchesm(SwitzerLandLat,SwitzerLandLon,0.5,'FaceColor',almond,'FaceAlpha',.5);
%patchesm(AustriaLat,AustriaLon,0.5,'FaceColor',beige,'FaceAlpha',.5);
%patchesm(SerbiaLat,SerbiaLon,0.5,'FaceColor',beige,'FaceAlpha',.5);
%patchesm(CroatiaLat,CroatiaLon,0.5,'FaceColor',almond,'FaceAlpha',.5);
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
% scalebarlen=500;
% scalebarloc='sw';
% scalebar('length',scalebarlen,'units','miles','color',bubblegum,'location',scalebarloc,'fontangle','bold','RulerStyle','patches');
gs1 = scaleruler('Units','km');
setm(gs1,'Color',[1 1 0],'Label','Dist-km','XLoc',-.1208,'YLoc',.6451,'RulerStyle','patches');
ab=1;
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
tx1=.10;
ty1=.08;
a=string(Tdmyhrminsec);
achar=char(a);
timestr=achar(1:19);
txtstr1=strcat('Time Period-',timestr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.10;
ty2=.05;
% conversion found on this source
% https://www.metric-conversions.org/pressure/kilogram-force-per-square-meter-to-inches-of-water.htm
maxdepth=val100*.039370;% this last number to depth of water in inches
txtstr2=strcat(desc,'-','50 ptile=',num2str(val50,6),'-90 ptile=',num2str(val90,6),...
    '-100 ptile=',num2str(val100,6),'-kg/m^2','-Max water depth=',num2str(maxdepth),'-in inches');
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
%endstr=strcat('------- Finished Plotting-',varname);
%fprintf(fid,'%s\n',endstr);
% if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
%     if(iNewChapter)
%         headingstr1=strcat('Analysis Results For-',Merra2ShortFileName);
%         chapter = Chapter("Title",headingstr1);
%     end
%     sectionstr=strcat(varname,'-Map');
%     add(chapter,Section(sectionstr));
%     imdata = imread(figstr);
%     [nhigh,nwid,~]=size(imdata);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which(figstr);
%     pdftxtstr=strcat(varname,' For File-',Merra2ShortFileName);
%     pdftext = Text(pdftxtstr);
%     pdftext.Color = 'red';
%     image.Caption = pdftext;
%     nhighs=floor(nhigh/2.5);
%     nwids=floor(nwid/2.5);
%     heightstr=strcat(num2str(nhighs),'px');
%     widthstr=strcat(num2str(nwids),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image);
% % Now add some text -start by decribing the with a basic description of the
% % variable being plotted
%     parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
%     parastr2=strcat(' This metric is a monthly average for-',varname,'.');
%     if(ikind==1)
%         parastr3='The valid data range for this dataset is from 0 to 1 and is dimensionless .';
%     elseif((ikind==14) || (ikind==15) || (ikind==18) || (ikind==20) || (ikind==21) || (ikind==22) || (ikind==28))
%         parastr3='The likely data range is likely 0-2000 w/m^2';
%     elseif((ikind==30) || (ikind==31) || (ikind==32) || (ikind==33))
%         parastr3='The likely data range is likely 0-2000 w/m^2';
%     elseif((ikind==34) || (ikind==35) || (ikind==36) || (ikind==37))
%         parastr3='The likely range of the optical thickness is 0-50 and is dimensionless';
%     elseif(ikind==39)
%         parastr3='The likely range of the optical thickness is 0-500 and is in Deg-K';
%     else
%         parastr3='unspecified';
%     end
% %     parastr4='Note that in the plot above a small constant was added to the AOD to insure all values>0 for plot purposes.';
% %     parastr5='AOD is a dimensionless parameter that describes the extinction properties of light in the visible band.';
% %     parastr6='A very clear atmosphere will have a value of .01,typical values are in the range of .10 and a very hazy atmosphere would be above 0.4.';
% %     parastr7=strcat('For the image above the AOD value range was=',num2str(AODmin,6),'-to-',num2str(AODmax,6),'.','The list below shows key requirements for this product.');
%     parastr9=strcat(parastr1,parastr2,parastr3);
%     p1 = Paragraph(parastr9);
%     p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p1);
%     if(iCloseChapter==1)
%         add(rpt,chapter);
%     end
% end
close('all');
end

