/ MT19937 - random number generator implementation
/ coefficients for MT19937-32 bit word-length
w:32;n:624;m:397;r:31
a:"0x9908B0DF" / use strings for hex values, hex2i converts to long
u:11;d:"0xFFFFFFFF";s:7;b:"0x9D2C5680";t:15;c:"0xEFC60000";l:18;f:1812433253;
MT:(n:624)#0;index:n+1;lm:"0x7FFFFFFF";um:"0x80000000"; 
i2b:0b vs;
b2i:0b sv;
h2i:{[hex] w:(ci:"i"$upper hex[2+til -2 + count hex])<=57;ci:@[ci;where w;:;-48+ci[where w]];ci:@[ci;where not w;:;-55+ci[where not w]];"j"$sum ci*(16 xexp reverse til 8)}
init:{temp:"j"$x+f*b2i ((i2b MT[x-1])<>prev/[(w-2);(i2b MT[x-1])])w + til w;show x,temp;MT[x]:b2i (i2b temp)&(i2b h2i["0xffffffff"]);}
twst:{g:(b2i (i2b MT[x])&(i2b h2i[um])) + b2i (i2b MT[(x+1) mod n])&(i2b h2i[lm]);xA:prev i2b g;$[0<>g mod 2;xA:xA<>(i2b g);];MT[x]:b2i (i2b MT[(x+m) mod n])<>(xA)}
ex_num:{[dummy]show index;$[index>=n;[twst each til n;index::0];];y:i2b MT[index];y:y<>(i2b h2i[d])&prev/[u;y];y:y<>(i2b h2i[b])&next/[s;y];y:y<>(i2b h2i[c])&prev/[t;y];y:y<>next y;index+::1;:y&(i2b h2i["0xffffffff"])}

/ Usage : init each 1+til -1+n
/ b2i ex_num 0
