function CatalogFile()
% This function will catalog the original rainfall data file
% The data contained in the original "newflagfile" will be retained
% but in order to speed up processing the file will be searched to find the
% break points by year. This can speed up operations
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 11,2024
% Revised:
% Classification:Unclassified/Public Domain
global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallFile3 RainFallFile3C S;
global StationStr StationNum RainFallFile RainFallCatalogedFile;
global RainFallTime RainFallFlag RainFallAmt RainFallName;



global ProvinceNames RainFallTime30 I30max;
global PotentialStorms ConsolidatedStorm  DefinedStorms;
global numtimesstep SelectedYears SelStartIndex SelEndIndex numused numedused30;
global StormThreshTot StormThresh360 StormThresh15;
global firstyearstr firstyear firstdaystr firstday firstmonthstr;
global firsthrstr firsthr firstminstr firstmin firstsecstr firstsec;
global lastyearstr lastyear lastdaystr lastday lastmonthstr;
global lasthrstr lasthr lastminstr lastmin lastsecstr lastsec;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30 ER30 VR30 KEnergy RainRate;
global RFactorTable RFactorTT DiagTable DiagTT;
global PotentialStormsTable PotentialStormsTT;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath excelpath;
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
global iLogo LogoFileName1 iCheckConfig;
global iStorms;

numend=length(RainFallAmt);
oldYear=1940;
ind=0;
fprintf(fid,'\n');
fprintf(fid,'%s\n','Start Cataloging Data On Input File');
for i=1:numend-1
    teststr=(RainFallTime(i));
    teststr2=(RainFallTime(i+1));
    nowstr=char(teststr);
    nowstrlen=length(teststr);
    idash=strfind(nowstr,'-');
    numdash=length(idash);
    is=idash(2)+1;
    ie=is+3;
    nowyearstr=nowstr(is:ie);
    nowYear=str2double(nowstr(is:ie));
    nowstr2=char(teststr2);
    nowstrlen2=length(teststr2);
    idash=strfind(nowstr2,'-');
    numdash=length(idash);
    is=idash(2)+1;
    ie=is+3;
    nextyearstr=nowstr2(is:ie);
    nextYear=str2double(nowstr2(is:ie));
    if(nowYear>oldYear)
        ind=ind+1;
        FoundData(ind,1)=nowYear;
        FoundData(ind,2)=i;
        istart=i;
        oldYear=nowYear;
        dispstr=strcat('Found start of data for Year-',num2str(nowYear));
        disp(dispstr);
        fprintf(fid,'%s\n',dispstr);
    elseif(nextYear>nowYear)
        FoundData(ind,3)=i;
        iend=i;
        numptsfound=iend-istart+1;
        ab=1;
        dispstr=strcat('Found end of data for Year-',num2str(nowYear),'-which had-',num2str(numptsfound),'-timeslices');
        disp(dispstr);
        fprintf(fid,'%s\n',dispstr);
    end

end
% Clip off and blank years
TempFoundData=FoundData;
[nrows,ncols]=size(FoundData);
igood=0;
for i=1:nrows
nowYear=TempFoundData(i,1);
if(nowYear>0)
    igood=igood+1;
end
end
FoundData=zeros(igood,3);
for i=1:igood
    for j=1:3
        FoundData(i,j)=TempFoundData(i,j);
    end
end
fprintf(fid,'%s\n','Finished Cataloging file');
%% Now create a cataloged file which has all the original data on it plus the Found Data array
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
actionstr='save';
varstr1='S FoundData';
MatFileName=RainFallCatalogedFile;
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
dispstr=strcat('Created a Catalog file-',MatFileName);
disp(dispstr);
fprintf(fid,'%30s\n',dispstr);

end