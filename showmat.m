function showmat(u)
% Display MODIS14 data
% From loading file converted by mod2mat.m
% input
% u.data    MODIS 14 data
% u.lat     latitudes of points in data
% u.long    longitudes of points in data


xlabel('Longitude (deg)');
ylabel('Latitude (deg)');

geoshow(u.lat, u.long, u.data, cmapmod14)


end
