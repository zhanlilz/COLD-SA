function mask = autoTmaskGreen(j_date,b_ref,yr,var1,T_const)
%% Multitepmoral cloud, cloud shadow, & snow masks (global version)
% read in data with 3 more consecutive clear obs & correct data
% Inputs:
% j_date: Julian date
% b_ref: Band 2 & 4 reflectance
% yr: number of years to mask 
%
% Outputs:
% y: corrected Band reflectance

yr = ceil(yr);
% yr = yr*2;
w = 2*pi/365.25; % anual cycle

TOA_B1_cft = autoRobustFit(j_date,b_ref,yr); % Green Band for multitemporal cloud/snow detection

% predict Band 1 ref
pred_B1 = TOA_B1_cft(1)+TOA_B1_cft(2)*cos(j_date*w)+TOA_B1_cft(3)*sin(j_date*w)...
    +TOA_B1_cft(4)*cos(j_date*w/yr)+TOA_B1_cft(5)*sin(j_date*w/yr);

% true or false ids
DeltaB1 = b_ref-pred_B1; % band 2

mask = zeros(length(j_date),1);
mask(abs(DeltaB1) > T_const*var1) = 1;
end
    


