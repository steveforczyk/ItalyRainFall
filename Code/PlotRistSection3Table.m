function PlotRistSection3Table(titlestr,ikind)
% This function plots a numbr of parmaters from the output of the RIST
% Section 3 Data
% This data consists of 24 bi monthly data segments averaged from the
% section 1 data
% 
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 18,2024
% Revised: ----
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
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30;
global Section1Table Section1TT EventTimes;
global Section3Table Section3TT
global RISTOutputFile;
global DateCell DateStr Precip Duration MAX_5 MAX_10 MAX_15 MAX_30 MAX_60; 
global ENERGY EI130;
global Period Precip24 Energy24 EI3024 EI24 ACC24_EI ErosDensity24;
global Month12 Precip12 Energy12  EI13012 ErosDensity12;
global TotalPrecipSec1 TotalRainTimeSec1 RainFracSection1;
global StartPeriodStr StartPeriod EndPeriodStr EndPeriod YearPeriod;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath;
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
global iLogo LogoFileName1 iCheckConfig;
global isumhourlyfiles sf1;% sf1 is the scale factor to go from kg/m^2 to inches of water

% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     import mlreportgen.dom.*;
%     import mlreportgen.report.*;
% end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==1)
    plot(Section3TT.Time,Section3TT.Precip24,'--gs',...
    'LineWidth',1,...
    'MarkerSize',10,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor',[0 1 0]);
    ylabel('Total Precip-mm','FontWeight','bold','FontSize',12);

elseif(ikind==2)
    plot(Section3TT.Time,Section3TT.Energy24,'--rs',...
    'LineWidth',1,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[1 0 0]);
    ylabel('Energy MJ-ha','FontWeight','bold','FontSize',12);

elseif(ikind==3)
    plot(RFactorTT.Time,RFactorTT.SUMKE30,'r');
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
%set(gca,'Position',[0.1300 0.1100 0.7750 0.8150])
set(gca,'Position',[0.1300 0.1400 0.7450 0.7750]);
set(gca,'XGrid','on','YGrid','on');
set(gca,'XMinorGrid','on','YMinorGrid','on');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
%Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .21,.08,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
% newaxesh=axes('Position',[0 0 1 1]);
% set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
% tx1=.10;
% ty1=.04;
% TotalPrecipSec1InYear=TotalPrecipSec1/(25.4*YearPeriod);
% if(ikind==1)
%     txtstr1=strcat('Number Rain Events-',num2str(numrainevents),'-with a total of-',...
%         num2str(TotalPrecipSec1),'-mm of Rain-','or-',num2str(TotalPrecipSec1InYear),'-inches Per Year');
% elseif(ikind==2)
%     txtstr1=strcat('Total Rain Duration-',num2str(TotalRainTimeSec1),'-in hours or-',...
%     num2str(RainFracSection1),'-fraction of the time period');
% end
%txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
% tx2=.10;
% ty2=.05;
% conversion found on this source
% https://www.metric-conversions.org/pressure/kilogram-force-per-square-meter-to-inches-of-water.htm
% maxdepth=val100*.039370;% this last number to depth of water in inches
% txtstr2=strcat(desc,'-','50 ptile=',num2str(val50,6),'-90 ptile=',num2str(val90,6),...
%     '-100 ptile=',num2str(val100,6),'-kg/m^2','-Max water depth=',num2str(maxdepth),'-in inches');
% txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
%set(newaxesh,'Visible','Off');

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat(titlestr,'.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
close('all')
end
