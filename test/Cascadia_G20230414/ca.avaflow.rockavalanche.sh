# Run from this directory
cd "${0%/*}" || exit

#Launching r.avaflow 3 computational experiments for the Cascadia Training Site

r.in.gdal -o --overwrite input=DATA/ca_elev.tif output=ca_elev
r.in.gdal -o --overwrite input=DATA/ca_avalanche.tif output=ca_avalanche

g.region -s rast=ca_elev


cd results
#Experiment #1 - Rock avalanche
r.avaflow -a prefix=ca_rock cellsize=20 aoicoords=4400,2200,1000,4000 phases=x elevation=ca_elev hrelease=ca_avalanche density=2800 friction=35,15,3 time=5,150 visualization=1.0,5.0,5.0,1,200,5,0,3000,50,0.60,0.60,0.10,0.2,1.0,None,None,None basal=-7.0,0.05

g.region -d

