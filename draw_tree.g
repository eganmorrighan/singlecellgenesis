str element
str shortelement
str mysource
str mydest
str outfile

// By synapse target:
// foreach element ({el /#net/#[]/#/Inh_ch#,/#net/#[]/#/Ex_ch#})
//    int syncount = {getsyncount {element}}
//    for (i=0; i<=syncount-1; i=i+1) 
//       mysource = {getsynsrc {element} {i}}
//       if ({mysource} != "/post")
//          echo {getsynsrc {element} {i}} {getfield {getsynsrc {element} {i}} x} {getfield {getsynsrc {element} {i}} y} {getfield {getsynsrc {element} {i}} z} {element} {getfield {element} x} {getfield {element} y} {getfield {element} z}
//       end
//    end
// end

// By spike generator (soma):
// List source properties and outgoing messages
int thisnode
//TESTING for (thisnode=3; {thisnode < 4}; thisnode={{thisnode}+1})
//sleep {{thisnode} * 20} // allow 20 seconds
for (thisnode=0; {thisnode < {Nnodes}}; thisnode={{thisnode}+1})
    if ({thisnode} == {mynode})
        echo Listing connections for node {thisnode}
        foreach element ({el /#net/#[]/soma/spk#})
            outfile = {"data/connections/" @ {myzeropadnode} @ {strsub {element} / _ -all} @ ".txt"}
            echo {thisnode} {element} {getfield {element} x} {getfield {element} y} {getfield {element} z} {getfield {element}/../.. rotation} >> {outfile}
            rshowmsg {element} >> {outfile}
            //echo {thisnode} {element} {getfield {element} x} {getfield {element} y} {getfield {element} z} {getfield {element}/../.. rotation} > /dev/null
            //async rshowmsg {element} > /dev/null
        end
    end
    barrier
end

// It's not currently possible to get the synaptic weight for remote
// connections, e.g.:
// echo {getfield@1 /C23FSnet/C23FS/distdendSmidb/Ex_ch15P23RSAMPA synapse[7].weight}

