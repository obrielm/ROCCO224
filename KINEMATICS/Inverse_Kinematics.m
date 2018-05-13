function Inverse_Kinematics(xh,yh)
%-------------Theta2---------------%
% x = L1*cos(c1) + L2*cos(c12);
% y = L1*sin(s1) + L2*sin(s12);
% x = xh;
% y = yh;

x = -6;
y = 14;

L1 = 7.2;
L2 = 7.2;
L3 = 7.0;

%The links
L(1) = Link([0 0 L1 0]);
L(2) = Link([0 0 L2 0]);
L(3) = Link([0 0 L3 0]);


RRR_finger = SerialLink(L, 'name', 'RRR_finger');

T_Matrix = [0 0 0 x; 0 1 0 y; 0 0 1 0; 0 0 0 1];
% T_Matrix = RRR_finger.fkine([90*(pi/180) 90*(pi/180) 90*(pi/180)])

%The inital angles of the finger joints
Q0 = [0 0 0];

%Inverese Kinematics. Returns the angles of the joints in radians.
Finger_angles_radians = RRR_finger.ikine(T_Matrix, 'Q0', Q0, 'mask' , [1 1 0 0 0 1])
Finger_angles_degres = Finger_angles_radians * (180/pi) +90


J4range = (Finger_angles_degres(1) - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J5range = (Finger_angles_degres(2) - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J6range = (Finger_angles_degres(3) - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;

Joint4 = rospublisher('/tilt_controller4/command', 'std_msgs/Float64');
Joint5 = rospublisher('/tilt_controller5/command', 'std_msgs/Float64');
Joint6 = rospublisher('/tilt_controller6/command', 'std_msgs/Float64');

Joint4Msg = rosmessage(Joint4);
Joint5Msg = rosmessage(Joint5);
Joint6Msg = rosmessage(Joint6);

Joint4Msg.Data = J4range;
Joint5Msg.Data = J5range;
Joint6Msg.Data = J6range;

send(Joint4,Joint4Msg);
send(Joint5,Joint5Msg);
send(Joint6,Joint6Msg);
end