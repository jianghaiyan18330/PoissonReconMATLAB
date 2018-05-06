function X = basisSum(tree, x)
%basisSum X = sum_i x_i * B_i
%
% Maolin Tian, Tongji University, 2018

global valueTable
N = tree.Count;
X = zeros(N, 1);
for i = 1:N
    for j = tree.ngbr{i}'
        d = tree.depth(j);
        dp = tree.center(i,:) - tree.center(j,:);
        dx = 1+round((dp(1) - valueTable{d}(1,1)) * 2^(d+2));
        dy = 1+round((dp(2) - valueTable{d}(1,1)) * 2^(d+2));
        dz = 1+round((dp(3) - valueTable{d}(1,1)) * 2^(d+2));
        Len = size(valueTable{d},1);
        if dx <= 0 || dx > Len || dy <= 0 || dy > Len || dz <= 0 || dz > Len
            continue;
        end
        F_i = valueTable{d}(dx,2) * valueTable{d}(dy,2) * valueTable{d}(dz,2);
        F_i = F_i * 8^(tree.depth(j));
        X(i) = X(i) + x(i) * F_i;
    end
end
