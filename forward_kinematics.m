% Define the symbolic variables for joint angles
syms theta1 theta2 theta3 real

% Define the DH parameter table
% [theta, d, a, alpha]
DH_params = [theta1, 0, 43, deg2rad(-90);
             theta2, 0, 60, deg2rad(0);
             theta3, 0, 104, deg2rad(0)];
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
Px = T(3,4)

