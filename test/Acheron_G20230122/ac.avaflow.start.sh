# Run from this directory
cd "${0%/*}" || exit

#Launching r.avaflow 3 computational experiments for the Acheron Rock Avalanche

aoicoords="5204600,5201200,1489200,1493400"
profile="1489469,5203883,1489620,5203930,1489794,5204000,1489967,5204034,1490209,5204086,1490357,5204104,1490461,5204130,1490590,5204112,1490712,5204026,1490859,5203679,1491075,5203541,1491327,5203324,1491405,5203237,1491509,5203142,1491734,5202934,1491803,5202804,1491829,5202700,1491864,5202510,1491907,5202397,1492002,5202276,1492130,5202190,1492286,5202090,1492474,5202072,1492591,5201960,1492623,5201887,1492670,5201818,1492753,5201735,1492893,5201660,1493028,5201634,1493326,5201626"

r.in.gdal -o --overwrite input=DATA/ac_elev.asc output=ac_elev
r.in.gdal -o --overwrite input=DATA/ac_hrelease.asc output=ac_hrelease
r.in.gdal -o --overwrite input=DATA/ac_impactarea.asc output=ac_impactarea
r.in.gdal -o --overwrite input=DATA/ac_hdeposit.asc output=ac_hdeposit

g.region -s rast=ac_elev

r.mapcalc --overwrite "ac_hrelease1 = ac_hrelease*0.80" #solid release height
r.mapcalc --overwrite "ac_hrelease2 = ac_hrelease*0.10" #fine-solid release height
r.mapcalc --overwrite "ac_hrelease3 = ac_hrelease*0.10" #fluid release height


cd results
#Single simulation (Voellmy-type mixture model)
r.avaflow prefix=ac_voe aoicoords="$aoicoords" cellsize=20 phases=x elevation=ac_elev hrelease=ac_hrelease friction=40,10,4 basal=-7.0,0.01 controls=0,0,1,0,0,1,0,0,0,2,0 thresholds=1.0,100000,100000,0.0001 time=10,200 hdeposit=ac_hdeposit impactarea=ac_impactarea visualization=0.1,5.0,5.0,1,100,2,-11000,9000,100,0.60,0.25,0.15,0.2,1.0,"C:/Program Files/ParaView 5.10.0-Windows-Python3.9-msvc2017-AMD64/bin",None,None profile="$profile" ctrlpoints=1490209,5204086

g.region -d

#Single simulation (One-phase model with solid only)
r.avaflow prefix=ac_pu1 aoicoords="$aoicoords" cellsize=20 phases=s elevation=ac_elev hrelease=ac_hrelease friction=40,10,0.05 basal=-7.0,0.01 controls=0,0,1,0,0,1,0,0,0,2,0 thresholds=1.0,100000,100000,0.0001 time=10,200 hdeposit=ac_hdeposit impactarea=ac_impactarea visualization=0.1,5.0,5.0,1,100,2,-11000,9000,100,0.60,0.25,0.15,0.2,1.0,"C:/Program Files/ParaView 5.10.0-Windows-Python3.9-msvc2017-AMD64/bin",None,None ctrlpoints=1490209,5204086

g.region -d

#Single simulation (Multi-phase model with two phases)
r.avaflow prefix=ac_pu2 aoicoords="$aoicoords" cellsize=20 phases=m elevation=ac_elev hrelease=ac_hrelease rhrelease1=0.8 friction=40,15,-9999,-9999,0,0,0.01 basal=-7,0.01 controls=0,0,1,0,0,1,0,0,0,2,0 thresholds=1.0,100000,100000,0.0001 time=10,200 hdeposit=ac_hdeposit impactarea=ac_impactarea visualization=0.1,5.0,5.0,1,100,2,-11000,9000,100,0.60,0.25,0.15,0.2,1.0,"C:/Program Files/ParaView 5.10.0-Windows-Python3.9-msvc2017-AMD64/bin",None,None profile="$profile" ctrlpoints=1490209,5204086

g.region -d

#Single simulation (Multi-phase model with three phases)
r.avaflow prefix=ac_pu3 aoicoords="$aoicoords" cellsize=20 phases=m elevation=ac_elev hrelease1=ac_hrelease1 hrelease2=ac_hrelease2 hrelease3=ac_hrelease3 hdeposit=ac_hdeposit impactarea=ac_impactarea friction=40,15,0,0,0,0,0.05 viscosity=-9999,-9999,0,-9999,-3,0 basal=-7.0,0.01 controls=0,0,1,0,0,1,0,0,0,2,0 thresholds=1.0,100000,100000,0.0001 time=10,200 visualization=0.1,5.0,5.0,1,100,2,-11000,9000,100,0.60,0.25,0.15,0.2,1.0,"C:/Program Files/ParaView 5.10.0-Windows-Python3.9-msvc2017-AMD64/bin",None,None profile="$profile" ctrlpoints=1490209,5204086

g.region -d

#Multiple simulations (Voellmy-type mixture model)
r.avaflow -m prefix=ac_voem aoicoords="$aoicoords" cellsize=20 phases=x elevation=ac_elev hrelease=ac_hrelease hdeposit=ac_hdeposit impactarea=ac_impactarea friction=40,40,0,8,12,5,3,4,5 basal=-7.0,-7.0,0,0.01,0.01,0 controls=0,0,1,0,0,0,0,0,0,2,0 thresholds=1.0,100000,100000,0.0001 sampling=0 time=10,200 profile="$profile" ctrlpoints=1490209,5204086

g.region -d

#Multiple simulations (Multi-phase model with two phases)
r.avaflow -m prefix=ac_pu2m aoicoords="$aoicoords" cellsize=20 phases=m elevation=ac_elev hrelease=ac_hrelease rhrelease1=0.8 vhrelease=0.6,1.4,5 hdeposit=ac_hdeposit impactarea=ac_impactarea friction=40,40,0,13,17,5,-9999,-9999,0,-9999,-9999,0,0,0,0,0,0,0,0.05,0.05,0 basal=-7,-7,0,0.01,0.01,0 controls=0,0,1,0,0,1,0,0,0,2,0 thresholds=1.0,100000,100000,0.0001 sampling=0 time=10,200 profile="$profile" ctrlpoints=1490209,5204086

g.region -d
