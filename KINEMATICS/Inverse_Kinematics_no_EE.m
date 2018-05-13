%The position vectors and the orientation of the end effector.
x = 0.0;
y = 14.0
phi = 45;

%The link lengths
L1 = 7.2;
L2 = 7.2;

%Equation to find cosine of L2
c2 = ((x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2));

%Equation for sine of L2
s2 = sqrt(1 - c2^2);

%Theta2
J2theta = atan2d(s2,c2);

%Theta1
k1 = L1 + (L2*c2);
k2 = L2*s2;

J1theta = atan2d(y,x) - atan2d(k2,k1) ;

%-------------Theta3---------------%
% J3theta = phi - (J1theta + J2theta);
J3theta = 0;

J1range = (J1theta +90.0)*(4.2-1.0)/(90.0+90.0) + 1.0;
J2range = (J2theta +90.0)*(4.2-1.0)/(90.0+90.0) + 1.0;
J3range = (J3theta +90.0)*(4.2-1.0)/(90.0+90.0) + 1.0;



Joint1 = rospublisher('/tilt_controller1/command', 'std_msgs/Float64');
Joint2 = rospublisher('/tilt_controller2/command', 'std_msgs/Float64');
Joint3 = rospublisher('/tilt_controller3/command', 'std_msgs/Float64');
Joint4 = rospublisher('/tilt_controller4/command', 'std_msgs/Float64');
%create a message type for the publisher 
Joint1Msg = rosmessage(Joint1);
Joint2Msg = rosmessage(Joint2);
Joint3Msg = rosmessage(Joint3);
Joint4Msg = rosmessage(Joint4);
%last servo message
Joint4Msg.Data = J3range;
%first servo message
Joint1Msg.Data = 2.0;
%Second servo message
Joint2Msg.Data = J1range;
%third servo message
Joint3Msg.Data = J2range;
%send the message to the topic
send(Joint1,Joint1Msg);
send(Joint2,Joint2Msg);
send(Joint3,Joint3Msg);
send(Joint4,Joint4Msg);
