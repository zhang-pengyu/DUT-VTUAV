%�������OCC	 BC CM DEF FM HO LI LR MB NO PO SV TC ALL ����Ӧ��precision��success����
close all;
clear all;
clc;
pixelThreshold=20;


load('AttrMat_ST.mat');

basePath='/media/zpy/zpy_2T_t7_2/VTUAV/test/short-term/';
resultMatPath='./ERRresults/';

attrDisplays = {'ALL'};%  BC CM DEF FM HO LI LR MB NO PO SV TC ALL
% attrDisplays={'BC','CM','DEF','FM','OV','EI','LR','TB','TVS','PO','SV','TC','FO','ALL'};


% algs = {'SiamRPN++','SiamRPN','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++',...
%     'LightTrack','LTMU','Ocean','RTMDNet','SiamFC','SiamTPN','SPLT','TransT'};

% algs = {'SiamRPN++','SiamRPN','AlphaRefine','ATOM','D3S','DiMP','ECO','GlobalTrack','HiFT','STARK','SiamAPN++','SwinTrack',...
%     'KeepTrack','LightTrack','LTMU','Ocean','PrDiMP','RTMDNet','SiamFC','SiamTPN','SPLT','TCTrack','TransT','HMFT'};

algs = {'DiMP-RGB','DiMP-T'};

colorStyle(:,:,1)=[1,0,0];colorStyle(:,:,2)=[0,0,1];colorStyle(:,:,3)=[0,1,0];colorStyle(:,:,4)=[0,1,1];colorStyle(:,:,5)=[1,0,1];
colorStyle(:,:,6)=[1,1,0];colorStyle(:,:,7)=[0.5,0,0];colorStyle(:,:,8)=[0,0.5,0];colorStyle(:,:,9)=[0,0,0.5];
colorStyle(:,:,10)=[0,0.5,0.5];colorStyle(:,:,11)=[0.5,0,0.5];colorStyle(:,:,12)=[0.5,0.5,0];colorStyle(:,:,13)=[0,0,0];

colorStyle(:,:,14)=[1,0,0];colorStyle(:,:,15)=[0,0,1];colorStyle(:,:,16)=[0,1,0];colorStyle(:,:,17)=[0,1,1];colorStyle(:,:,18)=[1,0,1];
colorStyle(:,:,19)=[1,1,0];colorStyle(:,:,20)=[0.5,0,0];colorStyle(:,:,21)=[0,0.5,0];colorStyle(:,:,21)=[0,0,0.5];
colorStyle(:,:,22)=[0,0.5,0.5];colorStyle(:,:,23)=[0.5,0,0.5];colorStyle(:,:,24)=[0.5,0.5,0];colorStyle(:,:,25)=[0,0,0];

lineStyle(:,:,1:13)='-';
lineStyle(:,:,14:25)=':';



sequencesAll=dir(basePath);
sequencesAll={sequencesAll.name};
sequencesAll=sequencesAll(3:end);

%�õ���Щ��AttrName������
for attr = 1:numel(attrDisplays)
    attrDisplay = attrDisplays{attr};
    sequences={};
    if strcmp(attrDisplay,'ALL')==1
        sequences=sequencesAll;        
    else
        for seqIndex=1:length(sequencesAll)         
            idx=find(strcmp(attrs.SequencesName, sequencesAll{seqIndex})==1);
            switch attrDisplay
                case 'BC'
                    if attrs.BC(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Background Clutter';
                    end
                    
                case 'CM'
                    if attrs.CM(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Camera Moving';
                    end
                case 'DEF'
                    if attrs.DEF(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Deformation';
                    end
                case 'TVS'
                    if attrs.TVS(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Thermal Visible Separation';
                    end
                case 'FM'
                    if attrs.FM(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Fast Motion';
                    end
                case 'OV'
                    if attrs.OV(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Out-of-View';
                    end
                case 'EI'
                    if attrs.EI(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Extreme Illumination';
                    end
                case 'LR'
                    if attrs.LR(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Low Resolution';
                    end
                case 'TB'
                    if attrs.TB(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Target Blur';
                    end
                case 'FO'
                    if attrs.FO(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Full Occlusion';
                    end
                case 'PO'
                    if attrs.PO(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Partial Occlusion';
                    end
                case 'SV'
                    if attrs.SV(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Scale Variation';
                    end
                case 'TC'
                    if attrs.TC(idx)==1
                        sequences{end+1}=sequencesAll{seqIndex};
                        attrName = 'Thermal Clustering';
                    end
            end
        end
    end
    
    
    disp([attrDisplay  ' seqNum:'  int2str(length(sequences))]);
    
    
    precisionX=0:1:50;
    successX=0:0.05:1;
    precisionY=zeros([size(precisionX,2) size(algs,2)]);
    successY=zeros([size(successX,2) size(algs,2)]);
    allFramesNum=0;
    
    for algIndex=1:size(algs,2)
        for seqIndex=1:size(sequences,2)
            results(seqIndex)=load([resultMatPath algs{algIndex} '/' algs{algIndex} '_' sequences{seqIndex} '.mat']);
            curr_frame_num=size(results(seqIndex).err,1);
            allFramesNum=allFramesNum+curr_frame_num;
            for j=1:size(precisionX,2)
                precisionY(j,algIndex)=precisionY(j,algIndex)+sum(results(seqIndex).errCenter<=precisionX(j))./curr_frame_num;
                MPR(seqIndex,algIndex) = sum(results(seqIndex).errCenter<=20)./curr_frame_num;
            end
            temp = 0;
            for j=1:size(successX,2)
                successY(j,algIndex)=successY(j,algIndex)+sum(results(seqIndex).err>successX(j))./curr_frame_num;
                temp = sum(results(seqIndex).err>successX(j))./curr_frame_num +temp;
            end
            MSR(seqIndex,algIndex) = temp/size(successX,2);
        end
    end


    disp([attrDisplay 'FrameNum:' int2str(allFramesNum/length(algs))]);
    allFramesNum=allFramesNum/size(algs,2);
    seq_num = size(sequences,2);
    
    %.................................................................................
    %precision Plot
    %.................................................................................
    
    precisionY=precisionY./seq_num;
    precisionthr(1:size(algs,2))=precisionY(pixelThreshold+1,1:size(algs,2));
    [~,precisionIndex]=sort(precisionthr,'descend');
    
    h1=figure('Name',attrDisplay);
    for trackerIndex=1:size(algs,2)
        
        plot(precisionX,precisionY(:,precisionIndex(trackerIndex))','color',colorStyle(:,:,trackerIndex),'LineWidth',3,'LineStyle',lineStyle(:,:,trackerIndex));
        hold on
        precision=sprintf('%.3f', precisionY(pixelThreshold+1,precisionIndex(trackerIndex)));
        legendLabel{trackerIndex}=[algs{precisionIndex(trackerIndex)} '[' precision ']'];
    end
    
    if strcmp(attrDisplay,'ALL')~=1
        title([' Precision Plot - ',attrName]);
    else
        title('Precision Plot','FontSize',12,'FontName','Times New Roman');
    end
    xlabel('Location Error Threshold','FontSize',12,'FontName','Times New Roman')
    ylabel('Precision Rate','FontSize',12,'FontName','Times New Roman')
    legend(legendLabel,'Location','northwest','FontSize',8,'FontName','Times New Roman');  %southeast
    axis([0 50 0 1]);  
    figName = ['./figsResults/',attrDisplay,'_PR'];
    saveas(gcf,figName,'fig');
    
    
    %.................................................................................
    %success Plot
    %.................................................................................
    successY=successY./seq_num;
    successthr=mean(successY);
    [~,successIndex]=sort(successthr,'descend');
    
    h2=figure('Name',attrDisplay);
    for trackerIndex=1:size(algs,2)
        plot(successX,successY(:,successIndex(trackerIndex))','color',colorStyle(:,:,trackerIndex),'LineWidth',3,'LineStyle',lineStyle(:,:,trackerIndex));
        hold on
        
        area=sprintf('%.3f', successthr(successIndex(trackerIndex)));
        
        legendLabel1{trackerIndex}=[algs{successIndex(trackerIndex)} '[' area ']'];
    end
    
    if strcmp(attrDisplay,'ALL')~=1
        title(['Success Plot - ',attrName],'FontSize',12);
    else
        title('Success Plot','FontSize',12,'FontName','Times New Roman');
    end
    xlabel('Overlap Threshold','FontSize',12,'FontName','Times New Roman')
    ylabel('Success Rate','FontSize',12,'FontName','Times New Roman')
    legend(legendLabel1,'Location','northwest','FontSize',8,'FontName','Times New Roman');
    axis([0 1.0 0 1.0]);  % �����������ָ�������
    
    figName = ['./figsResults/',attrDisplay,'_SR'];
    saveas(gcf,figName,'fig');
end
    
    
