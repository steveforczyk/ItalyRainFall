% This script will mere a number of DTED files
% This script only runs on R2024a and later
% Written By: Stephen Forczyk
% Created: Jun 8,2024
% Revised: ----
% Classification: Unclassified/Public Domain

global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0;
global Alabama AlabamaRB MatFileName;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath ristpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath statedtedpath;
global fid fid2;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global iMethod;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig iExcel iRunExcelMacro;
global iCreateMap;

%% Paths
datapath='K:\Joydeb\Alabama_Precip\';
matlabpath='K:\Joydeb\Matlab_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='D:\Joydeb\LogFiles\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
tablepath='K:\Joydeb\Tables\';
jpegpath='K:\Joydeb\Jpeg_Files\';
govjpegpath='D:\Joydeb\gov_jpeg\';
dailyfilepath='D:\Joydeb\Daily_Files\';
rainfalldatapath='K:\Joydeb\RainFall_Files\';
csvfilepath='K:\Joydeb\CSV_Files\';
excelpath='K:\Joydeb\Excel_Files\';
countyshapepath='D:\Forczyk\Map_Data\MAT_Files_Geographic\';
USshapefilepath='D:\Forczyk\Map_Data\USStateShapeFiles\';
CountyBoundaryFile='CountyBoundingBoxes';
stateboundarypath='D:\Forczyk\Map_Data\USStateBoundaryFinalFiles\';
statedtedpath='D:\Forczyk\Map_Data\State_DTED_Files\';
%% Default Values
COOPFileName='Alabama_COOP_Stations.txt';
MatFileName='UnifiedAlabamaDTED.mat';
% Flag values
idecode=0;
iMovie=1;
iCreateMap=1;
iExcel=1;
iRunExcelMacro=0;
iFastSave=1;
iLogo=1;
iMethod=2;
LogoFileName1='UPadua_Logo3.jpg';
isumhourlyfiles=1;
iCheckConfig=0;
nsortlim=25;
sf1=.039370;
min5peryear=365*24*12;
FoundData=zeros(60,3);
USAStatesFileName='USAStatesShapeFileMapListRev4.mat';
CountyBoundaryFile='CountyBoundingBoxes';
AllStateBoundaries='All_USCounties_BoundaryData.mat';
Fipsvalue=53;% Fips Code for Washington

%% Initialize some arrays to Pre Allocate Memory-this is for section 1



tic;
switch Fipsvalue
    
    case 1 % Alabama
        latlim = [ 30  35]; 
        lonlim = [ -89 -84];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedAlabamaDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Alabama
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Alabama');
    disp(dispstr)
    [Alabama,AlabamaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
        A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Alabama AlabamaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Alabama,AlabamaRB)
    geoshow(Alabama,AlabamaRB,DisplayType="surface")
    demcmap(Alabama)
    maxht=max(max(Alabama));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    case 5 % Arkansas
        latlim = [ 33  37]; 
        lonlim = [ -95 -89];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedArkansasDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Arkansas');
    disp(dispstr)
  
    [Arkansas,ArkansasRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Arkansas ArkansasRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Arkansas,ArkansasRB)
    geoshow(Arkansas,ArkansasRB,DisplayType="surface")
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
%    demcmap(Arkansas,64,cmapland);
    Arkansas2=Arkansas;
    Arkansas2(Arkansas2<0)=NaN;
    demcmap(Arkansas2,64,cmapland);
    maxht=max(max(Arkansas));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 8  % Colorado
        latlim = [ 36  42]; 
        lonlim = [ -110 -102];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Colorado
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");        
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        elseif(n==61)
            [A61,R61] = readgeoraster(nowFile,OutputType="double");
        elseif(n==62)
            [A62,R62] = readgeoraster(nowFile,OutputType="double");
        elseif(n==63)
            [A63,R63] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Colorado');
    disp(dispstr)
    ab=1;
    [Colorado,ColoradoRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
          A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,...
          A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,A57,R57,A58,R58,A59,R59,A60,R60,...
          A61,R61,A62,R62,A63,R63);
    ab=2;
    case 13  % Georgia
        latlim = [ 30  35]; 
        lonlim = [ -86 -82];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Georgia
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");



        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Colorado');
    disp(dispstr)
    ab=1;
    [Georgia,GeorgiaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30);
    ab=2;
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedGeorgiaDTED.mat';
    actionstr='save';
    varstr1='Georgia GeorgiaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Georgia,GeorgiaRB)
    geoshow(Georgia,GeorgiaRB,DisplayType="surface")
    demcmap(Georgia)
    maxht=max(max(Georgia));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Georgia2=Georgia;
    Georgia2(Georgia2<0)=NaN;
    demcmap(Georgia2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 25 % Massachusetts
        latlim = [ 41  43]; 
        lonlim = [ -74 -70];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedWestMassachusettsDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Massacusetts
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==16)
        %     [A16,R16] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==17)
        %     [A17,R17] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==18)
        %     [A18,R18] = readgeoraster(nowFile,OutputType="double");
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for WesternMass');
    disp(dispstr)
    [WMassachusetts,WMassachusettsRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='WMassachusetts WMassachusettsRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Massachusetts,MassachusettsRB)
    geoshow(Massachusetts,MassachusettsRB,DisplayType="surface")
    demcmap(WMassacusetts);
    maxht=max(max(WMassachusetts));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 41 % Oregon
        latlim = [ 41  47]; 
        lonlim = [ -125 -116];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedOregonDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        elseif(n==61)
            [A61,R61] = readgeoraster(nowFile,OutputType="double");
        elseif(n==62)
            [A62,R62] = readgeoraster(nowFile,OutputType="double");
        elseif(n==63)
            [A63,R63] = readgeoraster(nowFile,OutputType="double");
        elseif(n==64)
            [A64,R64] = readgeoraster(nowFile,OutputType="double");
        elseif(n==65)
            [A65,R65] = readgeoraster(nowFile,OutputType="double");
        elseif(n==66)
            [A66,R66] = readgeoraster(nowFile,OutputType="double");
        elseif(n==67)
            [A67,R67] = readgeoraster(nowFile,OutputType="double");
        elseif(n==68)
            [A68,R68] = readgeoraster(nowFile,OutputType="double");
        elseif(n==69)
            [A69,R69] = readgeoraster(nowFile,OutputType="double");
        elseif(n==70)
            [A70,R70] = readgeoraster(nowFile,OutputType="double");

        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Oregon');
    disp(dispstr)
  
    [Oregon,OregonRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
          A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,...
          A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,A57,R57,A58,R58,A59,R59,A60,R60,...
          A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,A67,R67,A68,R68,A69,R69,A70,R70);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Oregon OregonRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Oregon,OregonRB)
    geoshow(Oregon,OregonRB,DisplayType="surface")
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Oregon2=Oregon;
    Oregon2(Oregon2<0)=NaN;
    demcmap(Oregon2,64,cmapland);
    demcmap(Oregon);
    maxht=max(max(Oregon));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 47 % Tennessee
        latlim = [ 34  37]; 
        lonlim = [ -91 -81];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedTenesseeDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");


        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Tenessee');
    disp(dispstr)
  
    [Tennessee,TennesseeRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
          A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Tennessee TennesseeRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Tennessee,TennesseeRB)
    geoshow(Tennessee,TennesseeRB,DisplayType="surface")
    demcmap(Tennessee);
    maxht=max(max(Tennessee));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 53 % Washington
        latlim = [ 45  50]; 
        lonlim = [ -125 -116];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedWashingtonDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");

        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Oregon');
    disp(dispstr)
      [Washington,WashingtonRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
         A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14);
    % [Washington,WashingtonRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
    %       A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
    %       A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
    %       A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Washington WashingtonRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Washington,WashingtonRB)
    geoshow(Washington,WashingtonRB,DisplayType="surface")
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Washingto2=Washington;
    Washington2(Washington<0)=NaN;
    demcmap(Washington2,64,cmapland);
    demcmap(Washington);
    maxht=max(max(Washington));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    otherwise
        disp('Logic not written for this fips code')

end 