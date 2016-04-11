function clRelMat = transClosure( relMat )
    flag = true;
    clRelMat = logical(relMat);
    while flag
        prevClRelMat = clRelMat;
        clRelMat = logical(clRelMat*double(clRelMat));
        flag = ~all(all(prevClRelMat==clRelMat));
    end
end
%     prevClRelMat = double(logical(relMat));
%     clRelMat = logical(prevClRelMat*prevClRelMat);
%     while ~all(all(prevClRelMat==clRelMat))
%         prevClRelMat = clRelMat;
%         clRelMat = logical(clRelMat*double(clRelMat));
%     end
% end

