\d .sseq
\l utils.q
\l p.q
/ https://gist.github.com/bsolomon1124/da87640fb411f6e273f2dca82b90c71a
/ https://github.com/python/cpython/blob/af2277e461aee4eb96affd06b4af25aad31c81ea/Lib/random.py#L797
/ https://gist.github.com/rkern/9502a19c5926a139ce7deb5bca76c312
e:((&/) raze (enlist "x86_64") in (system "uname --hardware-platform"));
ur:.p.import[`os]`:urandom; / will implement the C code here soon
i2b:.utl.i2b; b2i:.utl.b2i; h2i:.utl.h2i; idx:32+til 32;
gz:{(&/)(0<) all x}; ate: abs type each; at:{abs type x};
ui:"i"$; li:"j"$;
i.l:();
ff:"OxFFFFFFFF";
i.IA:li h2i["0x43b0d7e5"]; i.MA:li h2i["0x931e8875"]; i.MML:li h2i["0xca01f9dd"]; i.MMR:li h2i["0x4973f715"]; i.XS:16;
/i.XS = np.dtype(np.uint32).itemsize * 8 // 2
i.grb:{[k]$[k<0;:`neg;];rn:"j"$ur[nb:(k+7) div 8]`;r:$[e;rn;reverse rn];:.utl.b2i prev/[(nb*8)-k;.utl.i2b sum ("j"$256 xexp reverse til count rn)*r]};
i.ra:{[l]$[1<count l;[t:i2b each l;:li b2i t[0]|next/[32;t[1]]];:li l]};
i.hash:{[v]hc:i.IA;ma:i.MA;v:b2i (i2b v)|(i2b hc);hc*:ma;v*:hc;v:b2i (i2b v)|prev/[i.XS;i2b v];:v};
/ i.mix:{r:li (li x*i.MML)-li y*i.MMR;:b2i r|prev/[i.XS;i2b r]};
i.mix:{r:li (li x*i.MML)-li y*i.MMR;:b2i (i2b r)|prev/[i.XS;i2b r]};
i.ifi:{[n] $[n>0;[$[0=count i.l;i.l::n;[i.l::i.l,li b2i(i2b li n)&(i2b h2i ff);i.ifi[b2i prev/[32;i2b li n]]]]];:i.l]}
i.c2u32:{
 i.l::();
 $[(0h=type x) & (7h=at raze x)|(6h=at raze x);:x;];
 $[(7h=at x)|(6h=at x);[i.l::();i.ifi each x;:i.l];];
 $[10h=at x; 
   $["0x" in  enlist x 0 1;
      :h2i[x];
      $[x like raze (count x)#enlist"[0-9]";
        :sum (ui (10 xexp reverse til count x))*(-48+"i"$x);
       ];
    ];
  ] }

i.init:{[e;pe;skey;psz]
 i.psz:psz;
 $[0=count e;i.e:abs i.grb[i.psz*32];]; 
 i.pe:pe;
 i.skey:skey;
 i.pool:psz#0;
 ae:getae[];
 i.mixe[ae]};

i.mixe:{[ae]
 show "inside mixe";
 m:i.hash each i.ra each ui i.pool;
 / m[0]:'[;]/[(i.hash;i.ra)][ae 0];
 m:@[m;til i.psz;:;i.hash each i.ra each ae til i.psz];
 w::where each not t='(i.psz,i.psz)#t:til i.psz;
 m:{[ll;x]:@[ll;w x;:;i.mix .'(ll w x),\:i.hash[ll x]]}[m;]each t
 $[i.psz<count ae;
   [tmp:i.hash each ae i.psz + til (count ae)-i.psz;
   m i.mix/:\:tmp ];
  ];
 };

getae:{
 re:i.c2u32[i.e];
 show "here 1";
 show re;
 $[0=count i.pe;i.pe:ui ();i.pe:i.c2u32[i.pe]];
 show "here 2";
 spe:i.c2u32[i.skey];
 show "here 3";
 :(re;i.pe;spe)
 };

