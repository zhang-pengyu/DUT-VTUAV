clear all;
close all;
clc;
basePath='/media/zpy/zpy_2T_t7_2/VTUAV/test/short-term/';

% resultPath='./BBResults_CVPR22/';
% resultPath='./BBResults_CVPR22_ablation/';
resultPath='./BBresults_VTUAV_RGB/';
sequences=dir(basePath);
sequences={sequences.name};
sequences=sequences(3:end);

%% CVPR2022
% trackers = {'Dimp50-RGB','Dimp50-T','mfDIMP','DIMP50-RGB-train','DIMP50-T-train','DIMP50-IF','DIMP50-FF'};
% trackers = {'TransT','RTMDNet','DAFNet','ADRNet','mfDIMP','FSRPN','DiMP+CIF+DFF+ADF'};
% trackers = {'SiamRPN++','SiamRPN','SiamBAN','ECO','ATOM','d3s','DiMP+CIF+DFF+ADF'};
trackers = {'SiamRPN++','SiamRPN','AlphaRefine','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++','SwinTrack',...
    'KeepTrack','LightTrack','LTMU','Ocean','PrDiMP','RTMDNet','SiamFC','SiamTPN','SPLT','TCTrack','TransT','HMFT'};
%% ablation
% trackers = {'DiMP+CIF','DiMP+CIF+DFF+ADF','DiMP+DFF','DiMP-RGB','DiMP-T','DiMP+CIF+DFF'};

%% test
% trackers = {'all_test_30','all_test_35','all_test_40','all_test_45','all_test_50'};
% trackers = {'all_test_50_new','all_test_45_new'};
% trackers = {'1','2','3','4','5','6','7','8','9','10','11'};
% trackers = {'SiamMask'}; %,'SiamMask'
% trackers = {'simple_late'};
bPlot=0;

calcPlotErr_TPR(sequences, trackers,  bPlot, basePath, resultPath);