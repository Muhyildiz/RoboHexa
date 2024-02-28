clear 
clc

%%
run('rvctools\startup_rvc.m') %% Runing Peter Corke Robotics Toolbox

L_1 = 43; % length of Coxa in cm
L_2 = 60;  % length of Fumer in cm
L_3 = 104;  % length of Tibia in cm



L(1) = Link([0 0 L_1 -pi/2]);
L(2) = Link([0 0 L_2 0]);
L(3) = Link([0 0 L_3 0]);


Rob = SerialLink(L);
Rob.name = 'Hexa Leg'
%%
Rob.plot([0 0 0])

Rob.teach
