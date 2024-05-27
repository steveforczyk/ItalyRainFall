function PlotERA5TotalRainFallTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the the accumilated rainfall data which is in
% units of kg
% 
%
% Written By: Stephen Forczyk
% Created: April 23,2024
% Revised: April 24,2024 added addition Prov2 data
% Classification: Unclassified/Public Domain

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

global TotPrecipItaly TotPrecipAbruzzo TotPrecipApulia TotPrecipBasilicata;
global TotPrecipCalabria TotPrecipCampania TotPrecipEmilia TotPrecipFriuli;
global TotPrecipLazio TotPrecipLiguria TotPrecipLombardia TotPrecipMarche;
global TotPrecipMolise TotPrecipPiemonte TotPrecipSardegna TotPrecipSicily;
global TotPrecipToscana TotPrecipTrentino TotPrecipUmbria TotPrecipValla TotPrecipVeneto;
global TotAccumilItaly TotAccumilAbruzzo TotAccumilApulia TotAccumilBasilicata;
global TotAccumilCalabria TotAccumilCampania TotAccumilEmilia TotAccumilFriuli;
global TotAccumilSicily TotAccumilVeneto;
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
global isumhourlyfiles sf1;% sf1 is the scale factor to go fro

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
    plot(DailyRainFallTotalProv1TT.Time,DailyRainFallTotalProv1TT.Italy,'b',DailyRainFallTotalProv1TT.Time,DailyRainFallTotalProv1TT.Abruzzo,'g',...
        DailyRainFallTotalProv1TT.Time,DailyRainFallTotalProv1TT.Apulia,'k',DailyRainFallTotalProv1TT.Time,DailyRainFallTotalProv1TT.Basilicata,'r',...
        DailyRainFallTotalProv1TT.Time,DailyRainFallTotalProv1TT.Calabria,'c',DailyRainFallTotalProv1TT.Time,DailyRainFallTotalProv1TT.Campania,'r+');
    hl=legend('Italy','Abruzzo','Apulia','Basilicata','Calabria','Campania');
    ylabel('Rainfall Acumilation-Avg/inches','FontWeight','bold','FontSize',12);

elseif(ikind==2)
    plot(DailyRainFallTotalProv2TT.Time,DailyRainFallTotalProv2TT.Italy,'b',DailyRainFallTotalProv2TT.Time,DailyRainFallTotalProv2TT.Emilia,'g',...
        DailyRainFallTotalProv2TT.Time,DailyRainFallTotalProv2TT.Friuli,'k',DailyRainFallTotalProv2TT.Time,DailyRainFallTotalProv2TT.Lazio,'r',...
        DailyRainFallTotalProv2TT.Time,DailyRainFallTotalProv2TT.Liguria,'c',DailyRainFallTotalProv2TT.Time,DailyRainFallTotalProv2TT.Lombardia,'r+');
    hl=legend('Italy','Emilia','Friuli','Lazio','Ligurio','Lombaria');
    ylabel('Rainfall Acumilation-Avg/inches','FontWeight','bold','FontSize',12);

elseif(ikind==3)
    plot(DailyRainFallTotalProv3TT.Time,DailyRainFallTotalProv3TT.Italy,'b',DailyRainFallTotalProv3TT.Time,DailyRainFallTotalProv3TT.Marche,'g',...
        DailyRainFallTotalProv3TT.Time,DailyRainFallTotalProv3TT.Molise,'k',DailyRainFallTotalProv3TT.Time,DailyRainFallTotalProv3TT.Piemonte,'r',...
        DailyRainFallTotalProv3TT.Time,DailyRainFallTotalProv3TT.Sardegna,'c',DailyRainFallTotalProv3TT.Time,DailyRainFallTotalProv3TT.Sicily,'r+');
    hl=legend('Italy','Marche','Molise','Piemonte','Sardegna','Sicily');
    ylabel('Rainfall Acumilation-Avg Inches','FontWeight','bold','FontSize',12);
 

elseif(ikind==4)
    plot(DailyRainFallTotalProv4TT.Time,DailyRainFallTotalProv4TT.Italy,'b',DailyRainFallTotalProv4TT.Time,DailyRainFallTotalProv4TT.Toscana,'g',...
        DailyRainFallTotalProv4TT.Time,DailyRainFallTotalProv4TT.Trentino,'k',DailyRainFallTotalProv4TT.Time,DailyRainFallTotalProv4TT.Umbria,'r',...
        DailyRainFallTotalProv4TT.Time,DailyRainFallTotalProv4TT.Valla,'c',DailyRainFallTotalProv4TT.Time,DailyRainFallTotalProv4TT.Veneto,'r+');  
    hl=legend('Italy','Toscsana','Trentino','Umbria','Valla','Veneto');
    ylabel('Rainfall Acumilation-Avg Inches','FontWeight','bold','FontSize',12);
 
end

set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .1,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
pause(chart_time)
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat(titlestr,'.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
% if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
%     if(iNewChapter)
%         headingstr1=strcat('Tabular Cumilative Values For-','Sea Salts');
% 
%         chapter = Chapter("Title",headingstr1);
%     end
%     add(chapter,Section(sectionstr));
%     imdata = imread(figstr);
%     [nhigh,nwid,~]=size(imdata);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which(figstr);
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
%    
%     if(ikind2==1066)
%         parastr2='This metric is the value of the Sea Salt Dry Deposition-this is a cumilative sum for 1 day.';
%         parastr3=' The expected data is can be several TG/day over the globe note that the world values were divided by 100.';
%         parastr4=' This was done to allow greater visibility in the graph for the ROI values which are much smaller.';
%         parastr5=' Note that this value is the result of summing all 5 particle size Bins';
%     elseif(ikind2==1067)
%         parastr2='This metric is the value of the Sea Salt Emission  over a period of one day.';
%         parastr3=' The expected data is well under a femtogram /m^2/sec note that the world values were divided by 100.';
%         parastr4=' This was done to allow greater visibility in the graph for the ROI values which are much smaller.';
%         parastr5=' Note that this value is the result of summing all 5 particle size Bins';
%     elseif(ikind2==1068)
%         parastr2='This metric is the value of the Sea Salt Deposition over a period of one day.';
%         parastr3=' The expected data is well under a femtogram /m^2/sec note that the world values were divided by 100.';
%         parastr4=' This was done to allow greater visibility in the graph for the ROI values which are much smaller.';
%         parastr5=' Note that this value is the result of summing all 5 particle size Bins';
%     end
%     parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
%     p1 = Paragraph(parastr9);
%     p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p1);
%     if(ikind2==1066)
%         br = PageBreak(); 
%         add(chapter,br);
%         LeftCol= char(SSDPSumTT.Properties.RowTimes);
% % Now convert the Left Column to a cell
%         [nrows,ncols]=size(LeftCol);
% % Now convert this to Year Month Day format in 3 columns
%         Years=zeros(nrows,1);
%         Months=zeros(nrows,1);
%         Days=zeros(nrows,1);
%         for n=1:nrows
%             nowStr=LeftCol(n,1:ncols);
%             daystr=nowStr(1:2);
%             monthstr=nowStr(4:6);
%             yearstr=nowStr(8:11);
%             daynum=str2double(daystr);
%             [monthnum] = ConvertMonthStrToNumber(monthstr);
%             yearnum=str2double(yearstr);
%             Years(n,1)=yearnum;
%             Months(n,1)=monthnum;
%             Days(n,1)=daynum;
%         end
%         Hdrs=cell(1,9);
%         Hdrs{1,1}='Years';
%         Hdrs{1,2}='Months';
%         Hdrs{1,3}='Days';
%         Hdrs{1,4}='World';
%         Hdrs{1,5}='ROIName6';
%         Hdrs{1,6}='ROIName7';
%         Hdrs{1,7}='ROIName8';
%         Hdrs{1,8}='ROIName9';
%         Hdrs{1,9}='ROIName10';
%         Col1=SSDPSumTable.World;
%         Col2=SSDPSumTable.ROIName6;
%         Col3=SSDPSumTable.ROIName7;
%         Col4=SSDPSumTable.ROIName8;
%         Col5=SSDPSumTable.ROIName9;
%         Col6=SSDPSumTable.ROIName10;
%         myCellArray=cell(nrows,6);
%         myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
%         for i=1:nrows
%             myCellArray{i,1}=Years(i,1);
%             myCellArray{i,2}=Months(i,1);
%             myCellArray{i,3}=Days(i,1);
%             for j=1:6
%                 myCellArray{i,j+3}=myArray(i,j+3);
%                 
%             end
%         end
%         T1=[Hdrs;myCellArray];
%         tbl1=Table(T1);
%         tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
%             NumberFormat("%6.4f")}];
%         tbl1.TableEntriesHAlign = 'center';
%         tbl1.HAlign='center';
%         tbl1.ColSep = 'single';
%         tbl1.RowSep = 'single';
%         r = row(tbl1,1);
%         r.Style = [r.Style {Color('red'),Bold(true)}];
%         bt1 = BaseTable(tbl1);
%         timeslicestr=char(TimeSlices{numtimeslice,1});
%         tabletitlestr='Merra2-SSDP-Cumilative Salt Deposition';
%         tabletitle = Text(tabletitlestr);
%         tabletitle.Bold = false;
%         bt1.Title = tabletitle;
%         bt1.TableWidth="7in";
%         add(chapter,bt1);
%         parastr601='The table above cumiliative daily deposition of Sea Salt.';
%         parastr602=' Quoted Desposition if for Combined 5 size bins each day';
%         parastr603=strcat('ROIName6=',ROIName6,'-ROIName7=',ROIName7);
%         parastr604=strcat('ROIName8=',ROIName8,'-ROIName9=',ROIName9,...
%             '-ROIName10=',ROIName10);
%         parastr605='Note that the World Cumilative values were reduced by 100 for plot purposes';
%         parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
%         p609= Paragraph(parastr609);
%         p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
%         add(chapter,p609);
%   elseif(ikind2==1067)
%         br = PageBreak(); 
%         add(chapter,br);
%         LeftCol= char(SSEMSumTT.Properties.RowTimes);
% % Now convert the Left Column to a cell
%         [nrows,ncols]=size(LeftCol);
% % Now convert this to Year Month Day format in 3 columns
%         Years=zeros(nrows,1);
%         Months=zeros(nrows,1);
%         Days=zeros(nrows,1);
%         for n=1:nrows
%             nowStr=LeftCol(n,1:ncols);
%             daystr=nowStr(1:2);
%             monthstr=nowStr(4:6);
%             yearstr=nowStr(8:11);
%             daynum=str2double(daystr);
%             [monthnum] = ConvertMonthStrToNumber(monthstr);
%             yearnum=str2double(yearstr);
%             Years(n,1)=yearnum;
%             Months(n,1)=monthnum;
%             Days(n,1)=daynum;
%         end
%         Hdrs=cell(1,9);
%         Hdrs{1,1}='Years';
%         Hdrs{1,2}='Months';
%         Hdrs{1,3}='Days';
%         Hdrs{1,4}='World';
%         Hdrs{1,5}='ROIName6';
%         Hdrs{1,6}='ROIName7';
%         Hdrs{1,7}='ROIName8';
%         Hdrs{1,8}='ROIName9';
%         Hdrs{1,9}='ROIName10';
%         Col1=SSEMSumTable.World;
%         Col2=SSEMSumTable.ROIName6;
%         Col3=SSEMSumTable.ROIName7;
%         Col4=SSEMSumTable.ROIName8;
%         Col5=SSEMSumTable.ROIName9;
%         Col6=SSEMSumTable.ROIName10;
%         myCellArray=cell(nrows,6);
%         myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
%         for i=1:nrows
%             myCellArray{i,1}=Years(i,1);
%             myCellArray{i,2}=Months(i,1);
%             myCellArray{i,3}=Days(i,1);
%             for j=1:6
%                 myCellArray{i,j+3}=myArray(i,j+3);                
%             end
%         end
%         T1=[Hdrs;myCellArray];
%         tbl1=Table(T1);
%         tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
%             NumberFormat("%6.4f")}];
%         tbl1.TableEntriesHAlign = 'center';
%         tbl1.HAlign='center';
%         tbl1.ColSep = 'single';
%         tbl1.RowSep = 'single';
%         r = row(tbl1,1);
%         r.Style = [r.Style {Color('red'),Bold(true)}];
%         bt1 = BaseTable(tbl1);
%         timeslicestr=char(TimeSlices{numtimeslice,1});
%         tabletitlestr='Merra2-SSEM-Cumilative Salt Emission';
%         tabletitle = Text(tabletitlestr);
%         tabletitle.Bold = false;
%         bt1.Title = tabletitle;
%         bt1.TableWidth="7in";
%         add(chapter,bt1);
%         parastr601='The table above cumiliative daily emission of Sea Salt.';
%         parastr602=' Quoted Emission if for Combined 5 size bins each day';
%         parastr603=strcat('ROIName6=',ROIName6,'-ROIName7=',ROIName7);
%         parastr604=strcat('ROIName8=',ROIName8,'-ROIName9=',ROIName9,...
%             '-ROIName10=',ROIName10);
%         parastr605='Note that the World Cumilative values were reduced by 100 for plot purposes';
%         parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
%         p609= Paragraph(parastr609);
%         p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
%         add(chapter,p609);
%      elseif(ikind2==1068)
%         br = PageBreak(); 
%         add(chapter,br);
%         LeftCol= char(SSSDSumTT.Properties.RowTimes);
% % Now convert the Left Column to a cell
%         [nrows,ncols]=size(LeftCol);
% % Now convert this to Year Month Day format in 3 columns
%         Years=zeros(nrows,1);
%         Months=zeros(nrows,1);
%         Days=zeros(nrows,1);
%         for n=1:nrows
%             nowStr=LeftCol(n,1:ncols);
%             daystr=nowStr(1:2);
%             monthstr=nowStr(4:6);
%             yearstr=nowStr(8:11);
%             daynum=str2double(daystr);
%             [monthnum] = ConvertMonthStrToNumber(monthstr);
%             yearnum=str2double(yearstr);
%             Years(n,1)=yearnum;
%             Months(n,1)=monthnum;
%             Days(n,1)=daynum;
%         end
%         Hdrs=cell(1,9);
%         Hdrs{1,1}='Years';
%         Hdrs{1,2}='Months';
%         Hdrs{1,3}='Days';
%         Hdrs{1,4}='World';
%         Hdrs{1,5}='ROIName6';
%         Hdrs{1,6}='ROIName7';
%         Hdrs{1,7}='ROIName8';
%         Hdrs{1,8}='ROIName9';
%         Hdrs{1,9}='ROIName10';
%         Col1=SSSDSumTable.World;
%         Col2=SSSDSumTable.ROIName6;
%         Col3=SSSDSumTable.ROIName7;
%         Col4=SSSDSumTable.ROIName8;
%         Col5=SSSDSumTable.ROIName9;
%         Col6=SSSDSumTable.ROIName10;
%         myCellArray=cell(nrows,6);
%         myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
%         for i=1:nrows
%             myCellArray{i,1}=Years(i,1);
%             myCellArray{i,2}=Months(i,1);
%             myCellArray{i,3}=Days(i,1);
%             for j=1:6
%                 myCellArray{i,j+3}=myArray(i,j+3);                
%             end
%         end
%         T1=[Hdrs;myCellArray];
%         tbl1=Table(T1);
%         tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
%             NumberFormat("%6.4f")}];
%         tbl1.TableEntriesHAlign = 'center';
%         tbl1.HAlign='center';
%         tbl1.ColSep = 'single';
%         tbl1.RowSep = 'single';
%         r = row(tbl1,1);
%         r.Style = [r.Style {Color('red'),Bold(true)}];
%         bt1 = BaseTable(tbl1);
%         timeslicestr=char(TimeSlices{numtimeslice,1});
%         tabletitlestr='Merra2-SSSD-Cumilative Salt Sedimentation';
%         tabletitle = Text(tabletitlestr);
%         tabletitle.Bold = false;
%         bt1.Title = tabletitle;
%         bt1.TableWidth="7in";
%         add(chapter,bt1);
%         parastr601='The table above cumiliative daily sedimentation of Sea Salt.';
%         parastr602=' Quoted Emission if for Combined 5 size bins each day';
%         parastr603=strcat('ROIName6=',ROIName6,'-ROIName7=',ROIName7);
%         parastr604=strcat('ROIName8=',ROIName8,'-ROIName9=',ROIName9,...
%             '-ROIName10=',ROIName10);
%         parastr605='Note that the World Cumilative values were reduced by 100 for plot purposes';
%         parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
%         p609= Paragraph(parastr609);
%         p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
%         add(chapter,p609);
%     end
%     if(iCloseChapter==1)
%         add(rpt,chapter);
%     end
%     
% end
close('all')
end
