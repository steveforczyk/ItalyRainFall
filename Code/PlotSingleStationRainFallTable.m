function PlotSingleStationRainFallTable(titlestr,ikind)
% This function is plots the the accumilated rainfall amounts recorded at a
% single station in units of mm/hr
% 

%
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 6,2024
% Revised: ----

% Classification: Unclassified/Public Domain

global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallFile3 RainFallFile3C
global RainFallTime RainFallFlag RainFallAmt RainFallName;
global ProvinceNames RainFallTime30 I30max;
global numtimesstep SelectedYears SelStartIndex SelEndIndex numused numedused30;
global firstyearstr firstyear firstdaystr firstday firstmonthstr;
global firsthrstr firsthr firstminstr firstmin firstsecstr firstsec;
global lastyearstr lastyear lastdaystr lastday lastmonthstr;
global lasthrstr lasthr lastminstr lastmin lastsecstr lastsec;
global FoundData icataloged eventctr;
global I30 SumRain30;
global RFactorTable RFactorTT;


global iLogo LogoFileName1 LogoFileName2;
global numtimeslice;
global iCityPlot maxCities;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;

global PascalsToMilliBars PascalsToPsi;
global numtimeslice TimeSlices;
global numlat numlon Rpix latlim lonlim rasterSize;
global yd md dd;

global matpath datapath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;

global shapefilepath Countryshapepath figpath pressurepath averaged1Daypath;
global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;

global pwd;
% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     import mlreportgen.dom.*;
%     import mlreportgen.report.*;
% end

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==1)
    plot(RFactorTT.Time,RFactorTT.Int30,'b');
    ylabel('I30 mm/hr','FontWeight','bold','FontSize',12);

elseif(ikind==2)
    plot(RFactorTT.Time,RFactorTT.I30max,'g');
    ylabel('Rainfall I30max mm/hr','FontWeight','bold','FontSize',12);

elseif(ikind==3)
    plot(RFactorTT.Time,RFactorTT.SUMKE30,'r');
%    hl=legend('Italy/5','Marche','Molise','Piemonte','Sardegna','Sicily');
    ylabel('Kinetic Enery 30 Min','FontWeight','bold','FontSize',12);
 

elseif(ikind==4)
    plot(RainFallProv4TT.Time,(RainFallProv4TT.Italy)/5,'b',RainFallProv4TT.Time,RainFallProv4TT.Toscana,'g',...
        RainFallProv4TT.Time,RainFallProv4TT.Trentino,'k',RainFallProv4TT.Time,RainFallProv4TT.Umbria,'r',...
        RainFallProv4TT.Time,RainFallProv4TT.Valla,'c',RainFallProv4TT.Time,RainFallProv4TT.Veneto,'r+');
    hl=legend('Italy/5','Toscsana','Trentino','Umbria','Valla','Veneto');
    ylabel('Rainfall Acumilation-kg','FontWeight','bold','FontSize',12);
 
end

set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
%Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat(titlestr,'.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
close('all')
end
