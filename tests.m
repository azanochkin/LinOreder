clear data
data(1).res = [];
data(1).subArr = [1 2]';
data(1).rankVec = [1 2]';
%
data(2).subArr = [1 2]';
data(2).rankVec = [2 1]';
%
data(3).subArr = [1 2]';
data(3).rankVec = [2 2]';
%
data(4).subArr = [2 1]';
data(4).rankVec = [2 2]';
%
data(5).subArr = [1 1]';
data(5).rankVec = [2 2]';
%
data(6).subArr = [1 1]';
data(6).rankVec = [2 1]';
%
data(7).subArr = [1 2 3]';
data(7).rankVec = [1 2 3]';
%
data(8).subArr = [1 2 3]';
data(8).rankVec = [1 3 2]';
%
data(9).subArr = [1 2 3]';
data(9).rankVec = [1 1 2]';
%
data(10).subArr = [1 2 3]';
data(10).rankVec = [1 1 1]';
%
data(11).subArr = [1 2 3]';
data(11).rankVec = [1 1 1]';
%
data(12).subArr = [1 2 3]';
data(12).rankVec = [3 1 1]';
%
data(13).subArr = [1 2 3]';
data(13).rankVec = [3 2 1]';
%
data(14).subArr = [1 2 2]';
data(14).rankVec = [1 1 1]';
%
data(15).subArr = [1 2 2]';
data(15).rankVec = [1 2 3]';
%
data(16).subArr = [1 2 2]';
data(16).rankVec = [1 2 1]';
%
data(17).subArr = [1 2 2]';
data(17).rankVec = [2 1 1]';
%
data(18).subArr = [1 2 2]';
data(18).rankVec = [3 2 1]';
%
data(19).subArr = [1 2 2]';
data(19).rankVec = [2 1 3]';
%
data(20).subArr = [2 1 1]';
data(20).rankVec = [1 1 1]';
%
data(21).subArr = [2 1 1]';
data(21).rankVec = [1 2 3]';
%
data(22).subArr = [2 1 1]';
data(22).rankVec = [1 1 2]';
%
data(23).subArr = [2 1 1]';
data(23).rankVec = [1 1 1]';
%
data(24).subArr = [2 1 1]';
data(24).rankVec = [3 1 2]';
%
testFnct(data,@insertion)