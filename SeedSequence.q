\d .sseq
\l utils.q

e:((&/) raze (enlist "x86_64") in (system "uname --hardware-platform"));
ur:.p.import[`os]`:urandom; / will implement the C code here soon

/ mix[getae[]])
i.grb:{[k]$[k<0;:`neg;];rn:"j"$ur[nb:(k+7) div 8]`;r:$[e;rn;reverse rn];:.utl.b2i prev/[(nb*8)-k;.utl.i2b sum ("j"$256 xexp reverse til count rn)*r]};
i.entropy:i.grb[psz*32];
i.prog_entropy:pre;
i.spwn_kwy:enlist spwn_key
i.poolsz:psz;
i.pool:psz#0i;
i2b:.utl.i2b;
b2i:.utl.b2i;
h2i:.utl.h2i;
i.l:();
i.ifi:{[n]$[0<n;i.l,:"j"$b2i (i2b n)&(i2b h2i["0xffffffff"]);foo[prev/[32;n]]]};

i.c2u32:{[]
 $[(0=type x) & (6h=type each x)0;:x; / if array and each element is int
  $[10h=type x; / if string
    $["0x" in  enlist x 0 1;:utl.h2i[x]; / string starts with "0x"
       $[x like raze (count x)#enlist"[0-9"];:sum ("i"$(10 xexp reverse til count x))*(-48+"i"$x);] / end else if all chars are digits
     ] / end if starts with "0x"
   ;:`unrec] / end if string
 $[(x>0) & 6h=type x;i.ifi[x];[0>count x;:"i"$();i.c2u32 each x]]; / if type is int and non-zero

getae:{[]
/ Convert and assemble all entropy sources into a uniform uint32 array
};
