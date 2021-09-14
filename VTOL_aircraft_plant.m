function [sys,x0,str,ts] = VTOL_aircraft_plant(t,x,u,flag,iniState)


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

sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 7;
sizes.NumInputs      = 3;
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


e=1;
g=9.8;
m=1;
J=1;

M=[m,0,0;
   0,m,0;
   0,0,J];

Mni=[1/m,0,0;
     0,1/m,0;
      0,0,1/J];


%%   Controller Pararameters    %%
%¿ØÖÆÆ÷²ÎÊý


% p1=0.9;
% p2=0.9;
% d1=3.8;
% d2=3.8;
% 
% xd=-5; yd=5; %desired position
% xx=x(1);   %state x
% d_xx=x(2);
% y=x(3);    %state y
% d_y=x(4);
 theta=x(5); %state \theta
% d_theta=x(6);
% xe=xx-xd;
% ye=y-yd;

v1=u(1);
v2=u(2);

dd_q=Mni*([-sin(theta),e*cos(theta);cos(theta),e*sin(theta);0,1]*[ v1;v2]+[0;-m*g;0]);


sys(1)=x(2);
sys(2)=[1,0,0]*dd_q;
sys(3)=x(4);
sys(4)=[0,1,0]*dd_q;
sys(5)=x(6);
sys(6)=[0,0,1]*dd_q;
% end mdlDerivatives

function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);
sys(5)=x(5);
sys(6)=x(6);


lamda=3; %Gama11=Gama22
lamda3=-2; %Gama33
e=1;
w3=(-1)*e*lamda3;
a=-lamda/w3;
g=9.8;
p1=0.9;
p2=0.9;
xd=-5; yd=5; %desired position
xx=x(1);   %state x
%d_xx=x(2);
y=x(3);    %state y
%d_y=x(4);
theta=x(5); %state \theta
%d_theta=x(6);
xe=xx-xd;
ye=y-yd;
Epba=g*(1-cos(theta))/w3+0.5*p1*(xe+a*sin(theta))*(xe+a*sin(theta))+0.5*p2*(ye+a*(1-cos(theta)))*(ye+a*(1-cos(theta)));
sys(7)=Epba;

% end mdlOutputs