L1 = 7.2;
L2 = 7.2;
L3 = 7.0;

%The links
L(1) = Link([0 0 L1 0]);
L(2) = Link([0 0 L2 0]);
L(3) = Link([0 0 L3 0]);
L

RRR_finger = SerialLink(L, 'name', 'two link');

%Forward kinematics matrix with the angle in degrees converted to radians
T_Matrix = RRR_finger.fkine([30*(pi/180) 60*(pi/180) 90*(pi/180)])
%RRR_finger.plot([30*(pi/180) 60*(pi/180) 90*(pi/180)]);  
%The initial angle values 
Q0 = [0 0 0];

 %Inverese Kinematics. Returns the angles of the joints in radians.
 Finger_angles_radians = RRR_finger.ikine(T_Matrix, 'Q0', Q0, 'mask' , [1 1 0 0 0 1]);
 Finger_angles_degres = Finger_angles_radians * (180/pi)
 