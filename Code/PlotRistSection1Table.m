function PlotRistSection1Table(titlestr,ikind)
% This function plots a numbr of parmaters from the output of the RIST
% Section 1 Data
% 
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 15,2024
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
global Section1Table Section1TT EventTimes Section1BasicStats;
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
numrainevents=height(Section1TT);
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==1)
    plot(Section1TT.EventTimes,Section1TT.Precip,'b');
    ylabel('Total Precip-mm','FontWeight','bold','FontSize',12);

elseif(ikind==2)
    plot(Section1TT.EventTimes,Section1TT.Duration,'g');
    ylabel('Rainfall Duration-hrs','FontWeight','bold','FontSize',12);
 
end

set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'Position',[0.1300 0.1400 0.7450 0.7750]);
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
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .21,.08,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.07;
TotalPrecipSec1InYear=TotalPrecipSec1/(25.4*YearPeriod);

mean1=Section1BasicStats{1,3};
std1=Section1BasicStats{1,6};
skew1=Section1BasicStats{1,9};
kurt1=Section1BasicStats{1,10};
mean2=Section1BasicStats{2,3};
std2=Section1BasicStats{2,6};
skew2=Section1BasicStats{2,9};
kurt2=Section1BasicStats{2,10};
if(ikind==1)
    txtstr1=strcat('Number Rain Events-',num2str(numrainevents),'-with a total of-',...
        num2str(TotalPrecipSec1),'-mm of Rain-','or-',num2str(TotalPrecipSec1InYear),'-inches Per Year');
    txtstr2=strcat('Mean Rain Precip=',num2str(mean1),'-stdev=',num2str(std1),...
        '-skew=',num2str(skew1),'-kurtosis=',num2str(kurt1));
elseif(ikind==2)
    txtstr1=strcat('Total Rain Duration-',num2str(TotalRainTimeSec1),'-in hours or-',...
    num2str(RainFracSection1),'-fraction of the time period');
    txtstr2=strcat('Mean Rain Duration=',num2str(mean2),'-stdev=',num2str(std2),...
        '-skew=',num2str(skew2),'-kurtosis=',num2str(kurt2));
end
tx2=.10;
ty2=.05;
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);

% conversion found on this source
% https://www.metric-conversions.org/pressure/kilogram-force-per-square-meter-to-inches-of-water.htm
% maxdepth=val100*.039370;% this last number to depth of water in inches
% txtstr2=strcat(desc,'-','50 ptile=',num2str(val50,6),'-90 ptile=',num2str(val90,6),...
%     '-100 ptile=',num2str(val100,6),'-kg/m^2','-Max water depth=',num2str(maxdepth),'-in inches');
% txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat(titlestr,'.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
close('all')
end
