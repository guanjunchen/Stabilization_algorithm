function [sys,x0,str,ts] = Pendubot_plant(t,x,u,flag,iniState)


switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(iniState);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  case {2,4,9}
    sys=[];


  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end



%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(iniState)

sizes = simsizes;

sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;   % at least one sample time is needed

sys = simsizes(sizes);


%
% initialize the initial conditions
%
x0=iniState;

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [];

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

%%    model parameter    %%
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
theta1=x(1);
d_theta1=x(2);
theta2=x(3);
d_theta2=x(4);
M=[h1+h2+2*h3*cos(theta2),h2+h3*cos(theta2);
   h2+h3*cos(theta2),h2 ];

%plot(t,Epba,'--b','LineWidth',1.2);
dd_theta=inv(M)*[u(1)+h3*sin(theta2)*(2*d_theta1*d_theta2+d_theta2*d_theta2)+g*(h4*sin(theta1)+h5*sin(theta1+theta2));
    -h3*sin(theta2)*d_theta1*d_theta1+g*h5*sin(theta1+theta2)];
sys(1)=x(2);
sys(2)=[1,0]*dd_theta;
sys(3)=x(4);
sys(4)=[0,1]*dd_theta;
% end mdlDerivatives

function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);
p1=16;g=9.8;
m2=0.6;l2=0.3;
h5=(m2/2)*l2;
theta1=x(1);
theta2=x(3);
Epba=2*g*h5*(1-cos(theta1+theta2))+0.5*p1*(theta1+0.5*theta2)^2;
sys(5)=Epba;

% end mdlOutputs