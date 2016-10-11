function output = mod03Intersects(lonlat)
% Looks at all mod03 files in the current directory and checks if they land
% in the box given by lonlat

if ~exist('lonlat', 'var')
    disp('Using default US box, [-130 -70 20 60].');
    lonlat = [-130 -70 20 60];
else
    disp('Using');
    disp(lonlat);
end


d=dir(['MOD03','*.hdf']);d={d.name};
nfiles = length(d);

mod03LatPath  = '/MODIS_Swath_Type_GEO/Geolocation Fields/Latitude';
mod03LonPath = '/MODIS_Swath_Type_GEO/Geolocation Fields/Longitude';

output = {};

for i = 1:nfiles
    disp(['Checking ' d{i} '...']);
    mod03.lat  = hdfread(d{i}, mod03LatPath);
    mod03.long = hdfread(d{i}, mod03LonPath);
    if fminRange(mod03, lonlat)
        disp('Found intersection')
        output = [output; d{i}];
    end
end      

end
