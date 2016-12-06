function [output] = showmatfiles(lonlat)
% Use geoshow to display the .mat files in the current directory which
% intersect the square given by lonlat
% lonlat = [ lonMin lonMax latMin latMax ]

if ~exist('lonlat', 'var')
    disp('Using default US box, [-130 -70 20 60].');
    lonlat = [-130 -70 20 60];
else
    disp('Using');
    disp(lonlat);
end


d=dir('*.mat');d={d.name};

output = [];


for i=1:length(d)
    load(d{i});
    
    if firemaskinRange(u, lonlat)
        disp(['Drawing ' d{i} '...']);
        
        %axis(lonlat);
        
        xlabel('Longitude (deg)')
        ylabel('Latitude (deg)')

        geoshow(u.lat, u.long, u.data, cmapmod14);
        
        hold on
        
        output{length(output)+1} = d{i};
        
    else
        disp(['Skipping ' d{i} '...']);
    end
end
hold off
end