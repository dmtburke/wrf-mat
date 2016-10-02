MOD14 Files:

The MOD14 files contain
fire_mask:
Array containing sensor data for each pixel
Classes: 0 missing input data 1 not processed (obsolete) 2 not processed (obsolete) 3 non-fire water 4 cloud 5 non-fire land 6 unknown 7 fire (low confidence) 8 fire (nominal confidence) 9 fire (high confidence)

FP_latitude:
Variable length vector (the number of pixels identified as firepixels) containing latitude of firepixels

FP_longitude:
Variable length vector (the number of pixels identified as firepixels) containing longitude of firepixels

FP_confidence:
Variable length vector (the number of pixels identified as firepixels) containing confidence of fire identification

MOD03 Files:

The MOD03 files contain

Latitude:
Array (same size as fire_mask) containing the latitude of each pixel

Longitude:
Array (same size as fire_mask) containing the longitude of each pixel

Function files:

mod2mat.m

Contains function mod2mat, which takes MOD14 filename of the form MOD14.A[year][dayinyear].[24hrtime].[version].[timetaken].hdf, finds the corresponding MOD03 file (of the same form, just MOD03 at the front), and combines the relevant data into a struct with 5 fields:
u.data  - array which contains the fire_mask data
u.long  - array which contains the longitudes of each pixel in the fire_mask data
u.lat   - array which contains the latitude of each pixel in the fire_mask data
u.conf  - array which contains the confidence of fire identification of each pixel in the fire_mask data (no fire is 0 confidence) from 1-100
u.title - the file name where the struct is saved, similar to what was given, A[year][dayinyear].[24hrtime].[version].mat 

allmod2mat.m

Contains function allmod2mat, which takes all of the MOD14 files in a directory and feeds them through the mod2mat function

showmat.m

Contains function showmat which takes a struct and pushes it through the geoshow function, allowing just one swath to be plotted

showmatfiles.m

Contains function showmatfiles(lonlat) which takes a range for latitude and longitude (default is a box containing the united states) and plots all firemasks which intersect that box to a single figure. Optional output for the function is a cell array containing the filenames for the firemasks which were used to make the plot.

The input is expected in the form [ LowerLongitudeBound UpperLongitudeBound LowerLatitudeBound UpperLatitudeBound ]
