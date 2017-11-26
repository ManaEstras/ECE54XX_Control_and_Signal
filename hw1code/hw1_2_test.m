j = 1;
while i < 1000
        y = rand;
        u = rand;
        if u <= y
            x(j) = y;
            j = j + 1;
            i = i + 1;
        end
end
       hist(x);