function pass = test_printTree(~)
%%TEST_PRINTTREE    Do TREEVAR computations, check that printTree works.

%% Basic computation:
u = treeVar();
v = cos(u);
w = sin(u);
t = v + w;
pt = treeVar.printTree(t.tree);
correct = [112;108;117;115;9;100;105;102;102;79;114;100;101;114;58;32;48;...
    10;32;32;124;45;45;99;111;115;9;100;105;102;102;79;114;100;101;114;58;...
    32;48;10;32;32;124;32;32;124;45;45;99;111;110;115;116;114;9;100;105;102;...
    102;79;114;100;101;114;58;32;48;10;32;32;124;45;45;115;105;110;9;100;105;...
    102;102;79;114;100;101;114;58;32;48;10;32;32;32;32;32;124;45;45;99;111;110;...
    115;116;114;9;100;105;102;102;79;114;100;101;114;58;32;48;10]';

pass(1) = norm(pt-correct) == 0;

%% Introducing differentiation
u = treeVar();
myfun = @(u) 2 + diff(u,2);
t = myfun(u);
pt = treeVar.printTree(t.tree);
correct = [112 108 117 115 9 100 105 102 102 79 114 100 101 114 58 32 50 10 ...
    32 32 124 45 45 110 117 109 101 114 105 99 97 108 32 9 86 97 108 117 101 ...
    58 32 50 46 48 48 10 32 32 124 45 45 100 105 102 102 9 100 105 102 102 ...
    79 114 100 101 114 58 32 50 10 32 32 32 32 32 124 45 45 99 111 110 115 ...
    116 114 9 100 105 102 102 79 114 100 101 114 58 32 48 10 32 32 32 32 32 ...
    124 45 45 110 117 109 101 114 105 99 97 108 32 9 86 97 108 117 101 58 32 ...
    50 46 48 48 10];

pass(2) = norm(pt-correct) == 0;

%% Nested differentiation
t = diff(diff(u)) + diff(u) + u;
pt = treeVar.printTree(t.tree);
correct = [112 108 117 115 9 100 105 102 102 79 114 100 101 114 58 32 50 10 ...
    32 32 124 45 45 112 108 117 115 9 100 105 102 102 79 114 100 101 114 58 ...
    32 50 10 32 32 124 32 32 124 45 45 100 105 102 102 9 100 105 102 102 79 ...
    114 100 101 114 58 32 50 10 32 32 124 32 32 124 32 32 124 45 45 100 105 ...
    102 102 9 100 105 102 102 79 114 100 101 114 58 32 49 10 32 32 124 32 32 ...
    124 32 32 124 32 32 124 45 45 99 111 110 115 116 114 9 100 105 102 102 ...
    79 114 100 101 114 58 32 48 10 32 32 124 32 32 124 32 32 124 32 32 124 ...
    45 45 110 117 109 101 114 105 99 97 108 32 9 86 97 108 117 101 58 32 49 ...
    46 48 48 10 32 32 124 32 32 124 32 32 124 45 45 110 117 109 101 114 105 ...
    99 97 108 32 9 86 97 108 117 101 58 32 49 46 48 48 10 32 32 124 32 32 ...
    124 45 45 100 105 102 102 9 100 105 102 102 79 114 100 101 114 58 32 49 ...
    10 32 32 124 32 32 32 32 32 124 45 45 99 111 110 115 116 114 9 100 105 ...
    102 102 79 114 100 101 114 58 32 48 10 32 32 124 32 32 32 32 32 124 45 ...
    45 110 117 109 101 114 105 99 97 108 32 9 86 97 108 117 101 58 32 49 46 ...
    48 48 10 32 32 124 45 45 99 111 110 115 116 114 9 100 105 102 102 79 114 ...
    100 101 114 58 32 48 10];

pass(3) = norm(pt-correct) == 0;
end