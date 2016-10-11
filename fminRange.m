function output = fminRange(u, lonlat)
% Determines if the firemask intersects the box given by lonlat
% Returns true if one of the 4 corners lands in lonlat

% fmTL = Top Left of firemask
% fmTR = Top Right of firemask
% fmBL = Bottom Left of firemask
% fmBR = Bottom Right of firemask


% These represent cases where the corner of a firemask lands in the box
fmLonTL = u.long(1);
fmLonTR = u.long(size(u.long, 1),1);
fmLonBL = u.long(1,size(u.long,2));
fmLonBR = u.long(length(u.long));

fmLatTL  = u.lat(1);
fmLatTR  = u.lat(size(u.lat,1),1);
fmLatBL  = u.lat(1, size(u.lat,2));
fmLatBR  = u.lat(length(u.long));

fmLonTLinRange = fmLonTL > lonlat(1) && fmLonTL < lonlat(2);
fmLonTRinRange = fmLonTR > lonlat(1) && fmLonTR < lonlat(2);
fmLonBLinRange = fmLonBL > lonlat(1) && fmLonBL < lonlat(2);
fmLonBRinRange = fmLonBR > lonlat(1) && fmLonBR < lonlat(2);

fmLatTLinRange = fmLatTL > lonlat(3) && fmLatTL < lonlat(4);
fmLatTRinRange = fmLatTR > lonlat(3) && fmLatTR < lonlat(4);
fmLatBLinRange = fmLatBL > lonlat(3) && fmLatBL < lonlat(4);
fmLatBRinRange = fmLatBR > lonlat(3) && fmLatBR < lonlat(4);

fmTLinRange = fmLonTLinRange && fmLatTLinRange;
fmTRinRange = fmLonTRinRange && fmLatTRinRange;
fmBLinRange = fmLonBLinRange && fmLatBLinRange;
fmBRinRange = fmLonBRinRange && fmLatBRinRange;

fminbox = fmTLinRange || fmTRinRange || fmBLinRange || fmBRinRange;

% These represent cases where the corner of the box lands in a firemask
boxLonL = lonlat(1);
boxLonR = lonlat(2);
boxLatT = lonlat(3);
boxLatB = lonlat(4);

boxLonLinRange = (boxLonL > fmLonTL && boxLonL < fmLonTR) || (boxLonL > fmLonBL && boxLonL < fmLonBR);
boxLonRinRange = (boxLonR > fmLonTL && boxLonR < fmLonTR) || (boxLonR > fmLonBL && boxLonR < fmLonBR);
boxLatTinRange = (boxLatT > fmLatBL && boxLatT < fmLatTL) || (boxLatT > fmLatBR && boxLatT < fmLatTR);
boxLatBinRange = (boxLatB > fmLatBL && boxLatB < fmLatTL) || (boxLatB > fmLatBR && boxLatB < fmLatTR);

boxinfm = boxLonLinRange && boxLonRinRange && boxLatTinRange && boxLatBinRange;

output = fminbox || boxinfm;
end
