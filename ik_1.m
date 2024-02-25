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
%tibia_angle=rad2deg(tibia_angle);
    
%tibia_angle=rad2deg(tibia_angle);


lengths=[coxa_length , femur_length , tibia_length];
angles=[coxa_angle , femur_angle , tibia_angle];






% Example usage with three lengths and three angles:
%  lengths = [4.3, 8.0, 10.4];
angles = [0, femur_angle, tibia_angle]; % angles in degrees
if (elbowup)
    angles=[0 , 2*A2-femur_angle , -2*A2+3*femur_angle];
    %x=A2-femur_angle;
    %x2=180+tibia_angle-femur_angle;
    %angles = [0, 2*A2-femur_angle, -1*(180-2*x-femur_angle-x2)];
    % the right equations:
    angles = [0, 2*A2-femur_angle, 2*A2-2*femur_angle+tibia_angle];
    %angles = [0, -femur_angle, -tibia_angle];
    %plot_robot_leg_3d(coxa_length, femur_length, tibia_length, 0, 2*A2-femur_angle, 2*A2-2*femur_angle+tibia_angle);
else
    %plot_robot_leg_3d(coxa_length, femur_length, tibia_length, 0, femur_angle, tibia_angle);
end
disp(['tibia_angle: ' num2str(tibia_angle)]);
fprintf('coxa angle: %d, femur angle: %d, tibia angle: %d \n',round(coxa_angle),round(angles(2)),round(angles(3)-angles(2)));

figure
plot_sequential_lines(lengths, angles);


%% live plot
% Loop through different z values
figure
for x = 0:0.1:18
    % Your existing code here
    z=8;
    z2=z;
    %x=15;
    y=0;
    elbowup=0;
    if(z<0)
       elbowup=1;
       z=abs(z);
    end
    % Update the z value
    z_value = z;

    leg_length=sqrt(x^2 + y^2); % end effector distance from the body
    % Update the calculations that depend on z
    HF = sqrt((leg_length - coxa_length)^2 + z_value^2);
    A1 = atan((leg_length - coxa_length) / z_value);
    A1 = rad2deg(A1);

    % ... (the rest of the calculations)
    A2=acos((tibia_length^2 - femur_length^2 - HF^2)/(-2*femur_length*HF));
    A2=real(rad2deg(A2));
    % coxa angle
    coxa_angle=atan(y/x) ;
    coxa_angle=rad2deg(coxa_angle);

    % femur angle
    femur_angle=-90+(A1+A2); 
    disp(['femur_angle: ' num2str(femur_angle)]);

    % tibia angle
    B1=acos((HF^2 - tibia_length^2 - femur_length^2)/(-2*femur_length*tibia_length));
    B1=rad2deg(B1);
    tibia_angle=-180+femur_angle+B1;

    % Update the angles vector
    angles = [0, femur_angle, tibia_angle];
    
    if (elbowup)
    angles = [0, 2*A2-femur_angle, 2*A2-2*femur_angle+tibia_angle];
    end

    % Call the plotting function
    lengths=[4.3 , 6.0 , 10.4];
    
    plot_sequential_lines(lengths, angles);

    x_vertical_line = leg_length;
    %line([x_vertical_line, x_vertical_line], ylim, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1);
    line(ylim, [-z2 , -z2],  'Color', 'k', 'LineStyle', '-', 'LineWidth', 1.5);
    % Pause to visualize each step
    pause(0);

    hold on

    clf;
    

end

%% 3D
% Plot the leg segments
function plot_robot_leg_3d(coxa_length, femur_length, tibia_length, coxa_angle, femur_angle, tibia_angle)
    % Define the coordinates of the leg segments
    coxa_end = [0, 0, 0];
    femur_end = [coxa_end(1)+femur_length*cosd(femur_angle), coxa_end(2)+0, coxa_end(3)+femur_length*sind(femur_angle)];
    tibia_end = [femur_end(1) + tibia_length*cosd(tibia_angle), femur_end(2)+0, femur_end(3)+tibia_length*sind(tibia_angle)];
    
    figure
    % Plot the leg segments
    plot3([-4.3, coxa_end(1)], [0, coxa_end(2)], [0, coxa_end(3)], 'r', 'LineWidth', 2);
    hold on;
    plot3([coxa_end(1), femur_end(1)], [coxa_end(2), femur_end(2)], [coxa_end(3), femur_end(3)], 'g', 'LineWidth', 2);
    
    plot3([femur_end(1), tibia_end(1)], [femur_end(2), tibia_end(2)], [femur_end(3), tibia_end(3)], 'b', 'LineWidth', 2);
    
    % Set axis limits
    %axis equal;
    %xlim([-5, 20]);
    %ylim([-15, 15]);
    %zlim([-5, 5]);
    
    % Set axis labels
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    % Set plot title
    title('3D Plot of a Robot Leg');
    
    % Show the plot
    hold off;
end






%% Function

function plot_sequential_lines(lengths, angles)
    % Check if the lengths and angles vectors have three elements
    if length(lengths) ~= 3 || length(angles) ~= 3
        error('The lengths and angles vectors must have exactly three elements.');
    end
    
    % Initialize the starting point at the origin
    %start_point = [-4.3, 0];
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
    %text(1, 1, ['femur Angle = ' num2str(angles(2))], 'FontSize', 12, 'Color', 'red');
    %legend(strcat('Femur angle=', num2str(angles(2))))
    legend(strcat('Femur angle=', num2str(angles(2)), ', Physical tibia angle=', num2str(angles(3)-angles(2))));
    
    % Set the axes limits for better visualization
    axis equal;
    xlim([-sum(lengths), sum(lengths)]);
    ylim([-sum(lengths), sum(lengths)]);
    
    % Adding labels and title
    xlabel('X');
    ylabel('Z');
    title('Z Variation from Side view while z is constant');
    
    hold off;
end





