#include <stdio.h>
#include <math.h>
#define M_PI       3.14159265358979323846   // pi
// Define the structure to return the angle values
typedef struct {
    double coxa_angle;
    double femur_angle;
    double tibia_angle;
} AngleValues;

AngleValues calculate_leg_angles(double x, double y, double z) {
    // Constants
    const float coxa_length = 4.3;
    const float femur_length = 6.0;
    const float tibia_length = 10.4;
    const float max_leg_length = coxa_length + femur_length + tibia_length;
    // chech the z point.
    int elbowup=0;
    if(z<0){
        elbowup=1;
        z=abs(z);
    }

    // Calculate leg length
    float leg_length = sqrt(x*x + y*y);
    float HF = sqrt(pow(leg_length - coxa_length, 2) + z*z);

    if (HF>femur_length+tibia_length) {
        printf("Point is out of range\n");
        return (AngleValues){0, 0, 0}; // Return zeros if point is out of range
    }

   
    float A1 = atan2(leg_length - coxa_length,z );
    A1 = A1 * (180.0 / M_PI); // Convert to degrees

    float A2 = acos((tibia_length*tibia_length - femur_length*femur_length - HF*HF) / (-2 * femur_length * HF));
    A2 = A2 * (180.0 / M_PI); // Convert to degrees

    // Coxa angle
    float coxa_angle = atan2(y, x);
    coxa_angle = coxa_angle * (180.0 / M_PI); // Convert to degrees

    // Femur angle
    float femur_angle = -90 + (A1 + A2);

    // Tibia angle
    float B1 = acos((HF*HF - tibia_length*tibia_length - femur_length*femur_length) / (-2 * femur_length * tibia_length));
    B1 = B1 * (180.0 / M_PI); // Convert to degrees
    float tibia_angle = -180 + femur_angle + B1;

    // re-check the z point and recalculate the angles.

    if(elbowup){
        float ang2=2*A2-femur_angle;
        float ang3 = 2*A2-2*tibia_angle+tibia_angle-ang2;
        return (AngleValues){coxa_angle, -ang2, -ang3};
    }


    printf("Coxa angle: %d, Femur angle: %d, Tibia angle: %d\n", (int)round(coxa_angle), (int)round(femur_angle), (int)round(tibia_angle-femur_angle));
    printf("Hf = %f, A1 = %f, A2 = %f, B1=%f, rad2deg=%f \n", HF, A1, A2,B1,M_PI);
    return (AngleValues){coxa_angle, -femur_angle, tibia_angle-femur_angle};
}

int main() {
    // Test the function with sample input values
    double x = 10.0, y = 17.0, z = 5.0;
    AngleValues angles = calculate_leg_angles(x, y, z);

    printf("Angles: coxa_angle = %d, femur_angle = %f, tibia_angle = %f\n", (int)round(angles.coxa_angle), round(angles.femur_angle), round(angles.tibia_angle));

    return 0;
}
