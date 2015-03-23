// genesis

// Arranging the P5IBa cells in space.

echo Creating P5IBa network

//float	P5IBa_SEPX = 25e-6
//float	P5IBa_SEPY = 25e-6
//float	P5IBa_NX = 5
//float	P5IBa_NY = 5

float originxmin
float originymin

// Unique number for each cell type (same as spike number)
int typenum = 6

int ydex
float placer

float randzpos
int i,j
int k = 0

placer = {mynode}/{sqrtNnodes}

//echo placer= {placer}

ydex = { round {placer} }

//echo ydex= {ydex}

originxmin = ({mynode}-{ydex}*sqrtNnodes)*P5IBa_NX*P5IBa_SEPX

//echo originxmin= {originxmin}

originymin = {ydex}*P5IBa_NY*P5IBa_SEPY

//echo originymin= {originymin}

create neutral /P5IBanet

// Random orientation
float randrotation
addfield /P5IBa rotation

// CREATING THE PLANE OF P5IBa cells
//createmap /P5IBa /P5IBanet  \
//	{P5IBa_NX} {P5IBa_NY} \
//	-delta {P5IBa_SEPX} {P5IBa_SEPY} \
//	-origin {originxmin} {originymin}

// Note that these cells' positions overlap.  This doesn't cause any
// problems since we can refer to them as separate groups.

for (j = 0; j < P5IBa_NY; j = j+1)
     for (i = 0; i < P5IBa_NX; i = i+1)

          int newrandseed = {{ {typenum} @0@ {trunc {{{originxmin}+{B23FS_SEPX}*{i}}/{SEPX}}} @0@ {trunc {{{originymin}+{B23FS_SEPY}*{j}}/{SEPY}}} } + {myrandseed}}
          randseed {newrandseed}
          randzpos = { rand 550e-6 1262e-6 }

          copy /P5IBa /P5IBanet/P5IBa[{k}]
          position /P5IBanet/P5IBa[{k}] \
            {originxmin + P5IBa_SEPX*i} {originymin + P5IBa_SEPY*j} {randzpos}

          // Rotate about z-axis ("twirl" in GENESIS cellsheet terminology)
          if ({rotateneurons} == 1)
              randrotation = {rand 0 6.283185308 }
              setfield /P5IBanet/P5IBa[{k}] rotation {randrotation} // save for posterity
              rotcoord /P5IBanet/P5IBa[{k}] {randrotation} -z
          end

          k=k+1

          echo Position P5IBa {mynode} {i} {j} {originxmin} {originymin} {originxmin + P5IBa_SEPX*i} {originymin + P5IBa_SEPY*j} {randzpos}

     end
end
