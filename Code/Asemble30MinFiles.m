function [EI30x,SumKE,ER,VR,maxI30,sumRainFallAmt,teststr1] = Asemble30MinFiles(startctr)
% This function will assemble 6 4 minute samples into a 30 minute sample
% Written By: Stephen Forczyk/Joydeb Saha  
% Created: May 3,2024
% Revised: May 4,2024 starting to save values-still just a test
% Revised: May 7,2024 added definition of variables

global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallTime RainFallFlag RainFallAmt RainFallName;
global ProvinceNames;
global numtimesstep SelectedYears SelStartIndex SelEndIndex;

global nowFlags nowRainFallAmt nowTimes
global eventctr norainctr;
% Definition of Variables
% RainFallAmt   RainFall in mm/hr
% RainFall Flag  dimensionless but not sure what flag represents
EI30x=0;
SUMKE=0;
ER=0;
VR=0;
maxI30=0;
sumRainFallAmt=0;
nowFlags=zeros(6,1);
nowRainFallAmt=zeros(6,1);
nowTimes=cell(6,1);
KE5=zeros(6,1);
ER=zeros(6,1);
ik=0;
teststr1=(RainFallTime(startctr));
nowstr1=char(teststr1);
% Grab six 5 minutes samples to create a 30 minute sample
for i=startctr:startctr+5
    ik=ik+1;
    nowFlags(ik,1)=RainFallFlag(i,1);
    nowRainFallAmt(ik,1)=RainFallAmt(i,1);
    if(nowRainFallAmt(ik,1)>0)
        KE5(ik,1)=0.119 + .0873*log10(nowRainFallAmt(ik,1));
    end
    teststr=(RainFallTime(i));
    nowstr=char(teststr);
    nowTimes{ik,1}=nowstr;
end
maxI30=max(nowRainFallAmt);
sumRainFallAmt=sum(nowRainFallAmt);
ER=0.29*(1-0.72*exp(-0.05*sumRainFallAmt));
SumKE=sum(KE5);
if(sumRainFallAmt>1E-7)
    eventctr=eventctr+1;
else
    norainctr=norainctr+1;
end
ab=1;
end