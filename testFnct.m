function testFnct( data, fnct)
    testNum = (1:length(data))';
    result = cell(size(testNum));
    for i = testNum'
        fprintf('---------> test %i started\n',i)
        lossMat = lossMatrixLin(data(i).subArr);
        resRankVec = fnct(data(i).rankVec,lossMat);
        if isempty(data(i).res)
            resVec = data(i).subArr;
        else
            resVec = data(i).res;
        end
        if any(resVec ~= resRankVec(:))
            result{i} = 'failed';
            fprintf('---------> test %i failed\n',i)
        else
            result{i} = 'passed';
            fprintf('---------> test %i passed\n',i)
        end
        fprintf('===================================\n')
    end
    disp(table(testNum,result));
end

