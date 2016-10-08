% assumes wrf-fire on the same level
cwd__=pwd
addpath(pwd)
cd ../wrf-fire/wrfv2_fire/test/em_fire
startup
cd(cwd__)
clear cwd__