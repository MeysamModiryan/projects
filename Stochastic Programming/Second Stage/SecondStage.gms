$Title second stage of recource problem

$onecho > secondstage.txt
set=i     rng=sets!a2:a10   rdim=1   cdim=0
set=j     rng=sets!b2:b10   rdim=1   cdim=0
set=s     rng=sets!c2:c53   rdim=1   cdim=0
set=b     rng=sets!d2:d52   rdim=1   cdim=0
set=w     rng=sets!e2:e21   rdim=1   cdim=0
$offecho
$call gdxxrw.exe  data-mixed.xlsx @secondstage.txt
$gdxin data-mixed.gdx
$offOrder
sets
i         "south Train"
j         "north Train"
s         "Station"
b         "Block"
w         "Scenario"
$load i, j, s , b , w
$gdxin
sets
originTs(i,s)    /trs1.s52, trs2.s52,trs3.s52,trs4.s52,trs5.s41,trs6.s52,trs7.s52,trs8.s52,trs9.s41/
originTn(j,s)   /trn1.s1, trn2.s1, trn3.s1, trn4.s1, trn5.s1, trn6.s10, trn7.s1, trn8.s10, trn9.s1/
m(i)           /trs1, trs2, trs3, trs4, trs6, trs7, trs8/
n(i)          /trs1, trs2, trs3, trs4, trs5, trs7, trs8/
p(j)         / trn1, trn2, trn3, trn4, trn6, trn7,trn9/
q(j)        /trn1, trn2, trn3, trn4, trn5, trn7, trn9/;

$onecho > secondstage.txt
par=Delta     rng=scenarios!as1:bb21         rdim=1    cdim=1
par=Gamma     rng=scenarios!c1:l21           rdim=1    cdim=1
par=Pts       rng=scenarios!bh1:br1021       rdim=2    cdim=1
par=Ptn       rng=scenarios!R1:AB1021        rdim=2    cdim=1
par=Sts       rng=scenarios!bu1:ce1021       rdim=2    cdim=1
par=Stn       rng=scenarios!AE1:AO1021       rdim=2    cdim=1
par=As        rng=results!a1:az10            rdim=1    cdim=1
par=An        rng=results!a23:az32           rdim=1    cdim=1
par=Ds        rng=results!a12:az21           rdim=1    cdim=1
par=Dn        rng=results!a34:az43           rdim=1    cdim=1
par=Orn       rng=deterministic!a56:j108     rdim=1    cdim=1
par=den       rng=deterministic!a110:j162    rdim=1    cdim=1
par=Ors       rng=deterministic!k56:t108     rdim=1    cdim=1
par=deS       rng=deterministic!k110:t162    rdim=1    cdim=1
par=sds       rng=deterministic!aj12:ak21    rdim=1    cdim=0
par=sdn       rng=deterministic!c12:d21      rdim=1    cdim=0
$offecho
$call gdxxrw.exe data-mixed.xlsx @secondstage.txt
$gdxin data-mixed.gdx

parameters
Delta(w,i)    "Departure time delay from the origin station of south train i at scenario w"
Gamma(w,j)    "Departure time delay from the origin station of north train j at scenario w"
Pts(w,b,i)    "Practical pathing time of south train i at block k at scenario w"
Ptn(w,b,j)    "Practical pathing time of north train j at block k at scenario w"
Sts(w,s,i)    "Practical stopping time of south train i at block k at scenario w"
Stn(w,s,j)    "Practical stopping time of north train j at block k at scenario w"
As(i,s)       "Scheduled arrival time of south train i at station s"
An(j,s)       "Scheduled arrival time of north train j at station s"
Ds(i,s)       "Scheduled departure time of south train i from station s + its delay"
Dn(j,s)       "Scheduled departure time of north train j from station s + its delay"
Ors(s,i)      "The origin station of south train i"
Orn(s,j)      "The origin station of north train j"
Des(s,i)      "The destination station of south train i"
Den(s,j)      "The destination station of north train j"
Sds(i)        "Scheduled departure time of south train i from its origin"
Sdn(j)        "Scheduled departure time of north train j from its origin"
$load Delta, Gamma, Pts, Ptn, Sts, Stn, As, An, Ds, Dn, Ors, Orn, Des, Den, Sds, Sdn
$gdxin


variables
Asw(w,i,s)     "Arrival time of south train i at station s at scenario w"
Anw(w,j,s)     "Arrival time of north train j at station s at scenario w"
Dsw(w,i,s)     "Departure time of south train i from station s at scenario w"
Dnw(w,j,s)     "Departure time of north train j from station s at scenario w"
Y(w,i,j,b)
Z         ;
positive variables asw, anw, dsw, dnw;
binary variable y;

scalars
PS   /1/
PN   /1/;

Equations
Difference
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

Difference..                                                                                                                                  z=e=0.05*(sum((w),sum((i,s),ps*(des(s,i)*asw(w,i,s)-des(s,i)*as(i,s)))+sum((j,s),pn*(den(s,j)*anw(w,j,s)-den(s,j)*an(j,s)))))+sum((i,s),des(s,i)*as(i,s)-ors(s,i)*ds(i,s))
                                                                                                                                            +sum((j,s),den(s,j)*an(j,s)-orn(s,j)*dn(j,s));

constraint1(w,i,s)$origints(i,s)..                                                                                                            dsw(w,i,s)=g=sds(i)+delta(w,i);
constraint2(w,j,s)$origintn(j,s)..                                                                                                            dnw(w,j,s)=g=sdn(j)+gamma(w,j);

constraint3_1(w,i,j,b,s)$(ord(s)=ord(b) and ord(b)>40 and ord(i) ne 9 and ord(i) ne 5 and ord(j) ne 5 and ord(j) ne 8 )..                     dsw(w,i,s+1)-anw(w,j,s+1)+10000*y(w,i,j,b)=g=0;
constraint3_2(w,i,j,b,s)$(ord(s)=ord(b) and ord(b)>9 and ord(s)<41)..                                                                         dsw(w,i,s+1)-anw(w,j,s+1)+10000*y(w,i,j,b)=g=0;
constraint3_3(w,i,j,b,s)$(ord(s)=ord(b) and ord(b)>3 and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9 and ord(j) ne 6 and ord(j) ne 8)..         dsw(w,i,s+1)-anw(w,j,s+1)+10000*y(w,i,j,b)=g=0;

constraint4_1(w,i,j,b,s)$(ord(s)<card(s) and ord(s)= ord(b) and ord(b)>40 and ord(i) ne 9 and ord(i) ne 5 and ord(j) ne 5 and ord(j) ne 8 ).. dnw(w,j,s)=g=asw(w,i,s)-10000*(1-y(w,i,j,b));
constraint4_2(w,i,j,b,s)$(ord(s)<card(s) and ord(s)= ord(b) and ord(b)>9  and ord(s)<41)..                                                    dnw(w,j,s)=g=asw(w,i,s)-10000*(1-y(w,i,j,b));
constraint4_3(w,i,j,b,s)$(ord(s)= ord(b) and ord(b)>3 and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9 and ord(j) ne 6 and ord(j) ne 8)..        dnw(w,j,s)=g=asw(w,i,s)-10000*(1-y(w,i,j,b));

constraint5_1(w,m,s)$(ord(s)>41 and ord(m)<card(m))..                                                                                         dsw(w,m+1,s+1)-asw(w,m,s)=g=0;
constraint5_2(w,i,s)$(ord(s)<41 and ord(s)>9 and ord(i) <card(i))..                                                                           dsw(w,i+1,s+1)-asw(w,i,s)=g=0;
constraint5_3(w,n,s)$(ord(s)<11 and ord(n)<card(n))..                                                                                         dsw(w,n+1,s+1)-asw(w,n,s)=g=0;

constraint6_1(w,q,s)$(ord(s)<10 and ord(q)<card(q))..                                                                                         dnw(w,q+1,s)=g=anw(w,q,s+1);
constraint6_2(w,j,s)$(ord(s)>9 and ord(s)<41 and ord(j)<card(j))..                                                                            dnw(w,j+1,s)=g=anw(w,j,s+1);
constraint6_3(w,p,s)$(ord(s)>40 and ord(p)<card(p))..                                                                                         dnw(w,p+1,s)=g=anw(w,p,s+1);

constraint7_1(w,i,b,s)$(ord(s)=ord(b) and ord(s)<card(s)and ord(s)>40 and ord(i) ne 5 and ord(i) ne 9)..                                      asw(w,i,s)-dsw(w,i,s+1)=e=pts(w,b,i);
constraint7_2(w,i,b,s)$(ord(s)=ord(b) and ord(s)<card(s)and ord(s)>9 and ord(s)<41)..                                                         asw(w,i,s)-dsw(w,i,s+1)=e=pts(w,b,i);
constraint7_3(w,i,b,s)$(ord(s)=ord(b) and ord(s)<card(s)and ord(s)<10 and ord(i) ne 6 and ord(i) ne 9)..                                      asw(w,i,s)-dsw(w,i,s+1)=e=pts(w,b,i);

constraint8_1(w,j,b,s)$(ord(s)=ord(b) and ord(s)<card(s)and ord(s)>40 and ord(j) ne 5 and ord(j) ne 8)..                                      anw(w,j,s+1)-dnw(w,j,s)=e=ptn(w,b,j);
constraint8_2(w,j,b,s)$(ord(s)=ord(b) and ord(s)<card(s)and ord(s)>9 and ord(s)<41)..                                                         anw(w,j,s+1)-dnw(w,j,s)=e=ptn(w,b,j);
constraint8_3(w,j,b,s)$(ord(s)=ord(b) and ord(s)<card(s)and ord(s)<10 and ord(j) ne 6 and ord(j) ne 9)..                                      anw(w,j,s+1)-dnw(w,j,s)=e=ptn(w,b,j);

constraint9_1(w,i,s)$(ord(s)<card(s)and ord(s)>41 and ord(i) ne 5 and ord(i) ne 9)..                                                          dsw(w,i,s)=g=asw(w,i,s)+sts(w,s,i);
constraint9_2(w,i,s)$(ord(s)<card(s)and ord(s)>10 and ord(s)<42)..                                                                            dsw(w,i,s)=g=asw(w,i,s)+sts(w,s,i);
constraint9_3(w,i,s)$(ord(s)>1 and ord(s)<card(s)and ord(s)<11 and ord(i) ne 6 and ord(i) ne 9)..                                             dsw(w,i,s)=g=asw(w,i,s)+sts(w,s,i);

constraint10_1(w,j,s)$(ord(s)<card(s) and ord(s)>40 and ord(j) ne 5 and ord(j) ne 8)..                                                        dnw(w,j,s)=g=anw(w,j,s)+stn(w,s,j);
constraint10_2(w,j,s)$(ord(s)<card(s) and ord(s)>9 and ord(s)<41)..                                                                           dnw(w,j,s)=g=anw(w,j,s)+stn(w,s,j);
constraint10_3(w,j,s)$(ord(s)>1 and ord(s)<11 and ord(j) ne 6 and ord(j) ne 8)..                                                              dnw(w,j,s)=g=anw(w,j,s)+stn(w,s,j);

constraint11(w,i,s)$(ord(s)>1)..                                                                                                              dsw(w,i,s)=g=ds(i,s);
constraint12(w,j,s)$(ord(s)<card(s))..                                                                                                        dnw(w,j,s)=g=dn(j,s);
Model SecondStage /All/;
option mip = cplex;
option limrow=1000;
option optcr=0.05
option reslim=1000000;
Solve SecondStage using miP minimizing z;
Display Z.l, Asw.l, Anw.l, Dsw.l, Dnw.l, Y.l;
execute_unload "data-mixed.gdx"
execute 'gdxxrw.exe Data-mixed.gdx var=asw.l rng=results_w!a1  var=dsw.l rng=results_w!a182  var=anw.l rng=results_w!a364    var=dnw.l rng=results_w!a547'
