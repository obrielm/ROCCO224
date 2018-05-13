function ForwardK (joint1, joint2, joint3)
%Link lengths
L1 = 7.2;
L2 = 7.2;
L3 = 7.0;
%Input angle to the sine/cos functions corresponding to orientation of each
%joint
j1 = joint1;
j2 = joint2;
j3 = joint3;
j4 = -j1;
j5 = -j2;
j6 = -j3;

%output values of the sine/cos funtions of each joint
s1 = sind(j1);
c1 = cosd(j1);
s2 = sind(j2);
c2 = cosd(j2);
s3 = sind(j3);
c3 = cosd(j3);

% x = L1*c1 + L2*cosd(cj1+cj2);
% y = L1*s1 + L2*sind(sj1+sj2);
% c123 = cos(cj1+cj2+cj3);
% s123 = sin(sj1+sj2+sj3);

%1 in terms of 0
T01 = [c1 -s1 0 0; s1 c1 0 0; 0 0 1 0; 0 0 0 1];

%2 in terms of 1
T12 = [c2 -s2 0 L1; s2 c2 0 0; 0 0 1 0; 0 0 0 1];

%3 in terms of 2
T23 = [c3 -s3 0 L2; s3 c3 0 0; 0 0 1 0; 0 0 0 1];

T34 = [1 0 0 L3; 0 1 0 0; 0 0 1 0; 0 0 0 1];

% T03 = [c123 -s123 0 x; s123 c123 0 y; 0 0 1 0; 0 0 0 1];

%3 in terms of 0
T04 = T01*T12*T23*T34;


T04

J1range = (j1 - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J2range = (j2 - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J3range = (j3 - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J4range = (j4 - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J5range = (j5 - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
J6range = (j6 - -90.0)*(4.2-1.0)/(90.0--90.0) + 1.0;
% 
Joint1 = rospublisher('/tilt_controller1/command', 'std_msgs/Float64');
Joint2 = rospublisher('/tilt_controller2/command', 'std_msgs/Float64');
Joint3 = rospublisher('/tilt_controller3/command', 'std_msgs/Float64');
Joint4 = rospublisher('/tilt_controller4/command', 'std_msgs/Float64');
Joint5 = rospublisher('/tilt_controller5/command', 'std_msgs/Float64');
Joint6 = rospublisher('/tilt_controller6/command', 'std_msgs/Float64');
%create a message type for the publisher 
Joint1Msg = rosmessage(Joint1);
Joint2Msg = rosmessage(Joint2);
Joint3Msg = rosmessage(Joint3);
Joint4Msg = rosmessage(Joint4);
Joint5Msg = rosmessage(Joint5);
Joint6Msg = rosmessage(Joint6);

%first servo message
Joint1Msg.Data = J1range;
%Second servo message
Joint2Msg.Data = J2range;
%third servo message
Joint3Msg.Data = J3range;
%fourth servo message
Joint4Msg.Data = J4range;
%fifth servo message
Joint5Msg.Data = J5range;
%sixth servo message
Joint6Msg.Data = J6range;


%send the message to the topic
send(Joint1,Joint1Msg);
send(Joint2,Joint2Msg);
send(Joint3,Joint3Msg);
send(Joint4,Joint4Msg);
send(Joint5,Joint5Msg);
send(Joint6,Joint6Msg);
end