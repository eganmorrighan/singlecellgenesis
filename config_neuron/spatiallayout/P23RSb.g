// genesis

// Arranging the P23RSb cells in space.

echo Creating P23RSb network

//float	P23RSb_SEPX = 25e-6
//float	P23RSb_SEPY = 25e-6
//float	P23RSb_NX = 5
//float	P23RSb_NY = 5

float originxmin
float originymin

// Unique number for each cell type (same as spike number)
int typenum = 2

int ydex
float placer

float randzpos
int i,j
int k = 0

placer = {mynode}/{sqrtNnodes}

//echo placer= {placer}

ydex = { round {placer} }

//echo ydex= {ydex}

originxmin = ({mynode}-{ydex}*sqrtNnodes)*P23RSb_NX*P23RSb_SEPX

//echo originxmin= {originxmin}

originymin = {ydex}*P23RSb_NY*P23RSb_SEPY

//echo originymin= {originymin}

create neutral /P23RSbnet

// Random orientation
float randrotation
addfield /P23RSb rotation

// CREATING THE PLANE OF P23RSb cells
//createmap /P23RSb /P23RSbnet  \
//	{P23RSb_NX} {P23RSb_NY} \
//	-delta {P23RSb_SEPX} {P23RSb_SEPY} \
//	-origin {originxmin} {originymin}

// Note that these cells' positions overlap.  This doesn't cause any
// problems since we can refer to them as separate groups.

for (j = 0; j < P23RSb_NY; j = j+1)
     for (i = 0; i < P23RSb_NX; i = i+1)

          int newrandseed = {{ {typenum} @0@ {trunc {{{originxmin}+{B23FS_SEPX}*{i}}/{SEPX}}} @0@ {trunc {{{originymin}+{B23FS_SEPY}*{j}}/{SEPY}}} } + {myrandseed}}
          randseed {newrandseed}
          randzpos = { rand 1602e-6 2871e-6 }

          copy /P23RSb /P23RSbnet/P23RSb[{k}]
          position /P23RSbnet/P23RSb[{k}] \
            {originxmin + P23RSb_SEPX*i} {originymin + P23RSb_SEPY*j} {randzpos}

          // Rotate about z-axis ("twirl" in GENESIS cellsheet terminology)
          if ({rotateneurons} == 1)
              randrotation = {rand 0 6.283185308 }
              setfield /P23RSbnet/P23RSb[{k}] rotation {randrotation} // save for posterity
              rotcoord /P23RSbnet/P23RSb[{k}] {randrotation} -z
          end

          k=k+1

          echo Position P23RSb {mynode} {i} {j} {originxmin} {originymin} {originxmin + P23RSb_SEPX*i} {originymin + P23RSb_SEPY*j} {randzpos}

     end
end
