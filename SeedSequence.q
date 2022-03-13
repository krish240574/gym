\d .sseq
\l utils.q
/ https://gist.github.com/bsolomon1124/da87640fb411f6e273f2dca82b90c71a
/ https://github.com/python/cpython/blob/af2277e461aee4eb96affd06b4af25aad31c81ea/Lib/random.py#L797
/ https://gist.github.com/rkern/9502a19c5926a139ce7deb5bca76c312
e:((&/) raze (enlist "x86_64") in (system "uname --hardware-platform"));
ur:.p.import[`os]`:urandom; / will implement the C code here soon

mix[getae[]])
i.grb:{[k]$[k<0;:`neg;];rn:"j"$ur[nb:(k+7) div 8]`;r:$[e;rn;reverse rn];:.utl.b2i prev/[(nb*8)-k;.utl.i2b sum ("j"$256 xexp reverse til count rn)*r]};
i.entropy:i.grb[psz*32];
i.prog_entropy:pre;
i.spwn_kwy:enlist spwn_key
i.poolsz:psz;
i.pool:psz#0i;
i.ifi:{@[`l;x;:;.utl.b2i qq&.utl.i2b .utl.h2i["0xffffffff"]];qq::prev qq};
c2u32:{[]
 $[(0=type x) & (6h=type each x)0;:x; / if array and each element is int
  $[10h=type x; / if string
    $["0x" in  enlist x 0 1;:utl.h2i[x]; / string starts with "0x"
       $[x like raze (count x)#enlist"[0-9"];:sum ("i"$(10 xexp reverse til count x))*(-48+"i"$x);] / end else if all chars are digits
     ] / end if starts with "0x"
   ;:`unrec] / end if string
 $[(x>0) & 6h=type x;[t:(count x)-first where x;l::tt#();ifi each til t;];]; / if type is int and non-zero

getae:{[]
/ Convert and assemble all entropy sources into a uniform uint32 array`
