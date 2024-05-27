function PlotRainFallHistogram(ikind,titlestr)
% This routine will plot a histogram of selected max rain fall
% statistics
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 16,2024
% Revised: May 17,2024 added rest of Case 1 items to histogram plot list
% Classification: Unclassified

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
global StartPeriodStr StartPeriod EndPeriodStr EndPeriod YearPeriod StartMonth EndMonth totalperiod;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30;
global Section1Table Section1TT EventTimes;
global RISTOutputFile;
global DateCell DateStr Precip Duration MAX_5 MAX_10 MAX_15 MAX_30 MAX_60; 
global ENERGY EI130;
global Period Precip24 Energy24 EI3024 EI24 ACC24_EI ErosDensity24;
global Month12 Precip12 Energy12  EI13012 ErosDensity12;
global TotalPrecipSec1 TotalRainTimeSec1 RainFracSection1;

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
global min5peryear total5minper;

if(ikind==1)
    inArray=MAX_5;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----MAX-5 Histogram Plot-----');
elseif(ikind==2)
    inArray=MAX_10;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----MAX-10 Histogram Plot-----');
elseif(ikind==3)
    inArray=MAX_15;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----MAX-15 Histogram Plot-----');
elseif(ikind==4)
    inArray=MAX_30;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----MAX-30 Histogram Plot-----');
elseif(ikind==5)
    inArray=MAX_60;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----MAX-60 Histogram Plot-----');
elseif(ikind==6)
    inArray=ENERGY;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----ENERGY Plot Histogram Plot-----');
elseif(ikind==7)
    inArray=EI130;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----EI130 Plot Histogram Plot-----');
elseif(ikind==8)
    inArray=Precip;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----Precip Plot Histogram Plot-----');
elseif(ikind==9)
    inArray=Duration;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-----Storm Duration Plot Histogram Plot-----');
end

% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     import mlreportgen.dom.*;
%     import mlreportgen.report.*;
% end
numbig=length(inArray);
inArrayS=sort(inArray);
num25=round(.25*numbig);
num50=round(.50*numbig);
num75=round(.75*numbig);
num100=numbig;
val25=inArrayS(num25,1);
val50=inArrayS(num50,1);
val75=inArrayS(num75,1);
val100=inArrayS(num100,1);
statstr1=strcat('25th ptile inArray=',num2str(val25,6),'-50 ptile inArray=',num2str(val50,6));
statstr2=strcat('75th ptile inArray=',num2str(val75,6),'-100 ptile inArray=',num2str(val100,6));
fprintf(fid,'%s\n',statstr1);
fprintf(fid,'%s\n',statstr2);
% Now plot the histogram of the inArray Distribution
if(ikind<6)
    edges=linspace(0,50,201);
    xmin=0;
    xmax=50;
elseif(ikind==6)
    edges=linspace(0,5,201);
    xmin=0;
    xmax=5;
elseif(ikind==7)
    edges=linspace(0,200,300);
    xmin=0;
    xmax=200;
elseif(ikind==8)
    edges=linspace(0,50,201);
    xmin=0;
    xmax=50;
elseif(ikind==9)
    edges=linspace(0,50,201);
    xmin=0;
    xmax=50;
end
h=histogram(inArray,edges,'Normalization','probability','FaceColor','b');
set(gcf,'position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gca,'Position',[.16 .18  .70 .70]);
if(ikind==1)
    xlabel('MAX-5-mm/hr','FontWeight','bold');
elseif(ikind==2)
     xlabel('MAX-10-mm/hr','FontWeight','bold');
elseif(ikind==3)
     xlabel('MAX-15-mm/hr','FontWeight','bold');
elseif(ikind==4)
     xlabel('MAX-30-mm/hr','FontWeight','bold');
elseif(ikind==5)
     xlabel('MAX-60-mm/hr','FontWeight','bold');
elseif(ikind==6)
     xlabel('ENERGY-MJ/ha','FontWeight','bold');
elseif(ikind==7)
     xlabel('EI130-MJ*mm/(ha*hr)','FontWeight','bold');
elseif(ikind==8)
     xlabel('Precip-mm','FontWeight','bold');
elseif(ikind==9)
     xlabel('Duration-hours','FontWeight','bold');
end
ylabel('% Cases','FontWeight','bold');
set(gca,'FontWeight','bold');

set(gca,'XLim',[xmin xmax]);
if(igrid==1)
    set(gca,'XGrid','On','YGrid','On');
end
ht=title(titlestr);
set(ht,'FontWeight','bold');
%Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.60,haPos(2)-.15, .19,.10,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up the axis for writing at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.16;
ty1=.09;
txtstr1=strcat('Start Year-',num2str(StartPeriod),'-to-End Year-',num2str(EndPeriod));
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
% tx2=.18;
% ty2=.06;
% txtstr2=strcat('Fraction of Pixels that had good AOD-Estimate=',num2str(sgoodfrac,6));
% txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',8);
set(newaxesh,'Visible','Off');
pause(chart_time);
%% Save the figure
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
dispstr=strcat('Saved file-',figstr);
disp(dispstr);
if(ikind==1)
    fprintf(fid,'%s\n','-----Finished MAX-5 Histogram Plot-----');
elseif(ikind==2)
    fprintf(fid,'%s\n','-----Finished MAX-10 Histogram Plot-----');
elseif(ikind==3)
    fprintf(fid,'%s\n','-----Finished MAX-15 Histogram Plot-----');
elseif(ikind==4)
    fprintf(fid,'%s\n','-----Finished MAX-30 Histogram Plot-----');
elseif(ikind==5)
    fprintf(fid,'%s\n','-----Finished MAX-60 Histogram Plot-----');
elseif(ikind==6)
    fprintf(fid,'%s\n','-----Finished ENERGY Histogram Plot-----');
elseif(ikind==7)
    fprintf(fid,'%s\n','-----Finished EI130 Histogram Plot-----');
elseif(ikind==8)
    fprintf(fid,'%s\n','-----Finished Precip Histogram Plot-----');
elseif(ikind==9)
    fprintf(fid,'%s\n','-----Finished Storm Duration Histogram Plot-----');
end
fprintf(fid,'\n');
end

