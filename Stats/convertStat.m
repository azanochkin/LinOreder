function [medianKemCell,quantCell,medianCell] = ...
        convertStat(medianKemMat,quantArr,medianNumCell,agGradeName)
    medianKemCell = cell(size(medianKemMat));
    quantCell = cell(size(quantArr));
    medianCell = cell(size(medianNumCell));
    for i = 1:length(agGradeName)
        dict = agGradeName{i};
%         for j=1:10
%             dict{j} = num2str(j);
%         end
        %
        mask = ~isnan(medianKemMat(:,i));
        medianKemCell(mask,i) = dict(1+medianKemMat(mask,i));
        %
        for j = 1:size(quantArr,2)
            mask = ~isnan(quantArr(:,j,i));
            quantCell(mask,j,i) = dict(1+quantArr(mask,j,i));
        end
        for j = 1:size(medianNumCell,1)
            tmp = dict(1+ medianNumCell{j,i});
            tmp1 = cell(size(tmp));
            tmp1(:) = {'; '};
            tmp = [tmp tmp1]';
            medianCell{j,i} = [tmp{:}];
        end
    end
end

