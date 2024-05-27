function FindRainFallBreakPointsRev2(izero,ibig)
% This routine will look at the array of points that have 0 rainfall
% A break point will occur when the number of consecutive values with zero
% equals a set value (StormBreakThresh).The area between break points will be used to
% calculate rain fall amounts for a given storm. Based on function FindRainFallBreakPoints
% whch is not working correctly
%
% The basic functionality is to work through all the detections one at a
% time and then find for each detection the nearest stretch of data where
% 72 zeros occur in a row to terminate that storm
%
% Written By: Stephen Forczyk / Joyded Saha
% Created: May 14,2024
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


% Initialization
numzero=length(izero);
numstop=izero(numzero);
numbig=length(ibig);
numpts=length(RainFallAmt);
istormctr=0;
inRow=0;
BreakPoints2=zeros(numbig,8);
stopIndex=ibig(1);
ab=3;
ictr=0;
startIndex=ibig(1);
ilastrain=0;
nowSum=0;
% On the first pass establish the number of break points
for i=1:numbig % March through the rain detections
      if(i>1)
          startIndex=endIndex+1;
      end

    inRow=0;
    irain=0;
    iThresh=0;
    idry=0;
    nowSum=0;
    for m=startIndex:numstop
        nowVal=RainFallAmt(m,1);
        if(nowVal>0)
            inRow=0;
            irain=irain+1;
            ilastrain=m;
            nowSum=nowSum+nowVal;
        else
            idry=idry+1;
            inRow=inRow+1;
        end
        if(nowVal>StormThresh15)
            iThresh=iThresh+1;
        end
        if(inRow>72)
            stopIndex=m;
            break
        end
        stopIndex=m;
    end
    endIndex=stopIndex;
    ictr=ictr+1;
    BreakPoints2(ictr,1)=ictr;
    BreakPoints2(ictr,2)=irain;
    BreakPoints2(ictr,3)=idry;
    BreakPoints2(ictr,4)=iThresh;
    BreakPoints2(ictr,5)=ilastrain;
    BreakPoints2(ictr,6)=nowSum;
    BreakPoints2(ictr,7)=startIndex;
    BreakPoints2(ictr,8)=stopIndex;
    while endIndex<(numstop-144)
    ab=1;
    break
    end
end
% Now that the number of breakpoints have been established
% set up an array to record the data
BreakPoints=zeros(istormctr,8);
[mstorms]=find(BreakPoints2(:,6)>0);
maxstorms=length(mstorms);
istormctr=0;
% Create the final Breakpoints array with all cases with segements with no
% rain removed
for k=1:maxstorms
    nowInd=mstorms(k);
    istormctr=istormctr+1;
    for j=1:8
        BreakPoints(istormctr,j)=BreakPoints2(nowInd,j);
    end

end

ab=2;
end