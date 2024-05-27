function [val50,val75,val90,val92,val95,val96,val97,val98,val99,val100,fraclow,frachigh,fracNaN] = GetRainDistributionStats(inArray,lowcutoff,highcutoff)
% This function will return some crude statistics of the 2 D array
% distribution and a count of values that are below and above the valid
% ranges. Remove out of range or NaN values from the calculations
% This was based on the function GetDistributionStats but modified to
% change the output values. Rather than have values from 10% to 100% ptile'
% levels the idea was to concentrate the values between 50 and 100%
% Written By: Stephen Forczyk
% Created: April 20,2024
% Revised: 
% Classification: Public Domain/Unclassified
global FillValue;
[nrows,ncols]=size(inArray);
ntotal=nrows*ncols;
% Find the fraction of low values'
[ilow,~]=find(inArray<lowcutoff);
a1=isempty(ilow);
if(a1==1)
    fraclow=0;
else
    fraclow=length(ilow)/ntotal;
end
% Find the fraction of high values'
[ihigh,~]=find(inArray>highcutoff);
a1=isempty(ihigh);
if(a1==1)
    frachigh=0;
else
    frachigh=length(ihigh)/ntotal;
end
% % find those values that fall within the low or high cutoff ranges and
% that are non NaN
[ibad,jbad]=find(inArray<lowcutoff | inArray>highcutoff);
numbad=length(ibad);
FixedArray=inArray;
for ii=1:numbad
    for jj=1:numbad
        inow=ibad(ii,1);
        jnow=jbad(jj,1);
        nowVal=inArray(inow,jnow);
        if(nowVal<lowcutoff)
            nowVal=lowcutoff;
        elseif((nowVal>highcutoff) || (nowVal>.99*FillValue))
            nowVal=NaN;
        end
        FixedArray(inow,jnow)=nowVal;
    end
end
% See if there are any nan values
NaNArray=isnan(FixedArray);
totalNaN=sum(sum(NaNArray));
if(totalNaN==0)
    fracNaN=0;
else
    fracNaN=totalNaN/ntotal;
    ntotal=ntotal-totalNaN;
end
% Now collapse this a a 1 D array and sort
Fixed1DArray=reshape(FixedArray,nrows*ncols,1);
Fixed1DSortArray=sort(Fixed1DArray);
num50=round(.50*ntotal);
num75=round(.75*ntotal);
num90=round(.90*ntotal);
num92=round(.92*ntotal);
num95=round(.95*ntotal);
num96=round(.96*ntotal);
num97=round(.97*ntotal);
num98=round(.98*ntotal);
num99=round(.99*ntotal);
num100=ntotal;
val50=Fixed1DSortArray(num50,1);
val75=Fixed1DSortArray(num75,1);
val90=Fixed1DSortArray(num90,1);
val92=Fixed1DSortArray(num92,1);
val95=Fixed1DSortArray(num95,1);
val96=Fixed1DSortArray(num96,1);
val97=Fixed1DSortArray(num97,1);
val98=Fixed1DSortArray(num98,1);
val99=Fixed1DSortArray(num99,1);
val100=Fixed1DSortArray(num100,1);

end