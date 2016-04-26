function ntransRelMat = preprocLossMatrix( lossMat )
%PREPROCLOSSMATRIX Summary of this function goes here
%   Detailed explanation goes here
    function relMat = getSepClass(relMat,depth)
    i = 2;
    while i <= size(relMat,1)
        fprintf('%i + %i\n',depth,i )
        flag = true;
        j = 1;
        while flag && (j<i)
            isNextClVec = false(1,length(relMat));
            isNextClVec([i,j]) = true;
            isClosed = false;
            while ~isClosed
                isClVec = isNextClVec;
                isnEqVec = (any(relMat(isClVec,:))&~all(relMat(isClVec,:)))|...
                    (any(relMat(:,isClVec)')&~all(relMat(:,isClVec)'));
                isNextClVec = isClVec | isnEqVec;
                isClosed = all(isNextClVec == isClVec);
            end
            flag = all(isClVec);
            j = j + 1;
        end
        if ~flag
            fprintf('===> %i: %i\n',depth,length(relMat))
            fprintf('%i, ',find(isClVec));
            fprintf('\n');
            fprintf('%i: ',find(~isClVec));
            fprintf('\n');
            getSepClass(relMat(isClVec,isClVec),depth+1);
            relMat(:,isClVec) = [];
            relMat(isClVec,:) = [];
            i = 1;
        end
        i = i+1;
    end 
    end
    function relMat = getRep(relMat,nextFnct)
    i = 2;
    while i <= size(relMat,1)
        horzRelVec = relMat(i,:);
        vertRelVec = relMat(:,i);
        flag = true;
        j = 1;
        while flag && (j<i)
            isEqVec = (horzRelVec==relMat(j,:)) & ...
                (vertRelVec==relMat(:,j))';
            isEqVec([i,j]) = true;
            flag = ~all(isEqVec);
            j = j + 1;
        end
        if ~flag
            fprintf('%i, %i \n',length(relMat),i)
            relMat(:,i) = [];
            relMat(i,:) = [];
            i = nextFnct(i);
        end
        i = i+1;
    end

    end
ntransRelMat = (lossMat<0) | (eye(size(lossMat)));
%
% ntransRelMat = getRep(ntransRelMat,@(x)x-1);
% ntransRelMat = getRep(ntransRelMat,@(x)1);
load('matlab.mat');
ntransRelMat = getSepClass(ntransRelMat,1);
end

