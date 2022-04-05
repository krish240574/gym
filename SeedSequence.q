\d .sseq
\l utils.q
\l p.q
/ https://gist.github.com/bsolomon1124/da87640fb411f6e273f2dca82b90c71a
/ https://github.com/python/cpython/blob/af2277e461aee4eb96affd06b4af25aad31c81ea/Lib/random.py#L797
/ https://gist.github.com/rkern/9502a19c5926a139ce7deb5bca76c312
e:((&/) raze (enlist "x86_64") in (system "uname --hardware-platform"));
ur:.p.import[`os]`:urandom; / will implement the C code here soon
i2b:.utl.i2b;
b2i:.utl.b2i;
h2i:.utl.h2i;
idx:32+til 32;
gz:{(&/)(0<) all x};
ate: abs type each;
at:{abs type x};
ui:"i"$;
li:"j"$;

/ get random bits
i.grb:{[k]$[k<0;:`neg;];rn:"j"$ur[nb:(k+7) div 8]`;r:$[e;rn;reverse rn];:.utl.b2i prev/[(nb*8)-k;.utl.i2b sum ("j"$256 xexp reverse til count rn)*r]};

i.init:{[e;pe;skey;psz]
 i.psz:psz;
/ $[0=count e;i.e:i.grb[i.psz*32];]; 
 i.e:(1000000i,2000000i,20000i);
 i.pe:pe;
 /i.skey:enlist skey;
 i.skey:skey;
 i.pool:psz#0i;
 :getae[];};
/ i.mixe[getae[]];};

/ i.mixe:{[ae]
i.l:() 
i.ifi:{[n]
 $[0h=type n;[k:(&/)(n>0)0;n:n[0;0]];k:(&/)(n>0)];
 $[k;
  i.l::i.l,li b2i (i2b n)&((i2b h2i["0xffffffff"]) );
  i.ifi[prev/[32;i2b n]]
  ]};
i.c2u32:{
 show x;
 show count raze x;
 show raze string "type is ",type x;
 $[(0h=type x) & $[1<=count raze x;(6h=ate x)0;(6h=ate x)]; 
  :i.l::x;
  $[10h=at x; 
   $["0x" in  enlist x 0 1;
     :h2i[x];
     $[x like raze (count x)#enlist"[0-9]";
       :sum (ui (10 xexp reverse til count x))*(-48+"i"$x);
      ];
    ];
   ]
  ];
 show raze string "count x = ",count x;
 show x;
 $[(1=count x); $[((6h=at x)|(7h=at x));i.ifi li raze each x;i.ifi each raze x];
/   [i.ifi x;show "just after ifi"];
   $[0=count x;
     :ui ();
     [show "recursion"; i.c2u32 each li x ] 
    ]
  ]}

getae:{
 re:i.c2u32[i.e];
 show "here 1";
 $[0=count i.pe;i.pe:ui ();i.pe:i.c2u32[i.pe]];
 show "here 2";
 spe:i.c2u32[i.skey];
 show "here 3";
 :enlist(re,i.pe,spe)
 };

