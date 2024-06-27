function PlotNCEIRainFallTable(titlestr,ikind)
% This function plots selective columns of the RainFallTable
% generated by the from an imported NCEI Rainfall set from
% a single COOPStation
% 
% Written By: Stephen Forczyk
% Created: June 17,2024
% Revised: June 19,2024 added logic to plot yeraly rain sum
% Classification: Unclassified/Public Domain

global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable COOPActiveStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile StateBoundaryData;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0 selectedState;
global StateFIPSFile USCountiesShapeFile SC nactiveStations;
global iDTEDMap DTEDFileName Alabama AlabamaRB;
global StationName StationLat StationLon StationElev Element StationDlySum;
global StationDlySumMF StationDlySumQF StationDlySumS1 StationDlySumS2;
global YearN MonthN DayN HoursN MinutesN SecN YearRec MonthRec DayRec RecordTimes;
global RainFallTable RainFallTT RainFallTimes RainVals SourceFlag1 SourceFlag2;
global RecordTable RecordTT;
global numPredYears startRain endRain RainChangeRate;
global HPDStationFile numCOOPStations StationMetaData;
global StnID LatStn LonStn ElvStn StateStn NameStn WMO_ID Sample_Interval UTC_Offset;
global POR_Date_Range PCT_POR_Good Last_Half_POR PCT_Last_Half_Good;
global Last_QTR_POR PCT_Last_Qtr_Good HPDStationTable;
global TotalPrecipmm TotalPrecipin fracYears avg_yearly_rainfallmm avg_yearly_rainfallin;
global MonthlyRainFallTotals YearBox MonthBox DayBox MonthlyTimes;
global MonthlyRainTable MonthlyRainTT YearlySum YearDates;
global polyorder pRain SRain yRainPred yRainPred1 YearDatesf YearlySumf;
global NoRainDays TraceRainDays MediumRainDays HeavyRainDays tracelimit heavyrainlimit;
global numallused numpartialused fracperfect;
global numPredYears PredYears startRain endRain RainChangeRate RainChngRate ERain STRain;
global ActualDays ERain HeavyRainD MedRainD ;
global ActualDays TotalDays STRain ERain HeavyRainD MedRainD TraceRainD NoRainD ;
global HPDStationStatsTable HPDStationTable imatchstation;


global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch



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
nummeas=height(RainFallTable);
numdays=height(RecordTable);
dt=RainFallTimes(nummeas)-RainFallTimes(1);
dt.Format='y';
fracYears=years(dt);
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
cfactor=25.4/100;% Conver .01 in to mm
cfactor1=.01;
slat=StationMetaData.Lat;
slon=StationMetaData.Lon;
sname=StationMetaData.NameStn;
statename=StationMetaData.StateStn;
stationdaterange=StationMetaData.PORDateRange;
%% Compute Rainfall Change over recording period
if(ikind==4)
    numPredYears=length(YearDatesf);
    PredYears(imatchstation,1)=numPredYears;
    endRain=yRainPred(numPredYears,1);
    startRain=yRainPred(1,1);
    RainChangeRate=(endRain-startRain)/numPredYears;
    STRain(imatchstation,1)=startRain;
    ERain(imatchstation,1)=endRain;
    RainChngRate(imatchstation,1)=RainChangeRate;
    HPDStationStatsTable{imatchstation,15}=numPredYears;
    HPDStationStatsTable{imatchstation,16}=startRain;
    HPDStationStatsTable{imatchstation,17}=endRain;
    HPDStationStatsTable{imatchstation,18}=RainChangeRate;
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','Rate of Change in Rain Rate Over Observation Period');
    str1='Rain Rate Of Change per Year';
    str2='Inches/yr/yr';
    fprintf(fid,'%10s    %10.4f   %10s\n',str1,RainChangeRate,str2);
    fprintf(fid,'\n');
end
if(ikind==1)
    plot(RainFallTT.RainFallTimes,cfactor1*RainFallTT.RainTot,'--rs',...
    'LineWidth',1,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[1 0 0]);
    ylabel('Total Precip15min-inches','FontWeight','bold','FontSize',12);
    TotalPrecipmm=cfactor*sum(RainFallTT.RainTot,'omitnan');
    TotalPrecipin=cfactor1*sum(RainFallTT.RainTot,'omitnan');
    avg_yearly_rainfallmm=TotalPrecipmm/fracYears;
    avg_yearly_rainfallin=avg_yearly_rainfallmm/2.54;
elseif(ikind==2)
    plot(RecordTT.RecordTimes,RecordTT.DlySum,'g');
    ylabel('Daily Precip-in','FontWeight','bold','FontSize',12);
elseif(ikind==3)
    plot(MonthlyRainTT.MonthlyTimes,MonthlyRainTT.MonthlySum,'--bs',...
         'LineWidth',1,'MarkerSize',10,'MarkerEdgeColor','r',...
         'MarkerFaceColor',[0 1 0]);
    ylabel('MonthlyRain Sum-inches','FontWeight','bold','FontSize',12);
elseif(ikind==4)
    plot(YearDatesf,YearlySumf,'b--o',YearDatesf,yRainPred,'r*');
    ylabel('YearlyRain Sum-inches','FontWeight','bold','FontSize',12);
    legend({'Measured Rainfall','Fitted RainFall'},'Location','northeast');
 elseif(ikind==5)
    plot(RecordTT.RecordTimes,StationDlySumQF(:,1),'g');
    ylabel('Daily Quality Flag','FontWeight','bold','FontSize',12);


end

set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'Position',[0.1300 0.1400 0.7450 0.7750]);
set(gca,'XGrid','on','YGrid','on');
set(gca,'XMinorGrid','on','YMinorGrid','on');
if(ikind~=5)
    set(gca,'YLim',[0 inf]);
else
    set(gca,'YLim',[0 3]);
end

ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
%%Add a logo
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
if(ikind==1)
    txtstr1=strcat('Total of precip in in over rainfall period-',...
        num2str(TotalPrecipin),'-avg yearly rainfall-',num2str(avg_yearly_rainfallin));
    tx2=.10;
    ty2=.04;
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('State-',statename,'-Station-',sname,'-Lat-',num2str(slat),...
        '-Lon-',num2str(slon),'-DateRange-',stationdaterange);
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(ikind==2)
    txtstr1=strcat('No Rain Days-',num2str(NoRainDays),'-Trace Rain Days-',num2str(TraceRainDays),...
        '-Medium Rain Days-',num2str(MediumRainDays),'-Heavy Rain Days-',num2str(HeavyRainDays));
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.04;
    txtstr2=strcat('State-',statename,'-Station-',sname,'-Lat-',num2str(slat),...
        '-Lon-',num2str(slon),'-DateRange-',stationdaterange);
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(ikind==3)
    txtstr1=strcat('MonthlyRainSum-','inches');
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.04;
    txtstr2=strcat('State-',statename,'-Station-',sname,'-Lat-',num2str(slat),...
        '-Lon-',num2str(slon),'-DateRange-',stationdaterange);
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(ikind==4)
    txtstr1=strcat('YearlyRainSum-','inches','-Rate Of Change in RainRate=',...
        num2str(RainChangeRate),'-Inches/yr^2');
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.04;
    txtstr2=strcat('State-',statename,'-Station-',sname,'-Lat-',num2str(slat),...
        '-Lon-',num2str(slon),'-DateRange-',stationdaterange);
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(ikind==5)
    txtstr1=strcat('Fraction of days that used all 96 samples-',num2str(fracperfect),...
        '-1 All Samples Used-','-2-Less than 96 samples used');
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.04;
    txtstr2=strcat('State-',statename,'-Station-',sname,'-Lat-',num2str(slat),...
        '-Lon-',num2str(slon),'-DateRange-',stationdaterange);
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
end
%txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
%conversion found on this source
%https://www.metric-conversions.org/pressure/kilogram-force-per-square-meter-to-inches-of-water.htm
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
