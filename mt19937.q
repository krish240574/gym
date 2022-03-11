/ MT19937 - random number generator implementation
/ coefficients for MT19937
w:32;n:624;m:397;r:31
a:"0x9908B0DF" / use strings for hex values, hex2i converts to long
hex2i:{[hex] 
 w:(ci:"i"$upper hex[2+til -2 + count hex])<=57;
 ci:@[ci;where w;:;-48+ci[where w]]; ci:@[ci;where not w;:;-55+ci[where not w]];
 "j"$sum ci*(16 xexp reverse til -2+count hex)}

u:11;d:"0xFFFFFFFF";s:7;b:"0x9D2C5680";t:15;c:"0xEFC60000";l:18;f:1812433253;
MT:(n:624)#0;index:n+1;lm:"0x7FFFFFFF";um:"0x80000000"; 
/ this is the init function , I'll clean it up
init:{temp:"j"$x+f*0b sv ((0b vs MT[x-1])<>prev/[(w-2);(0b vs MT[x-1])])w + til w;show x,temp;MT[x]:0b sv (0b vs temp)&(0b vs hex2i["0xffffffff"]);}
