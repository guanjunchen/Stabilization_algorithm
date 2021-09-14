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
sizes.NumOutputs     = 2;
sizes.NumInputs      = 5;
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

m1=0.6;
m2=0.6;
l1=0.3;
l2=0.3;
h1=(m1/3+m2)*l1*l1;
h2=(m2/3)*l2*l2;
h3=(m2/2)*l1*l2;
h4=m2*l1+(m1/2)*l1;
h5=(m2/2)*l2;
g=9.8;
theta1=u(1);
d_theta1=u(2);
theta2=u(3);
d_theta2=u(4);
d1=6;
p1=16;
a=2.5;
w2ba=-1;
temp1=((h3*cos(theta2)*h3*cos(theta2)+2*h2*h3*cos(theta2)+2*h2*h2-h1*h2)/(h2*h2)-a*(h1-h2)/(h3*cos(theta2)-h2))*h3*sin(theta2)*d_theta1*d_theta1/(a-2);
temp2=-(h3*sin(theta2)+a*h3*sin(theta2)*(h3*cos(theta2)*h3*cos(theta2)-h1*h2)/(2*(a-2)*(h3*cos(theta2)-h2)*(h3*cos(theta2)-h2)))*(2*d_theta1*d_theta2+d_theta2*d_theta2);
temp3=w2ba*(h3*cos(theta2)*h3*cos(theta2)-h1*h2)*(d1*(d_theta1+0.5*d_theta2)+p1*(theta1+0.5*theta2))/(2*(a-2)*h2*h2);
temp4=-((h3*cos(theta2)*h3*cos(theta2)+2*h2*h3*cos(theta2)+2*h2*h2-h1*h2)/(h2*h2)-a*(h1-h2)/(2*(h3*cos(theta2)-h2)))*2*g*h5*sin(theta1+theta2)*(1/(a-2));
temp5=-g*(h4*sin(theta1)+h5*sin(theta1+theta2));


% tao=((h3*cos(theta2)*h3*cos(theta2)+2*h2*h3*cos(theta2)+2*h2*h2-h1*h2)/(h2*h2)-a*(h1-h2)/(h3*cos(theta2)-h2))*h3*sin(theta2)*d_theta1*d_theta1/(a-2)-(h3*sin(theta2)+a*h3*sin(theta2)*(h3*cos(theta2)*h3*cos(theta2)-h1*h2)/(2*(a-2)*(h3*cos(theta2)-h2)*(h3*cos(theta2)-h2))*(2*d_theta1*d_theta2+d_theta2*d_theta2)
% +w2ba*(h3*cos(theta2)*h3*cos(theta2)-h1*h2)*(d1*(d_theta1+0.5*d_theta2)+p1*(theta1+0.5*theta2))/(2*(a-2)*h2*h2)
% -((h3*cos(theta2)*h3*cos(theta2)+2*h2*h3*cos(theta2)+2*h2*h2-h1*h2)/(h2*h2)-a*(h1-h2)/(2*(h3*cos(theta2)-h2)))*2*g*h5*sin(theta1+theta2)*(1/(a-2))
% -g*(h4*sin(theta1)+h5*sin(theta1+theta2));
  
sys(1)=temp1+temp2+temp3+temp4+temp5;
sys(2)=u(5);


% end mdlOutputs

