clear all
%clc


coxa_length = 4.3;

femur_length=6.0;

tibia_length=10.8;

max_leg_length=coxa_length+femur_length+tibia_length;
% input caresian
x=15;
y=0;
z=7;
elbowup=0;
if(z<0)
    elbowup=1;
    z=abs(z);
end

leg_length=sqrt(x^2 + y^2); % end effector distance from the body
HF=sqrt((leg_length-coxa_length)^2 + z^2); % end effector distance the coxa
 
if (HF>femur_length+tibia_length) % Chech if the point is in the range.
    fprintf('point is out of range\n')
    return;
end
% add if statement for if(HF<x) because it will crack the body.
disp(leg_length)

A1=atan((leg_length-coxa_length)/z);
A1=rad2deg(A1);
disp(['A1: ' num2str(A1)]);

A2=acos((tibia_length^2 - femur_length^2 - HF^2)/(-2*femur_length*HF));
A2=real(rad2deg(A2));
disp(['A2: ' num2str(A2)]);

% coxa angle
coxa_angle=atan(y/x) ;
coxa_angle=rad2deg(coxa_angle);
disp(['coxa_angle: ' num2str(coxa_angle)]);

% femur angle
femur_angle=-90+(A1+A2); 
disp(['femur_angle: ' num2str(femur_angle)]);

% tibia angle
B1=acos((HF^2 - tibia_length^2 - femur_length^2)/(-2*femur_length*tibia_length));
B1=rad2deg(B1);
tibia_angle=-180+femur_angle+B1;

lengths=[coxa_length , femur_length , tibia_length];
angles=[coxa_angle , femur_angle , tibia_angle];


% Example usage with three lengths and three angles:
%  lengths = [4.3, 8.0, 10.4];
angles = [0, femur_angle, tibia_angle]; % angles in degrees
if (elbowup)
    angles=[0 , 2*A2-femur_angle , -2*A2+3*femur_angle];
end
fprintf('coxa angle: %d, femur angle: %d, tibia angle: %d \n',round(coxa_angle),round(angles(2)),round(angles(3)-angles(2)));

figure
plot_sequential_lines(lengths, angles);

% plot_sequential_lines function:
function plot_sequential_lines(lengths, angles)


    % Initialize the starting point at the origin
    start_point = [0, 0];
    % Initialize a figure for plotting
    %figure;
    legend('show');
    hold on;
    grid on;
    
    % Define colors for each line for visibility
    colors = ['r', 'g', 'b']; % red, green, blue
    
    % Loop through each line to be plotted
    for i = 1:3
        % Convert the angle from degrees to radians
        slope_rad = deg2rad(angles(i));
        
        % Calculate the end point of the current line
        end_point = start_point + [lengths(i) * cos(slope_rad), lengths(i) * sin(slope_rad)];
        
        % Plot the line
        plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], colors(i), 'LineWidth', 2);
        
        % Update the start point for the next line
        start_point = end_point;
    end
    legend(strcat('Femur angle=', num2str(angles(2)), ', Physical tibia angle=', num2str(angles(3)-angles(2))));
    
    % Set the axes limits for better visualization
    axis equal;
    xlim([-sum(lengths), sum(lengths)]);
    ylim([-sum(lengths), sum(lengths)]);
    
    % Adding labels and title
    xlabel('X');
    ylabel('Z');
    title('Z Variation from Side view while z is constant);
    
    hold off;
end
