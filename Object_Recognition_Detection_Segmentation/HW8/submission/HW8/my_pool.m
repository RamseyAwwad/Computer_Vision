function [Output] = my_pool(Input, Pool_Size)
    [m, n] = size(Input);
    Output = zeros(Pool_Size);
    di = uint16(m / Pool_Size);
    dj = uint16(n / Pool_Size);
    for i = 1:Pool_Size
        for j = 1:Pool_Size
            lx = uint16((i - 1) * di) + 1;
            ly = uint16((j - 1) * dj) + 1;
            ux = uint16(i * di);
            uy = uint16(j * dj);
            if ux > m || uy > n
                break;
            end
            Output(i, j) = max(max(Input(lx:ux, ly:uy)));
        end
    end
end