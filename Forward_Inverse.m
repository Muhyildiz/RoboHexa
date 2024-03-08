%% Initializing Workspace 
clear 
clc

% Define the symbolic variables for joint angles
syms theta1 theta2 theta3 L1 L2 L3 X Y r11 r12 r13 r21 r22 r23 r31 r32 r33 x y z real

%% *1. Forward Kinematics* 


DH_params = [theta1, 0, L1, deg2rad(90);
             theta2, 0, L2, deg2rad(0);
             theta3, 0, L3, deg2rad(0)];

% Convert DH parameters matrix to a table
DH_table = array2table(DH_params, 'VariableNames', {'Theta', 'd', 'a', 'alpha'})


% Initialize transformation matrix
T = eye(4);

% Calculate transformation matrix from base to end effector
for i = 1:size(DH_params, 1)
        theta = DH_params(i, 1);
        d = DH_params(i, 2);
        a = DH_params(i, 3);
        alpha = DH_params(i, 4);
    

    % Calculate individual transformation matrix for joint i
    Ti = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
          sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
          0,           sin(alpha),             cos(alpha),            d;
          0,           0,                      0,                     1]
    
    
    % Multiply to get the overall transformation matrix
    T = T * Ti;
end

% Simplify the overall transformation matrix
T = simplify(T);

% Display the transformation matrix
disp('The transformation matrix from base to end effector is:');
disp(T);


Px = T(1,4)
Py = T(2,4)
Pz = T(3,4)
%%
T01 = [cos(theta1), 0,  sin(theta1), L1*cos(theta1)
       sin(theta1), 0, -cos(theta1), L1*sin(theta1)
         0,         1,            0,              0
         0,         0,            0,              1];

T12 = [cos(theta2), -sin(theta2), 0, L2*cos(theta2)
       sin(theta2),  cos(theta2), 0, L2*sin(theta2)
         0,            0,        1,              0
         0,            0,        0,              1];

T23 = [cos(theta3), -sin(theta3), 0, L3*cos(theta3)
       sin(theta3),  cos(theta3), 0, L3*sin(theta3)
        0,            0,          1,             0
        0,            0,          0,             1];

%%
TT03 =[r11, r12, r13, x;
       r21, r22, r23, y;
       r31, r32, r33, z;
        0,   0,   0,  1];

%% *2. Inverse kinematics*

% * *For Theta 1 (*$\theta_1$*)*

Theta_1 = simplify(x/y==T(1,4)/T(2,4))
%% 
% 
%% 
% * *For Theta 3 (*$\theta_3$*)*

TT13 = simplify(inv(T01)*TT03)
T13 = simplify(inv(T01)*T)
%%
Theta_3 = simplify(solve(simplify(T13(1,4)^2+T13(2,4)^2) == simplify(TT13(1,4)^2+TT13(2,4)^2),theta3))
%% 
% * *For Theta 2 (*$\theta_2$*)*

Theta_2 = simplify(solve(simplify(T13(1,4)/T13(2,4)) == simplify(TT13(1,4)/TT13(2,4)),theta2))
%% 
L1 = 43;
L2 = 60;
L3 = 104;

Theta_1
Theta_2
Theta_3
