clear all;
close all;
clc;
basePath='/media/zpy/zpy_2T_t7_2/VTUAV/test/long-term/';

% resultPath='./BBResults_CVPR22_LT/';
resultPath='./BBresults_VTUAV_RGB/';

sequences=dir(basePath);
sequences={sequences.name};
sequences=sequences(3:end);

%% CVPR2022
% trackers = {'DIMP_LTMU','GlobalTrack','SPLT','DiMP_LTMU_RGBT','mfDiMP','ADRNet','FSRPN','HMFT_LT','HMFT_LT_test','HMFT_LT_test1','HMFT_LT_test2'};
% trackers = {'SiamRPN++','SiamRPN','SiamBAN','ECO','ATOM','D3S','SiamMask','HMFT_LT','HMFT_LT_test2'};

% trackers = {'SiamRPN++','SiamRPN','AlphaRefine','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++','SwinTrack',...
%     'KeepTrack','LightTrack','LTMU','Ocean','PrDiMP','RTMDNet','SiamFC','SiamTPN','SPLT','TCTrack','TransT','HMFT'};

trackers = {'SiamRPN++','SiamRPN','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++',...
    'LightTrack','LTMU','Ocean','RTMDNet','SiamFC','SiamTPN','SPLT','TransT'};

%% test
% trackers = {'};


% trackers = {'RTMDNet-IF','RTMDNet-FF','RTMDNet-LF'};

bPlot=0;

calcPlotErr_TPR_RGB_only(sequences, trackers,  bPlot, basePath, resultPath);