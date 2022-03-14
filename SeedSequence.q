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
uint:"i"$;
long:"j"$;

/ get random bits
i.grb:{[k]$[k<0;:`neg;];rn:"j"$ur[nb:(k+7) div 8]`;r:$[e;rn;reverse rn];:.utl.b2i prev/[(nb*8)-k;.utl.i2b sum ("j"$256 xexp reverse til count rn)*r]};
i.init:{[entropy;prog_entrpy;spwn_key;psz]
 i.entropy:i.grb[i.poolsz*32]; 
 i.prog_entropy:prog_entrpy;
 i.spwn_kwy:enlist spwn_key
 i.poolsz:psz;
 i.pool:psz#0i;
 i.mix_entrpy[getae];};

i.ifi:{[n]i.l:();$[0<n;i.l,:long b2i (i2b n)&((i2b h2i["0xffffffff"]) idx);i.ifi[prev/[32;n]]]};
i.c2u32:{
 $[(0h=type x) & (gz x) & (6h=ate x)0;
  :x;
  $[10h=at x; 
   $["0x" in  enlist x 0 1;
     :h2i[x];
     $[x like raze (count x)#enlist"[0-9]";
       :sum (uint (10 xexp reverse til count x))*(-48+"i"$x);
      ];
    ];
   ]
  ];
 $[(1=count x) & 6h=at x;
  i.ifi x 0;
  $[0=count x;
   :uint ();
   i.c2u32 each enlist each uint x
   ]
  ]}

getae:{
 runentrp:i.c2u32[i.entropy];
 $[()=i.prog_entropy;
  i.prog_entropy:uint ();
  i.prog_entropy:i.c2u32(i.prog_entropy)
  ];
 spentr:i.c2u32[i.spwn_key];
 :(runentrp,i.prog_entropy,spentr)
 };

