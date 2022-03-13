\d .utl
h2i:{[hex]
 wr:(ci:"i"$upper hex[2+til -2 + count hex])<=57;
 ci:@[ci;where wr;:;-48+ci[where wr]];
 ci:@[ci;where not wr;:;-55+ci[where not wr]];
 "j"$sum ci*(16 xexp reverse til -2+count hex)}

i2b:0b vs;
b2i:0b sv;
