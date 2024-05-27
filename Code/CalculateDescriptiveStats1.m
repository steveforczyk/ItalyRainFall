function CalculateDescriptiveStats1()
% This function will calculate Descriptive stats for the Section 1
% variables
% The purpose of including this capabilty will be to permit comparisons of
% the data to a variety of distributions
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 17,2024
% Revised:----
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
global StartPeriodStr StartPeriod EndPeriodStr EndPeriod YearPeriod StartMonth EndMonth totalperiod;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30;
global Section1Table Section1TT EventTimes Section1BasicStats Section1BasicStatsHdr;
global Section1BasicStatsTable;
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

%% Start Calculation the stats for the nine variables of interest
% Variable 1 is Total Precip in mm
Section1BasicStats{1,1}='Total Precip-mm';
numvals=length(Precip);
Section1BasicStats{1,2}=numvals;
mean1=mean(Precip);
median1=median(Precip);
mode1=mode(Precip);
std1=std(Precip);
minval1=min(Precip);
maxval1=max(Precip);
skew1=skewness(Precip);
kurt1=kurtosis(Precip);
Section1BasicStats{1,3}=mean1;
Section1BasicStats{1,4}=median1;
Section1BasicStats{1,5}=mode1;
Section1BasicStats{1,6}=std1;
Section1BasicStats{1,7}=minval1;
Section1BasicStats{1,8}=maxval1;
Section1BasicStats{1,9}=skew1;
Section1BasicStats{1,10}=kurt1;
% Variable 2 is Storm Duration in Hours
Section1BasicStats{2,1}='Duration-hrs';
numvals=length(Duration);
Section1BasicStats{2,2}=numvals;
mean2=mean(Duration);
median2=median(Duration);
mode2=mode(Duration);
std2=std(Duration);
minval2=min(Duration);
maxval2=max(Duration);
skew2=skewness(Duration);
kurt2=kurtosis(Duration);
Section1BasicStats{2,3}=mean2;
Section1BasicStats{2,4}=median2;
Section1BasicStats{2,5}=mode2;
Section1BasicStats{2,6}=std2;
Section1BasicStats{2,7}=minval2;
Section1BasicStats{2,8}=maxval2;
Section1BasicStats{2,9}=skew2;
Section1BasicStats{2,10}=kurt2;
% Variable 3 is MAX_5 which the maximum rain fall rate over a 5 minute
% period
Section1BasicStats{3,1}='MAX_5';
numvals=length(MAX_5);
Section1BasicStats{3,2}=numvals;
mean3=mean(MAX_5);
median3=median(MAX_5);
mode3=mode(MAX_5);
std3=std(MAX_5);
minval3=min(MAX_5);
maxval3=max(MAX_5);
skew3=skewness(MAX_5);
kurt3=kurtosis(MAX_5);
Section1BasicStats{3,3}=mean3;
Section1BasicStats{3,4}=median3;
Section1BasicStats{3,5}=mode3;
Section1BasicStats{3,6}=std3;
Section1BasicStats{3,7}=minval3;
Section1BasicStats{3,8}=maxval3;
Section1BasicStats{3,9}=skew3;
Section1BasicStats{3,10}=kurt3;
% Variable 4 is MAX_10 which the maximum rain fall rate over a 10 minute
% period
Section1BasicStats{4,1}='MAX_10';
numvals=length(MAX_10);
Section1BasicStats{4,2}=numvals;
mean4=mean(MAX_10);
median4=median(MAX_10);
mode4=mode(MAX_10);
std4=std(MAX_10);
minval4=min(MAX_10);
maxval4=max(MAX_10);
skew4=skewness(MAX_10);
kurt4=kurtosis(MAX_10);
Section1BasicStats{4,3}=mean4;
Section1BasicStats{4,4}=median4;
Section1BasicStats{4,5}=mode4;
Section1BasicStats{4,6}=std4;
Section1BasicStats{4,7}=minval4;
Section1BasicStats{4,8}=maxval4;
Section1BasicStats{4,9}=skew4;
Section1BasicStats{4,10}=kurt4;
% Variable 5 is MAX_15 which the maximum rain fall rate over a 15 minute
% period
Section1BasicStats{5,1}='MAX_15';
numvals=length(MAX_15);
Section1BasicStats{5,2}=numvals;
mean5=mean(MAX_15);
median5=median(MAX_15);
mode5=mode(MAX_15);
std5=std(MAX_15);
minval5=min(MAX_15);
maxval5=max(MAX_15);
skew5=skewness(MAX_15);
kurt5=kurtosis(MAX_15);
Section1BasicStats{5,3}=mean5;
Section1BasicStats{5,4}=median5;
Section1BasicStats{5,5}=mode5;
Section1BasicStats{5,6}=std5;
Section1BasicStats{5,7}=minval5;
Section1BasicStats{5,8}=maxval5;
Section1BasicStats{5,9}=skew5;
Section1BasicStats{5,10}=kurt5;
% Variable 6 is MAX_30 which the maximum rain fall rate over a 30 minute
% period
Section1BasicStats{6,1}='MAX_30';
numvals=length(MAX_30);
Section1BasicStats{6,2}=numvals;
mean6=mean(MAX_30);
median6=median(MAX_30);
mode6=mode(MAX_30);
std6=std(MAX_30);
minval6=min(MAX_30);
maxval6=max(MAX_30);
skew6=skewness(MAX_30);
kurt6=kurtosis(MAX_30);
Section1BasicStats{6,3}=mean6;
Section1BasicStats{6,4}=median6;
Section1BasicStats{6,5}=mode6;
Section1BasicStats{6,6}=std6;
Section1BasicStats{6,7}=minval6;
Section1BasicStats{6,8}=maxval6;
Section1BasicStats{6,9}=skew6;
Section1BasicStats{6,10}=kurt6;
% Variable 7 is MAX_60 which the maximum rain fall rate over a 60 minute
% period
Section1BasicStats{7,1}='MAX_60';
numvals=length(MAX_60);
Section1BasicStats{7,2}=numvals;
mean7=mean(MAX_60);
median7=median(MAX_60);
mode7=mode(MAX_60);
std7=std(MAX_60);
minval7=min(MAX_60);
maxval7=max(MAX_60);
skew7=skewness(MAX_60);
kurt7=kurtosis(MAX_60);
Section1BasicStats{7,3}=mean7;
Section1BasicStats{7,4}=median7;
Section1BasicStats{7,5}=mode7;
Section1BasicStats{7,6}=std7;
Section1BasicStats{7,7}=minval7;
Section1BasicStats{7,8}=maxval7;
Section1BasicStats{7,9}=skew7;
Section1BasicStats{7,10}=kurt7;
% Variable 8 is ENERGY which the maximum rain fall rate over a 60 minute
% period
Section1BasicStats{8,1}='ENERGY';
numvals=length(ENERGY);
Section1BasicStats{8,2}=numvals;
mean8=mean(ENERGY);
median8=median(ENERGY);
mode8=mode(ENERGY);
std8=std(ENERGY);
minval8=min(ENERGY);
maxval8=max(ENERGY);
skew8=skewness(ENERGY);
kurt8=kurtosis(ENERGY);
Section1BasicStats{8,3}=mean8;
Section1BasicStats{8,4}=median8;
Section1BasicStats{8,5}=mode8;
Section1BasicStats{8,6}=std8;
Section1BasicStats{8,7}=minval8;
Section1BasicStats{8,8}=maxval8;
Section1BasicStats{8,9}=skew8;
Section1BasicStats{8,10}=kurt8;
% Variable 9 is EI130 which the maximum rain fall rate over a 60 minute
% period
Section1BasicStats{9,1}='EI130';
numvals=length(EI130);
Section1BasicStats{9,2}=numvals;
mean9=mean(EI130);
median9=median(EI130);
mode9=mode(EI130);
std9=std(EI130);
minval9=min(EI130);
maxval9=max(EI130);
skew9=skewness(EI130);
kurt9=kurtosis(EI130);
Section1BasicStats{9,3}=mean9;
Section1BasicStats{9,4}=median9;
Section1BasicStats{9,5}=mode9;
Section1BasicStats{9,6}=std9;
Section1BasicStats{9,7}=minval9;
Section1BasicStats{9,8}=maxval9;
Section1BasicStats{9,9}=skew9;
Section1BasicStats{9,10}=kurt9;
% Create a Table from this cell array
Section1BasicStatsTable = cell2table(Section1BasicStats,...
    "VariableNames",["Item" "numvals" "mean" "median" " mode" "stdev" "minval" "maxval" "skew" "kurtosis"]);
% Print out these results to the log file
fprintf(fid,'%s\n','----------- Start Descriptive Statistics Of Section 1 Variables--------');
str1='Variable';
str2='NumPts';
str3='Mean';
str4='Median';
str5='Mode';
str6='Stdev';
str7='Min Val';
str8='Max Val';
str9='Skew';
str10='Kurtosis';
% fprintf(fid,'%  10s % 10s % 10s % 10s % 10s % 10s % 10s % 10s % 10s % 10s\n',str1,str2,str3,...
%     str4,str5,str6,str7,str8,str9,str10);
fprintf(fid,'% 10s % 13s % 10s % 10s  % 10s',str1,str2,str3,str4,str5);
fprintf(fid,'% 10s % 10s % 10s % 10s  % 10s\n',str6,str7,str8,str9,str10);
str1='TotalPrecip';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 13i % 10.4f %10.4f %12.4f',numvals,mean1,median1,mode1);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std1,minval1,maxval1,skew1,kurt1);
str1='Duration-hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 13i % 10.4f %10.4f %12.4f',numvals,mean2,median2,mode2);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std2,minval2,maxval2,skew2,kurt2);
str1='MAX-5-mm/hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 13i % 10.4f %10.4f %12.4f',numvals,mean3,median3,mode3);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std3,minval3,maxval3,skew3,kurt3);
str1='MAX-10-mm/hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean4,median4,mode4);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std4,minval4,maxval4,skew4,kurt4);
str1='MAX-15-mm/hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean5,median5,mode5);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std5,minval5,maxval5,skew5,kurt5);
str1='MAX-30-mm/hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean6,median6,mode6);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std6,minval6,maxval6,skew6,kurt6);
str1='MAX-60-mm/hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean7,median7,mode7);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std7,minval7,maxval7,skew7,kurt7);
str1='Energy-MJ/ha';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean8,median8,mode8);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std8,minval8,maxval8,skew8,kurt8);
str1='EI130-MJ*mm/ha-hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 7i % 10.4f %10.4f %12.4f',numvals,mean9,median9,mode9);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std9,minval9,maxval9,skew9,kurt9);

fprintf(fid,'%s\n','----------- End Descriptive Statistics Of Section 1 Variables--------');

end