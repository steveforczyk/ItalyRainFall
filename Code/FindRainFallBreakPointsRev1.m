function FindRainFallBreakPointsRev1(izero,ibig)
% This routine will look at the array of points that have 0 rainfall
% A break point will occur when the number of consecutive values with zero
% equals a set value (StormBreakThresh).The area between break points will be used to
% calculate rain fall amounts for a given storm. Based on function FindRainFallBreakPoints
% whch is not working correctly
%
% Written By: Stephen Forczyk / Joyded Saha
% Created: May 13,2024
% Revised:
% Classification: Unclassified/Oublic Domain

global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallFile3 RainFallFile3C S;
global StationStr StationNum RainFallFile RainFallCatalogedFile;
global RainFallTime RainFallFlag RainFallAmt RainFallName;



global ProvinceNames RainFallTime30 I30max;
global PotentialStorms ConsolidatedStorm  DefinedStorms BreakPoints;
global PS2 PS3 PS4 PS5 PS6 PS7 PS8 PS9 PS10 PS11 PS12 PS13 PS14 PS15 PS16;
global SPS2 SPS3 SPS4 SPS5 SPS6 SPS7 SPS8 SPS9 SPS10 SPS11 SPS12 SPS13 SPS14 SPS15 SPS16;
global numtimesstep SelectedYears SelStartIndex SelEndIndex numused numedused30;
global StormThreshTot StormThresh360 StormThresh15 StormBreakThresh;
global firstyearstr firstyear firstdaystr firstday firstmonthstr;
global firsthrstr firsthr firstminstr firstmin firstsecstr firstsec;
global lastyearstr lastyear lastdaystr lastday lastmonthstr;
global lasthrstr lasthr lastminstr lastmin lastsecstr lastsec;
global FoundData icataloged eventctr norainctr;
global I30 SumRain30 SUMKE30 ER30 VR30 KEnergy RainRate;
global RFactorTable RFactorTT DiagTable DiagTT;
global PotentialStormsTable PotentialStormsTT;
global PotentialStorms2Table PotentialStorms2TT;

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
global isumhourlyfiles sf1;% sf1 is the scale factor to go from kg/m^2 to inches of water

BreakPoints=0;
numzero=length(izero);
istormctr=0;
inRow=0;
ilast=izero(1,1);
ZeroSpacing=zeros(numzero,3);
maxdiff=1;
maxrow=0;
for i=2:numzero
    index2=izero(i,1);
    index1=izero(i-1,1);
    idiff=index2-index1;
    inRow=inRow+1;
    if(inRow>StormBreakThresh)
        istormctr=istormctr+1;
        ZeroSpacing(istormctr,1)=inRow;
        ZeroSpacing(istormctr,2)=index1;
        ZeroSpacing(istormctr,3)=index2;
        inRow=0;
    end
%         maxdiff=idiff;
%         maxrow=index1;
%    end
end
ab=3;
% On the first pass establish the number of break points
for i=2:numzero
    index2=izero(i,1);
    index1=izero(i-1,1);
    idiff=index2-index1;
    if(idiff==1)
        inRow=inRow+1;
        ilast=index2;
    elseif(inRow>=StormBreakThresh)
        istormctr=istormctr+1;
        ilast=index2;
        inRow=0;
    end

end
% Now that the number of breakpoints have been established
% set up an array to record the data
BreakPoints=zeros(istormctr,6);
istormctr=0;
inRow=0;
for i=2:numzero
    index2=izero(i,1);
    index1=izero(i-1,1);
    idiff=index2-index1;
    if(idiff==1)
        inRow=inRow+1;
        ilast=index2;
    elseif(inRow>=StormBreakThresh)
        istormctr=istormctr+1;
        ilast=index2;
        BreakPoints(istormctr,1)=istormctr;
        BreakPoints(istormctr,2)=index1;
        BreakPoints(istormctr,3)=index2;
        BreakPoints(istormctr,4)=inRow;
        BreakPoints(istormctr,5)=index1+1;
        [ihit]=find(ibig>index2);
        numhit=length(ihit);
        if(numhit>=1)
            nowindex=ihit(1);
            startind=ibig(nowindex) + 1;
        else
            nowindex=1;
            startind=1;
        end
        BreakPoints(istormctr,6)=startind;
        inRow=0;
    end

end
ab=2;
end