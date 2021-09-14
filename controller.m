function [sys,x0,str,ts] = controller(t,x,u,flag)


switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case {2,4,9}
    sys=[];

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes


sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 7;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;   % at least one sample time is needed

sys = simsizes(sizes);


%
% initialize the initial conditions
%
x0  =[];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [];


% end mdlInitializeSizes



%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)

m=1;
J=1;

m11ba=1.2;
lamda=3; %Gama11=Gama22
lamda3=-2; %Gama33
e=1;
w3=(-1)*e*lamda3;
a=-lamda/w3;
g=9.8;
p1=0.9;
p2=0.9;
d1=3.8;
d2=3.8;

xd=-5; yd=5; %desired position

xx=u(1);   %state x
d_xx=u(2);
y=u(3);    %state y
d_y=u(4);
theta=u(5); %state \theta
d_theta=u(6);
xe=xx-xd;
ye=y-yd;

k1=(lamda*m11ba-m)/(e*lamda3);
k2=-(e*lamda3*m)/(e*e*J*lamda3*m11ba+m*lamda*m11ba-m*m);
 
v1=m*g*cos(theta)-k1*d_theta*d_theta*m/m11ba+d1*sin(theta)*d_xx*m/m11ba-d2*cos(theta)*d_y*m/m11ba+(d1-d2)*a*sin(theta)*cos(theta)*d_theta*m/m11ba+p1*sin(theta)*(xe+a*sin(theta))*m/m11ba-p2*(ye+a*(1-cos(theta)))*cos(theta)*m/m11ba;
% 
v2=J*k2*(d1*cos(theta)*d_xx+d2*sin(theta)*d_y+a*(d1*cos(theta)*cos(theta)+d2*sin(theta)*sin(theta))*d_theta+p1*cos(theta)*(xe+a*sin(theta))+p2*(ye+a*(1-cos(theta)))*sin(theta)-m11ba*g*sin(theta));

sys(1)=v1;
sys(2)=v2;
sys(3)=u(7);


% end mdlOutputs

