clear all

P1 = [0.5,0.2,0.3;0.1,0.9,0;0.23,0.23,0.54];
[V1,D1] = eig(P1)

P2 = [0.1,0.6,0.3;0.1,0.9,0;0.1,0.8,0.1];
[V2,D2] = eig(P2)

pi0 = [0.3,0.3,0.4];
pix = pi0;

pif1 = [0.194092827004220,0.679324894514771,0.126582278481013];
pif2 = [0.100000000000000,0.866666666666668,0.0333333333333334]

path1 = zeros(20,1);
path2 = zeros(20,1);

for i = 1:20
    pix = pix * P1;
    path1(i) = norm(pix - pif1);
end

for i = 1:20
    pix = pix * P2;
    path2(i) = norm(pix - pif2);
end

figure(1)
plot(path1)
hold on
plot(path2,'r-')
hold off