function CreateERA5ItalyMasks()
% Create masks for Italy and Italian Provinces for the ERA5 grid
% Written By: Stephen Forczyk
% Created: April 9,2024
% Revised: 
% Classification: Unclassified/Public Domain

global ItalyRainFallFile;
global ItalyPrecipLats ItalyPrecipLons ItalyPrecipTimes ItalyRasterAreas;
global ItalyTotPrecip ItalySliceTimes RainFallFiles;
global ItalyRasterDataFile;
global StatValues framecounter;
global numRainFallFiles RainFallConstantsFile nowFile;
global idecode iCityPlot;
global westEdge eastEdge northEdge southEdge Rpix;
global VenetoProvinceLat VenetoProvinceLon AbruzzoProvinceLat AbruzzoProvinceLon;
global ApuliaProvinceLat ApuliaProvinceLon BasilicataProvinceLat BasilicataProvinceLon;
global CalabriaProvinceLat CalabriaProvinceLon CampaniaProvinceLat CampaniaProvinceLon ;
global EmiliaProvinceLat EmiliaProvinceLon FriuliProvinceLat FriuliProvinceLon;
global LazioProvinceLat LazioProvinceLon LiguriaProvinceLat LiguriaProvinceLon;
global LombardiaProvinceLat LombardiaProvinceLon MarcheProvinceLat MarcheProvinceLon;
global MoliseProvinceLat MoliseProvinceLon PiemonteProvinceLat PiemonteProvinceLon;
global SardegnaProvinceLat SardegnaProvinceLon SicilyProvinceLat SicilyProvinceLon;
global ToscanaProvinceLat ToscanaProvinceLon TrentinoProvinceLat TrentinoProvinceLon;
global UmbriaProvinceLat UmbriaProvinceLon VallaProvinceLat VallaProvinceLon;
global ERA5ItalyMask ERA5VenetoProvinceMask ERA5AbruzzoProvinceMask ERA5ApuliaProvinceMask;
global ERA5BasilicataProvinceMask ERA5CalabriaProvinceMask ERA5CampaniaProvinceMask;
global ERA5EmiliaProvinceMask ERA5FriuliProvinceMask ERA5LazioProvinceMask ERA5LiguriaProvinceMask;
global ERA5LombardiaProvinceMask ERA5MarcheProvinceMask ERA5MoliseProvinceMask ERA5PiemonteProvinceMask;
global ERA5SardegnaProvinceMask ERA5SicilyProvinceMask ERA5ToscanaProvinceMask ERA5TrentinoProvinceMask;
global ERA5UmbriaProvinceMask ERA5VallaProvinceMask;

global matpath datapath maskpath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath maskpath boundarypath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;



% mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
% maskpath='K:\Merra-2\Masks\';
% boundarypath='D:\Forczyk\Map_Data\Matlab_Maps_New\';
[numlon,numlat]=size(ItalyPrecipLats);

%% load the country borders and plot them-start with Italy
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ItalyBoundaries','ItalyLat','ItalyLon');
% ab=2;
% for i=1:numlon
%     for j=1:numlat
%     xqq=ItalyPrecipLons(i,j);
%     yqq=ItalyPrecipLats(i,j);
%     [in,~]=inpolygon(xqq,yqq,ItalyLon,ItalyLat);
%     ab=4;
%     ERA5ItalyMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
ab=3;
%% load the county borders for Abruzzo Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5AbruzzoProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,AbruzzoProvinceLon,AbruzzoProvinceLat);
%         ERA5AbruzzoProvinceMask(i,j)=in;
%     end
%     ERA5AbruzzoProvinceMask=logical(ERA5AbruzzoProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5AbruzzoProvinceMask';
% MatFileName='ERA5AbruzzoProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% warning('off');
% ab=1;
%% load the county borders for Veneto Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5VenetoProvinceMask=zeros(570,652);
% numpts=length(VenetoProvinceLon);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,VenetoProvinceLon,VenetoProvinceLat);
%         ab=4;
%         ERA5VenetoProvinceMask(i,j)=in;
%     end
%     ERA5VenetoProvinceMask=logical(ERA5VenetoProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
%% load the county borders for Abruzzo Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5AbruzzoProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,AbruzzoProvinceLon,AbruzzoProvinceLat);
%         ERA5AbruzzoProvinceMask(i,j)=in;
%     end
%     ERA5AbruzzoProvinceMask=logical(ERA5AbruzzoProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5AbruzzoProvinceMask';
% MatFileName='ERA5AbruzzoProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% warning('off');
% ab=1;
%% load the county borders for Apulia Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5ApuliaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,ApuliaProvinceLon,ApuliaProvinceLat);
%         ERA5ApuliaProvinceMask(i,j)=in;
%     end
%     ERA5ApuliaProvinceMask=logical(ERA5ApuliaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Apulia Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5ApuliaProvinceMask';
% MatFileName='ERA5ApuliaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% warning('off');
ab=1;
%% load the county borders for Basilicata Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5BasilicataProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,BasilicataProvinceLon,BasilicataProvinceLat);
%         ERA5BasilicataProvinceMask(i,j)=in;
%     end
%     ERA5BasilicataProvinceMask=logical(ERA5BasilicataProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Basilicata Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5BasilicataProvinceMask';
% MatFileName='ERA5BasilicataProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Calabria Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5CalabriaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,CalabriaProvinceLon,CalabriaProvinceLat);
%         ERA5CalabriaProvinceMask(i,j)=in;
%     end
%     ERA5CalabriaProvinceMask=logical(ERA5CalabriaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Calabria Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5CalabriaProvinceMask';
% MatFileName='ERA5CalabriaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Campania Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5CampaniaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,CampaniaProvinceLon,CampaniaProvinceLat);
%         ERA5CampaniaProvinceMask(i,j)=in;
%     end
%     ERA5CampaniaProvinceMask=logical(ERA5CampaniaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Campania Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5CampaniaProvinceMask';
% MatFileName='ERA5CampaniaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Emilia Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5EmiliaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,EmiliaProvinceLon,EmiliaProvinceLat);
%         ERA5EmiliaProvinceMask(i,j)=in;
%     end
%     ERA5EmiliaProvinceMask=logical(ERA5EmiliaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Emilia Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5EmiliaProvinceMask';
% MatFileName='ERA5EmiliaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Friuli Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5FriuliProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,FriuliProvinceLon,FriuliProvinceLat);
%         ERA5FriuliProvinceMask(i,j)=in;
%     end
%     ERA5FriuliProvinceMask=logical(ERA5FriuliProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Friuli Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5FriuliProvinceMask';
% MatFileName='ERA5FriuliProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Liguria Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5LiguriaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,LiguriaProvinceLon,LiguriaProvinceLat);
%         ERA5LiguriaProvinceMask(i,j)=in;
%     end
%     ERA5LiguriaProvinceMask=logical(ERA5LiguriaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Liguria Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5LiguriaProvinceMask';
% MatFileName='ERA5LiguriaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Lazio Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5LazioProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,LazioProvinceLon,LazioProvinceLat);
%         ERA5LazioProvinceMask(i,j)=in;
%     end
%     ERA5LazioProvinceMask=logical(ERA5LazioProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Lazio Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5LazioProvinceMask';
% MatFileName='ERA5LazioProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Lombardia Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5LombardiaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,LombardiaProvinceLon,LombardiaProvinceLat);
%         ERA5LombardiaProvinceMask(i,j)=in;
%     end
%     ERA5LombardiaProvinceMask=logical(ERA5LombardiaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Lombardia Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5LombardiaProvinceMask';
% MatFileName='ERA5LombardiaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Marche Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5MarcheProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,MarcheProvinceLon,MarcheProvinceLat);
%         ERA5MarcheProvinceMask(i,j)=in;
%     end
%     ERA5MarcheProvinceMask=logical(ERA5MarcheProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Marche Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5MarcheProvinceMask';
% MatFileName='ERA5MarcheProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Molise Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5MoliseProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,MoliseProvinceLon,MoliseProvinceLat);
%         ERA5MoliseProvinceMask(i,j)=in;
%     end
%     ERA5MoliseProvinceMask=logical(ERA5MoliseProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Molise Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5MoliseProvinceMask';
% MatFileName='ERA5MoliseProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Piemonte Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5PiemonteProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,PiemonteProvinceLon,PiemonteProvinceLat);
%         ERA5PiemonteProvinceMask(i,j)=in;
%     end
%     ERA5PiemonteProvinceMask=logical(ERA5PiemonteProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Piemonte Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5PiemonteProvinceMask';
% MatFileName='ERA5PiemonteProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Sardegna Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5SardegnaProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,SardegnaProvinceLon,SardegnaProvinceLat);
%         ERA5SardegnaProvinceMask(i,j)=in;
%     end
%     ERA5SardegnaProvinceMask=logical(ERA5SardegnaProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Sardegna Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5SardegnaProvinceMask';
% MatFileName='ERA5SardegnaProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Sicily Province
% eval(['cd ' mappath(1:length(mappath)-1)]);
% ERA5SicilyProvinceMask=zeros(570,652);
% for i=1:numlon
%     for j=1:numlat
%         xqq=ItalyPrecipLons(i,j);
%         yqq=ItalyPrecipLats(i,j);
%         [in]=inpolygon(xqq,yqq,SicilyProvinceLon,SicilyProvinceLat);
%         ERA5SicilyProvinceMask(i,j)=in;
%     end
%     ERA5SicilyProvinceMask=logical(ERA5SicilyProvinceMask);
%     dispstr=strcat('finished with lon#',num2str(i),'-for Sicily Province');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='ERA5SicilyProvinceMask';
% MatFileName='ERA5SicilyProvince';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% load the county borders for Toscana Province
eval(['cd ' mappath(1:length(mappath)-1)]);
ERA5ToscanaProvinceMask=zeros(570,652);
for i=1:numlon
    for j=1:numlat
        xqq=ItalyPrecipLons(i,j);
        yqq=ItalyPrecipLats(i,j);
        [in]=inpolygon(xqq,yqq,ToscanaProvinceLon,ToscanaProvinceLat);
        ERA5ToscanaProvinceMask(i,j)=in;
    end
    ERA5ToscanaProvinceMask=logical(ERA5ToscanaProvinceMask);
    dispstr=strcat('finished with lon#',num2str(i),'-for Toscana Province');
    disp(dispstr)
end
eval(['cd ' maskpath(1:length(maskpath)-1)]);
actionstr='save';
varstr='ERA5ToscanaProvinceMask';
MatFileName='ERA5SToscanaProvince';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Matlab File-',MatFileName);
disp(dispstr);
%% load the county borders for Trentino Province
eval(['cd ' mappath(1:length(mappath)-1)]);
ERA5TrentinoProvinceMask=zeros(570,652);
for i=1:numlon
    for j=1:numlat
        xqq=ItalyPrecipLons(i,j);
        yqq=ItalyPrecipLats(i,j);
        [in]=inpolygon(xqq,yqq,TrentinoProvinceLon,TrentinoProvinceLat);
        ERA5TrentinoProvinceMask(i,j)=in;
    end
    ERA5TrentinoProvinceMask=logical(ERA5TrentinoProvinceMask);
    dispstr=strcat('finished with lon#',num2str(i),'-for Trentino Province');
    disp(dispstr)
end
eval(['cd ' maskpath(1:length(maskpath)-1)]);
actionstr='save';
varstr='ERA5TrentinoProvinceMask';
MatFileName='ERA5TrentinoProvince';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Matlab File-',MatFileName);
disp(dispstr);
%% load the county borders for Umbria Province
eval(['cd ' mappath(1:length(mappath)-1)]);
ERA5UmbriaProvinceMask=zeros(570,652);
for i=1:numlon
    for j=1:numlat
        xqq=ItalyPrecipLons(i,j);
        yqq=ItalyPrecipLats(i,j);
        [in]=inpolygon(xqq,yqq,UmbriaProvinceLon,UmbriaProvinceLat);
        ERA5UmbriaProvinceMask(i,j)=in;
    end
    ERA5UmbriaProvinceMask=logical(ERA5UmbriaProvinceMask);
    dispstr=strcat('finished with lon#',num2str(i),'-for Umbria Province');
    disp(dispstr)
end
eval(['cd ' maskpath(1:length(maskpath)-1)]);
actionstr='save';
varstr='ERA5UmbriaProvinceMask';
MatFileName='ERA5SUmbriaProvince';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Matlab File-',MatFileName);
disp(dispstr);
%% load the county borders for Valla Province
eval(['cd ' mappath(1:length(mappath)-1)]);
ERA5VallaProvinceMask=zeros(570,652);
for i=1:numlon
    for j=1:numlat
        xqq=ItalyPrecipLons(i,j);
        yqq=ItalyPrecipLats(i,j);
        [in]=inpolygon(xqq,yqq,VallaProvinceLon,VallaProvinceLat);
        ERA5VallaProvinceMask(i,j)=in;
    end
    ERA5VallaProvinceMask=logical(ERA5VallaProvinceMask);
    dispstr=strcat('finished with lon#',num2str(i),'-for Valla Province');
    disp(dispstr)
end
eval(['cd ' maskpath(1:length(maskpath)-1)]);
actionstr='save';
varstr='ERA5VallaProvinceMask';
MatFileName='ERA5VallaProvince';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Matlab File-',MatFileName);
disp(dispstr);
warning('off');
ab=1;










warning('on')
ab=3;