
function [aveErrCoverageAll aveErrCenterAll] = calcPlotErr_TPR(seqs, trks,  bPlot, basePath, resultPath)



LineWidth = 2;
LineStyle = '-';%':';%':' '.-'

lostCount = zeros(length(seqs), length(trks));
thred = 0.33;

errCenterAll=[];
errCoverageAll=[];

lenTotalSeqV = 0;
lenTotalSeqI = 0;
precisonPlot=0;
successPlot=0;
rectMat=[];

for index_seq=1:length(seqs)
    seq = seqs{index_seq};
    seq_name=seq;
    if ~exist([basePath seq_name '/rgb.txt'])
        continue
    end
    fileNameV = [basePath seq_name '/rgb.txt'];
    fileNameI = [basePath seq_name '/ir.txt'];
    
    rect_annoV = load_groundtruth_txt_info(fileNameV);
    rect_annoI = load_groundtruth_txt_info(fileNameI);

    seq_lengthV=size(rect_annoV,1);
    seq_lengthI=size(rect_annoI,1);
    lenTotalSeqV = lenTotalSeqV + seq_lengthV;
    lenTotalSeqI = lenTotalSeqI + seq_lengthI;
    centerGTV = [(rect_annoV(:,1)+rect_annoV(:,3))/2 (rect_annoV(:,2)+rect_annoV(:,4))/2];%groundTruth's center
    centerGTI = [(rect_annoI(:,1)+rect_annoI(:,3))/2 (rect_annoI(:,2)+rect_annoI(:,4))/2];
    rect_whV=[rect_annoV(:,1),rect_annoV(:,2),rect_annoV(:,3)-rect_annoV(:,1),rect_annoV(:,4)-rect_annoV(:,2)];% x y w h
    rect_whI=[rect_annoI(:,1),rect_annoI(:,2),rect_annoI(:,3)-rect_annoI(:,1),rect_annoI(:,4)-rect_annoI(:,2)];
    
    for index_algrm=1:length(trks)
        algrm = trks{index_algrm};

        name=algrm;
        trackerNames{index_algrm}=name;
        disp([resultPath name '_' seq_name  '.txt'])
        results.res=dlmread([resultPath name '_' seq_name  '.txt']);
        results.res = results.res(1:10:end,:);
        
        if size(results.res,2) == 8
            results.type='4corner';
        elseif size(results.res,2) == 4
            results.type='rect';
        end
        
        rectMat = zeros(seq_lengthV, 4);
        
        switch results.type
            case 'rect'
                
                rectMat = results.res;
%                 
            case 'ivtAff'
                for i = 1:seq_lengthV
                    [rect c] = calcRectCenter(results.tmplsize, results.res(i,:), 'Color', [1 1 1], 'LineWidth', LineWidth,'LineStyle',LineStyle);
                    rectMat(i,:) = rect;
                end
            case 'L1Aff'
                for i = 1:seq_lengthV
                    [rect c] = calcCenter_L1(results.res(i,:), results.tmplsize);
                    rectMat(i,:) = rect;
                end
            case 'LK_Aff'
                for i = 1:seq_lengthV
                    [corner c] = getLKcorner(results.res(2*i-1:2*i,:), results.tmplsize);
                    rectMat(i,:) = corner2rect(corner);
                end
            case '4corner'
                for i = 1:seq_lengthV
                    rectMat(i,:) = corner2rect(results.res(i,:));
                end
            otherwise
                continue;
        end
        
        center = [rectMat(:,1)+(rectMat(:,3))/2 rectMat(:,2)+(rectMat(:,4))/2];
        
        errV = calcRectInt(rectMat(1:seq_lengthV,:),rect_whV(1:seq_lengthV,:));
        errI = calcRectInt(rectMat(1:seq_lengthI,:),rect_whI(1:seq_lengthI,:));
        
        err = max(errV, errI);
        
        errCenterV = sqrt(sum(((center(1:seq_lengthV,:) - centerGTV(1:seq_lengthV,:)).^2),2));
        errCenterI = sqrt(sum(((center(1:seq_lengthI,:) - centerGTI(1:seq_lengthI,:)).^2),2));
        
        errCenter = min(errCenterV, errCenterI);
        
        if(isdir(['ERRresults/' name])==0)
            mkdir(['ERRresults/' name]);
        end
        save([['ERRresults/' name] '/' name '_' seq_name '.mat'], 'err','errCenter');
        
        if bPlot
            h1=figure(1);
            plot(err,'color',[0,1,0],'LineWidth',LineWidth,'LineStyle',LineStyle);
            hold on
            
            h2=figure(2);
            plot(errCenter,'color', [0,1,0],'LineWidth',LineWidth,'LineStyle',LineStyle);
            hold on
            
        end
    end
    
    if bPlot
        figure(1);
        axis tight
        set(gca,'fontsize',20);
        
        
        xlabel(['# ' seqs{index_seq}],'FontSize',20)
        ylabel('Coverage/quality','FontSize',20)
        
        
        
        figure(2);
        
        axis tight;
        set(gca,'fontsize',20);
        
        xlabel(['# ' seqs{index_seq}],'FontSize',20)
        ylabel('Center error','FontSize',20)
        
        
        clf(h1);
        clf(h2);
    end
    
    aveErrCoverage(index_seq,:) = sum(err)/seq_lengthV;
    errCoverageAll(index_seq,:) = sum(err);
    
    aveErrCenter(index_seq,:) = sum(errCenter)/seq_lengthV;
    errCenterAll(index_seq,:) = sum(errCenter);
    
    lostCount(index_seq,:)=sum(err<thred);
    precisonPlot=precisonPlot+sum(errCenter<=5);
    successPlot=successPlot+sum(err>0.6);
    err = [];
    errV = [];
    errI = [];
    errCenter=[];
    errCenterV = [];
    errCenterI = [];
end
