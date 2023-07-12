function [ X6,Y6,Z6,ax,by,cz,rx,ry,rz ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明

theta3 = theta3-90; % t3-pi/2

T1 = [cosd(theta1) sind(theta1) 0 0; -sind(theta1) cosd(theta1) 0 0; 0 0 1 0.675; 0 0 0 1];
T2 = [cosd(theta2) -sind(theta2) 0 0.260; 0 0 1 0; -sind(theta2) -cosd(theta2) 0 0; 0 0 0 1];
T3 = [cosd(theta3) -sind(theta3) 0 0.680; sind(theta3) cosd(theta3) 0 0; 0 0 1 0; 0 0 0 1];
T4 = [cosd(theta4) -sind(theta4) 0 -0.035; 0 0 1 0.670; -sind(theta4) -cosd(theta4) 0 0; 0 0 0 1];
T5 = [cosd(theta5) -sind(theta5) 0 0; 0 0 -1 0; sind(theta5) cosd(theta5) 0 0; 0 0 0 1];
T6 = [cosd(theta6) -sind(theta6) 0 -0.430; 0 0 1 0; -sind(theta6) -cosd(theta6) 0 0; 0 0 0 1];

T5_r = [cosd(theta5) sind(theta5) 0 -0.430; 0 0 1 0; sind(theta5) -cosd(theta5) 0 0; 0 0 0 1];
T6_r = [1 0 0 0; 0 cosd(theta6) -sind(theta6) 0;0 sind(theta6) cosd(theta6) 0; 0 0 0 1];

T16 = 1000*T1*T2*T3*T4*T5*T6;
X6 = T16(1,4); Y6 = T16(2,4); Z6 = T16(3,4);

T16_r = T1*T2*T3*T4*T5_r*T6_r;

R_T = [ -T16_r(1,2),-T16_r(1,3),T16_r(1,1); -T16_r(2,2),-T16_r(2,3),T16_r(2,1); -T16_r(3,2),-T16_r(3,3),T16_r(3,1)];

ax = R_T(1,3); by = R_T(2,3); cz = R_T(3,3); 

ry = atan2( R_T(3,1) , sqrt( R_T(1,1)^2 + R_T(2,1)^2 ) )*180/pi;

rz = atan2( R_T(2,1) ,R_T(1,1) )*180/pi;

rx = atan2( R_T(3,2) ,R_T(3,3) )*180/pi;

% R_TN = [ cosd(rz)*cosd(ry) -cosd(rz)*sind(ry)*sind(rx) - sind(rz)*cosd(rx) -cosd(rz)*sind(ry)*cosd(rx) + sind(rz)*sind(rx);
%          sind(rz)*cosd(ry) -sind(rz)*sind(ry)*sind(rx) + cosd(rz)*cosd(rx) -sind(rz)*sind(ry)*cosd(rx) - cosd(rz)*sind(rx);
%             sind(ry)                          cosd(ry)*sind(rx)                    cosd(ry)*cosd(rx)]




end

