function clRelMat = transClosure( relMat )
    prevClRelMat = double(logical(relMat));
    clRelMat = logical(prevClRelMat*prevClRelMat);
    while ~all(all(prevClRelMat==clRelMat))
        prevClRelMat = clRelMat;
        clRelMat = logical(clRelMat*double(clRelMat));
    end
end

