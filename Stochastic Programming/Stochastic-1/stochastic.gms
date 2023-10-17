$title Railway problem
$onsymxref
$onsymlist
option optcr=0.05;
option Reslim=1000000;
option limrow=1000;

$onecho > stochastic.txt
set=i     rng=sets!A2:A10   rdim=1   cdim=0
set=j     rng=sets!B2:B10   rdim=1   cdim=0
set=s     rng=sets!C2:C53   rdim=1   cdim=0
set=b     rng=sets!D2:D52   rdim=1   cdim=0
set=w     rng=sets!e2:e21   rdim=1   cdim=0
$offecho
$call gdxxrw.exe Data.xlsx @stochastic.txt
$gdxin Data.gdx
$offOrder
sets
i         " south Train"
j         "north Train"
s         "Station"
b         "Block"
w         "scenario"

$load i, j, s , b , w
$gdxin
sets
originTs(i,s)          /trs1.s52, trs2.s52, trs3.s52, trs4.s52, trs5.s41, trs6.s52, trs7.s52, trs8.s52, trs9.s41/
originTn(j,s)         /trn1.s1, trn2.s1, trn3.s1, trn4.s1, trn5.s1, trn6.s10, trn7.s1, trn8.s10, trn9.s1/
m(i)                 /trs1, trs2, trs3, trs4, trs6, trs7, trs8/
n(i)                /trs1, trs2, trs3, trs4, trs5, trs7, trs8/
p(j)               /trn1, trn2, trn3, trn4, trn6, trn7, trn9/
q(j)              /trn1, trn2, trn3, trn4, trn5, trn7, trn9/;

$onecho > stochastic.txt
par=Delta       rng=scenarios!as1:bb21           rdim=1    cdim=1
par=Gamma       rng=scenarios!c1:l21             rdim=1    cdim=1
par=Ptsw        rng=scenarios!bh1:br1021         rdim=2    cdim=1
par=Ptnw        rng=scenarios!r1:ab1021          rdim=2    cdim=1
par=Stsw        rng=scenarios!bu1:ce1021         rdim=2    cdim=1
par=Stnw        rng=scenarios!ae1:ao1021         rdim=2    cdim=1
par=DepN        rng=Deterministic!C2:D10         rdim=1    cdim=0
par=DepS        rng=Deterministic!AJ2:AK10       rdim=1    cdim=0
par=ptn         rng=Deterministic!l1:U52         rdim=1    cdim=1
par=pts         rng=Deterministic!As1:BB52       rdim=1    cdim=1
par=Sts         rng=Deterministic!BD1:BM52       rdim=1    cdim=1
par=Stn         rng=Deterministic!W1:AF52        rdim=1    cdim=1
par=den         rng=deterministic!a110:j162      rdim=1    cdim=1
par=deS         rng=deterministic!k110:t162      rdim=1    cdim=1
par=Ors         rng=Deterministic!K56:T108       rdim=1    cdim=1
par=orn         rng=Deterministic!A56:J108       rdim=1    cdim=1
$offecho
$call gdxxrw.exe Data.xlsx @stochastic.txt
$gdxin Data.gdx

parameters

Delta(w,i)     " Departure time delay from the origin station of south train i at scenario w"
Gamma(w,j)     " Departure time delay from the origin station of north train j at scenario w"
Ptsw(w,b,i)    " Practical pathing time of south train i at block k at scenario w"
Ptnw(w,b,j)    " Practical pathing time of north train j at block k at scenario w"
Stsw(w,s,i)    " Practical stopping time of south train i at block k at scenario w"
Stnw(w,s,j)    " Practical stopping time of north train j at block k at scenario w"
Deps(i)        " start time for south train "
Depn(j)        " earliest time to start for north train"
Des(s,i)       " The destination station of south train i"
Den(s,j)       " The destination station of north train j"
ptn(b,j)       " pathing time of north train j at block k"
pts(b,i)       " pathing time of south train i at block k"
Sts(s,i)       " stopping time of south train i at block k"
Stn(s,j)       " stopping time of north train j at block k"
orn(s,j)       " The origin station of north train j"
ors(s,i)       " The origin station of south train i"
$load DepN, deps , ptn , stn , pts , sts, orn,ors,delta, gamma, ptsw, ptnw, stsw, stnw, des, den
$gdxin


variables
as(i,s)        "Arrival time of south train i at station s "
an(j,s)        "Arrival time of north train j at station s "
ds(i,s)        "Departure time of south train i from station s"
dn(j,s)        "Departure time of north train j from station s"
y(i,j,b)
Asw(w,i,s)     "Arrival time of south train i at station s at scenario w"
Anw(w,j,s)     "Arrival time of north train j at station s at scenario w"
Dsw(w,i,s)     "Departure time of south train i from station s at scenario w"
Dnw(w,j,s)     "Departure time of north train j from station s at scenario w"
Yw(w,i,j,b)
z;

positive variables
asw, anw, dsw, dnw, as, ds, an, dn;
binary variable y, yw;
scalars
PS   /1/
PN   /1/;

equations
cost
c1(i,s)
c2(i,s)
c3(j,s)
c4(j,s)
c7_1(i,s)
c7_2(i,s)
c7_3(i,s)

c8_1(j,s)
c8_2(j,s)
c8_3(j,s)

c13_1(i,s)
c13_2(i,s)
c13_3(i,s)

c14_1(j,s)
c14_2(j,s)
c14_3(j,s)

c11_1(j,b,s)
c11_2(j,b,s)
c11_3(j,b,s)

c5_1(i,j,s,b)
c5_2(i,j,s,b)
c5_3(i,j,s,b)

c6_1(j,s,i,b)
c6_2(j,s,i,b)
c6_3(j,s,i,b)

c9_1(i,b,s)
c9_2(i,b,s)
c9_3(i,b,s)

constraint1(w,i,s)

constraint2(w,j,s)

constraint3_1(w,i,j,b,s)
constraint3_2(w,i,j,b,s)
constraint3_3(w,i,j,b,s)

constraint4_1(w,i,j,b,s)
constraint4_2(w,i,j,b,s)
constraint4_3(w,i,j,b,s)

constraint5_1(w,i,s)
constraint5_2(w,i,s)
constraint5_3(w,i,s)

constraint6_1(w,j,s)
constraint6_2(w,j,s)
constraint6_3(w,j,s)

constraint7_1(w,i,b,s)
constraint7_2(w,i,b,s)
constraint7_3(w,i,b,s)

constraint8_1(w,j,b,s)
constraint8_2(w,j,b,s)
constraint8_3(w,j,b,s)

constraint9_1(w,i,s)
constraint9_2(w,i,s)
constraint9_3(w,i,s)

constraint10_1(w,j,s)
constraint10_2(w,j,s)
constraint10_3(w,j,s)

constraint11(w,i,s)
constraint12(w,j,s);

cost..                                                                                                                                          z=e= sum((i,s),des(s,i)*as(i,s)-ors(s,i)*ds(i,s))
                                                                                                                                                +sum((j,s),den(s,j)*an(j,s)-orn(s,j)*dn(j,s))
                                                                                                                                                +(0.05*(sum((w),sum((i,s),ps*(des(s,i)*asw(w,i,s)-des(s,i)*as(i,s)))
                                                                                                                                                +sum((j,s),pn*(den(s,j)*anw(w,j,s)-den(s,j)*an(j,s))))));




c1(i,s)$origints(i,s)..                                                                                                                          ds(i,s)=g=Deps(i)-10;
c2(i,s)$origints(i,s)..                                                                                                                          ds(i,s)=l=Deps(i)+10;
c3(j,s)$origintn(j,s)..                                                                                                                          dn(j,s)=g=Depn(j)-10;
c4(j,s)$origintn(j,s)..                                                                                                                          dn(j,s)=l=Depn(j)+10;
constraint1(w,i,s)$origints(i,s)..                                                                                                               dsw(w,i,s)=g=ds(i,s)+delta(w,i);
constraint2(w,j,s)$origintn(j,s)..                                                                                                               dnw(w,j,s)=g=dn(j,s)+gamma(w,j);


c5_1(i,j,s,b)$(ord(s)=ord(b) and ord(b)>40 and ord(i) ne 5 and ord(i) ne 9 and ord(j) ne 5 and ord(j) ne 8 )..                                   ds(i,s+1)-an(j,s+1)+10000*y(i,j,b)=g=0;
c5_2(i,j,s,b)$(ord(s)=ord(b) and ord(b)>9 and ord(s)<41)..                                                                                       ds(i,s+1)-an(j,s+1)+10000*y(i,j,b)=g=0;
c5_3(i,j,s,b)$(ord(s)=ord(b) and ord(b)>3 and ord(i) ne 6 and ord(i) ne 9 and ord(j) ne 6 and ord(j) ne 8 and ord(s)<10 )..                      ds(i,s+1)-an(j,s+1)+10000*y(i,j,b)=g=0;

constraint3_1(w,i,j,b,s)$(ord(s)=ord(b) and ord(b)>40 and ord(i) ne 9 and ord(i) ne 5 and ord(j) ne 5 and ord(j) ne 8 )..                        dsw(w,i,s+1)-anw(w,j,s+1)+10000*yw(w,i,j,b)=g=0;
constraint3_2(w,i,j,b,s)$(ord(s)=ord(b) and ord(b)>9 and ord(s)<41)..                                                                            dsw(w,i,s+1)-anw(w,j,s+1)+10000*yw(w,i,j,b)=g=0;
constraint3_3(w,i,j,b,s)$(ord(s)=ord(b) and ord(b)>3 and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9 and ord(j) ne 6 and ord(j) ne 8)..            dsw(w,i,s+1)-anw(w,j,s+1)+10000*yw(w,i,j,b)=g=0;


c6_1(j,s,i,b)$(ord(s)<card(s) and ord(s)= ord(b) and ord(b)>40 and ord(i) ne 9 and ord(i) ne 5 and ord(j) ne 8 and ord(j) ne 5 )..               dn(j,s)=g=as(i,s)-10000*(1-y(i,j,b));
c6_2(j,s,i,b)$(ord(s)= ord(b) and ord(b)>9  and ord(b)<41)..                                                                                     dn(j,s)=g=as(i,s)-10000*(1-y(i,j,b));
c6_3(j,s,i,b)$(ord(s)= ord(b) and ord(b)>3 and ord(i) ne 6 and ord(i) ne 9 and ord(j) ne 6 and ord(j) ne 8 and ord(s)<10  )..                    dn(j,s)=g=as(i,s)-10000*(1-y(i,j,b));

constraint4_1(w,i,j,b,s)$(ord(s)<card(s) and ord(s)= ord(b) and ord(b)>40 and ord(i) ne 9 and ord(i) ne 5 and ord(j) ne 5 and ord(j) ne 8 )..    dnw(w,j,s)=g=asw(w,i,s)-10000*(1-yw(w,i,j,b));
constraint4_2(w,i,j,b,s)$(ord(s)<card(s) and ord(s)= ord(b) and ord(b)>9  and ord(s)<41)..                                                       dnw(w,j,s)=g=asw(w,i,s)-10000*(1-yw(w,i,j,b));
constraint4_3(w,i,j,b,s)$(ord(s)= ord(b) and ord(b)>3 and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9 and ord(j) ne 6 and ord(j) ne 8)..           dnw(w,j,s)=g=asw(w,i,s)-10000*(1-yw(w,i,j,b));

constraint5_1(w,m,s)$(ord(s)>41 and ord(m)<card(m))..                                                                                            dsw(w,m+1,s+1)-asw(w,m,s)=g=0;
constraint5_2(w,i,s)$(ord(s)<41 and ord(s)>9 and ord(i) <card(i))..                                                                              dsw(w,i+1,s+1)-asw(w,i,s)=g=0;
constraint5_3(w,n,s)$(ord(s)<11 and ord(n)<card(n))..                                                                                            dsw(w,n+1,s+1)-asw(w,n,s)=g=0;


c7_1(m,s)$(ord(s)>40 and ord(m)<card(m))..                                                                                                       ds(m+1,s+1)-as(m,s)=g=0;
c7_2(i,s)$(ord(i)<card(i) and ord(s)>9 and ord(s)<41  )..                                                                                        ds(i+1,s+1)-as(i,s)=g=0;
c7_3(n,s)$(ord(s)>1 and ord(n)<card(n) and ord(s)<10)..                                                                                          ds(n+1,s+1)-as(n,s)=g=0;

constraint6_1(w,q,s)$(ord(s)<10 and ord(q)<card(q))..                                                                                            dnw(w,q+1,s)=g=anw(w,q,s+1);
constraint6_2(w,j,s)$(ord(s)>9 and ord(s)<41 and ord(j)<card(j))..                                                                               dnw(w,j+1,s)=g=anw(w,j,s+1);
constraint6_3(w,p,s)$(ord(s)>40 and ord(p)<card(p))..                                                                                            dnw(w,p+1,s)=g=anw(w,p,s+1);


c8_1(q,s)$(ord(s)<10 and ord(q)<card(q))..                                                                                                       dn(q+1,s)=g=an(q,s+1);
c8_2(j,s)$(ord(s)>9 and ord(s)<41 and ord(j)<card(j) )..                                                                                         dn(j+1,s)=g=an(j,s+1);
c8_3(p,s)$(ord(s)>40 and ord(p)<card(p))..                                                                                                       dn(p+1,s)=g=an(p,s+1);

c9_1(i,b,s)$(ord(s)=ord(b)and ord(s)>40 and ord(i) ne 5 and ord(i) ne 9)..                                                                       as(i,s)-ds(i,s+1)=e=pts(b,i);
c9_2(i,b,s)$(ord(s)=ord(b)and ord(s)>9 and ord(s)<41)..                                                                                          as(i,s)-ds(i,s+1)=e=pts(b,i);
c9_3(i,b,s)$(ord(s)=ord(b)and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9)..                                                                       as(i,s)-ds(i,s+1)=e=pts(b,i);

constraint7_1(w,i,b,s)$(ord(s)=ord(b)and ord(s)<card(s)and ord(s)>40 and ord(i) ne 5 and ord(i) ne 9)..                                          asw(w,i,s)-dsw(w,i,s+1)=e=ptsw(w,b,i);
constraint7_2(w,i,b,s)$(ord(s)=ord(b)and ord(s)<card(s)and ord(s)>9 and ord(s)<41)..                                                             asw(w,i,s)-dsw(w,i,s+1)=e=ptsw(w,b,i);
constraint7_3(w,i,b,s)$(ord(s)=ord(b)and ord(s)<card(s)and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9)..                                          asw(w,i,s)-dsw(w,i,s+1)=e=ptsw(w,b,i);


c11_1(j,b,s)$(ord(s)=ord(b)and ord(s)>40 and ord(j) ne 5 and ord(j) ne 8)..                                                                      an(j,s+1)-dn(j,s)=e=ptn(b,j);
c11_2(j,b,s)$(ord(s)=ord(b)and ord(s)>9 and ord(s)<41)..                                                                                         an(j,s+1)-dn(j,s)=e=ptn(b,j);
c11_3(j,b,s)$(ord(s)=ord(b)and ord(s)<10 and ord(j) ne 6 and ord(j) ne 8)..                                                                      an(j,s+1)-dn(j,s)=e=ptn(b,j);

constraint8_1(w,j,b,s)$(ord(s)=ord(b)and ord(s)<card(s)and ord(s)>40 and ord(j) ne 5 and ord(j) ne 8)..                                          anw(w,j,s+1)-dnw(w,j,s)=e=ptnw(w,b,j);
constraint8_2(w,j,b,s)$(ord(s)=ord(b)and ord(s)<card(s)and ord(s)>9 and ord(s)<41)..                                                             anw(w,j,s+1)-dnw(w,j,s)=e=ptnw(w,b,j);
constraint8_3(w,j,b,s)$(ord(s)=ord(b)and ord(s)<card(s)and ord(s)<10 and ord(j) ne 6 and ord(j) ne 9)..                                          anw(w,j,s+1)-dnw(w,j,s)=e=ptnw(w,b,j);


c13_1(i,s)$(ord(s)<card(s)and ord(s)>41 and ord(i) ne 5 and ord(i) ne 9)..                                                                       ds(i,s)=g=as(i,s)+sts(s,i);
c13_2(i,s)$(ord(s)<card(s)and ord(s)>10 and ord(s)<42)..                                                                                         ds(i,s)=g=as(i,s)+sts(s,i);
c13_3(i,s)$(ord(s)>1 and ord(s)<card(s)and ord(s)<11 and ord(i) ne 6 and ord(i) ne 9)..                                                          ds(i,s)=g=as(i,s)+sts(s,i);

constraint9_1(w,i,s)$(ord(s)<card(s)and ord(s)>41 and ord(i) ne 5 and ord(i) ne 9)..                                                             dsw(w,i,s)=g=asw(w,i,s)+stsw(w,s,i);
constraint9_2(w,i,s)$(ord(s)<card(s)and ord(s)>10 and ord(s)<42)..                                                                               dsw(w,i,s)=g=asw(w,i,s)+stsw(w,s,i);
constraint9_3(w,i,s)$(ord(s)>1 and ord(s)<card(s)and ord(s)<11 and ord(i) ne 6 and ord(i) ne 9)..                                                dsw(w,i,s)=g=asw(w,i,s)+stsw(w,s,i);


c14_1(j,s)$(ord(s)<card(s)and ord(s)>40 and ord(j) ne 5 and ord(j) ne 8)..                                                                       dn(j,s)=g=an(j,s)+stn(s,j);
c14_2(j,s)$(ord(s)<card(s)and ord(s)>9 and ord(s)<41)..                                                                                          dn(j,s)=g=an(j,s)+stn(s,j);
c14_3(j,s)$(ord(s)>1 and ord(s)<card(s)and ord(s)<11 and ord(j) ne 6 and ord(j) ne 8)..                                                          dn(j,s)=g=an(j,s)+stn(s,j);

constraint10_1(w,j,s)$(ord(s)<card(s)and ord(s)>40 and ord(j) ne 5 and ord(j) ne 8)..                                                            dnw(w,j,s)=g=anw(w,j,s)+stnw(w,s,j);
constraint10_2(w,j,s)$(ord(s)<card(s)and ord(s)>9 and ord(s)<41)..                                                                               dnw(w,j,s)=g=anw(w,j,s)+stnw(w,s,j);
constraint10_3(w,j,s)$(ord(s)>1 and ord(s)<11 and ord(j) ne 6 and ord(j) ne 8)..                                                                 dnw(w,j,s)=g=anw(w,j,s)+stnw(w,s,j);

constraint11(w,i,s)$(ord(s)>1 )..                                                                                                                dsw(w,i,s)=g=ds(i,s);
constraint12(w,j,s)$(ord(s)<card(s))..                                                                                                           dnw(w,j,s)=g=dn(j,s);

model stochastic /all/;
option mip = cplex;

solve stochastic using mip minimizing z;
display z.l,as.l, ds.l,an.l,dn.l,y.l;
execute_unload "Data.gdx"
execute 'gdxxrw.exe Data.gdx var=as.l rng=results!a1  var=ds.l rng=results!a12     var=an.l rng=results!a23    var=dn.l rng=results!a34  var=asw.l rng=results_w!a1  var=dsw.l rng=results_w!a182  var=anw.l rng=results_w!a364    var=dnw.l rng=results_w!a547 '
parameter delayA ,DelayB ;
delayA= +(0.05*(sum((w),sum((i,s),ps*(des(s,i)*asw.l(w,i,s)-des(s,i)*as.l(i,s)))
       +sum((j,s),pn*(den(s,j)*anw.l(w,j,s)-den(s,j)*an.l(j,s))))));
DelayB=sum((i,s),des(s,i)*as.l(i,s)-ors(s,i)*ds.l(i,s))
       +sum((j,s),den(s,j)*an.l(j,s)-orn(s,j)*dn.l(j,s));
display delayA,DelayB;
