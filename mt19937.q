/ MT19937 - random number generator implementation
/ coefficients for MT19937-32 bit word-length
 MT19937 - random number generator implementation
/ coefficients for MT19937-32 bit word-length
/ use strings for hex values, hex2i converts to long
\d .rng
i.w:32;i.n:624;i.m:397;i.r:31;i.a:"0x9908B0DF";i.u:11;i.d:"0xFFFFFFFF";i.s:7;i.b:"0x9D2C5680";i.t:15;i.c:"0xEFC60000";i.l:18;i.f:1812433253;
i.MT:(i.n:624)#0;i.index:i.n+1;i.lm:"0x7FFFFFFF";i.um:"0x80000000";i2b:0b vs;b2i:0b sv;i.iflg:0;
seed:{[seed]i.MT[0]:seed};

h2i:{[hex]
 wr:(ci:"i"$upper hex[2+til -2 + count hex])<=57; ci:@[ci;where wr;:;-48+ci[where wr]]; ci:@[ci;where not wr;:;-55+ci[where not wr]];
 "j"$sum ci*(16 xexp reverse til -2+count hex)}

i.init:{
 temp:"j"$x+i.f*b2i ((i2b i.MT[x-1])<>prev/[(i.w-2); (i2b i.MT[x-1])])i.w + til i.w;
 i.MT[x]:b2i (i2b temp)&(i2b h2i["0xffffffff"])}

i.twst:{
 g:(b2i (i2b i.MT[x])&(i2b h2i[i.um])) + b2i (i2b i.MT[(x+1) mod i.n])&(i2b h2i[i.lm]); xA:prev i2b g;
 $[0<>g mod 2;xA:xA<>(i2b g);]; i.MT[x]:b2i (i2b i.MT[(x+i.m) mod i.n])<>xA}
 
ex_num:{[sd]
 $[0=i.iflg;[seed[sd];i.init each 1+til -1+i.n;i.iflg::1];]; / call init only once
 $[i.index>=i.n;[i.twst each til i.n;i.index::0];];
 y:i2b i.MT[i.index]; y:y<>(i2b h2i[i.d])&prev/[i.u;y]; y:y<>(i2b h2i[i.b])&next/[i.s;y]; y:y<>(i2b h2i[i.c])&prev/[i.t;y]; y:y<>next y; i.index+:1;
 :(i.MT[0],b2i y&(i2b h2i["0xffffffff"]))} /return the seed and generated number

/ usage - .rng.ex_num[seed]
