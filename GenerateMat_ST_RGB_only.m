clear all;
close all;
clc;
basePath=''; % path for short-term dataset 

resultPath='./BBresults_VTUAV_RGB/';

sequences=dir(basePath);
sequences={sequences.name};
sequences=sequences(3:end);

% trackers = {'SiamRPN++','SiamRPN','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++',...
%     'LightTrack','LTMU','Ocean','RTMDNet','SiamFC','SiamTPN','SPLT','TransT'};

trackers = {'SiamRPN++','SiamRPN','AlphaRefine','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++','SwinTrack',...
   'KeepTrack','LightTrack','LTMU','Ocean','PrDiMP','RTMDNet','SiamFC','SiamTPN','SPLT','TCTrack','TransT','HMFT'};

% trackers = {'DiMP-RGB','DiMP-T'};

bPlot=0;

calcPlotErr_TPR_RGB_only(sequences, trackers,  bPlot, basePath, resultPath);