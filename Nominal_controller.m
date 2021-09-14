function [sys,x0,str,ts] =Nominal_controller(t,x,u,flag)


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
sizes.NumInputs      = 3;
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

noomage_1=u(1);
noomage_2=u(2);
noomage_3=u(3);


B=[   1,  0;
      0,  1;
      0,  0 ];

J_biao=[   42,             1.8,        0;
           1.8,              25,      0;
            0,             0,       61.8  ];

J11_biao=42;     
J21_biao=1.8;     
J22_biao=25;     
% J31_biao=0;     
% J32_biao=0;     
J33_biao=61.8;     


lamda_1=1;
lamda_2=1;
d1=0.05;
d2=0.05;
% d1=0.1;
% d2=0.1;

w2_bar=1;
w3_bar=5;
c_1=(J11_biao-J22_biao+sqrt(4*J21_biao*J21_biao+(J11_biao-J22_biao)*(J11_biao-J22_biao)))/(2*J21_biao);


 noS=[      0,         -noomage_3,     noomage_2;
        noomage_3,         0,        -noomage_1;
       -noomage_2,    noomage_1,       0        ];
  Jni_bar=[      lamda_1,               0,                 c_1*w2_bar/J33_biao;
                    0,               lamda_2,               w2_bar/J33_biao;
       c_1*w2_bar/J33_biao,       w2_bar/J33_biao,          w3_bar/J33_biao  ];


 %Õ”¬›¡¶æÿ’Û 
 noGba=(1/w3_bar)*[     0,              0,   -J21_biao*noomage_1+(J11_biao-J22_biao)*noomage_2-c_1*w2_bar*J21_biao*noomage_3/ w3_bar;
                      0,              0,    J21_biao*noomage_2+ (c_1*w2_bar*(J11_biao-J22_biao)+w2_bar*J21_biao)*noomage_3/ w3_bar  ;
      J21_biao*noomage_1-(J11_biao-J22_biao)*noomage_2+c_1*w2_bar*J21_biao*noomage_3/ w3_bar,-J21_biao*noomage_2-(c_1*w2_bar*(J11_biao-J22_biao)+w2_bar*J21_biao)*noomage_3/ w3_bar,0];
   
  
 %∫ƒ…¢¡¶æÿ’Û
   
 noDba=[   w3_bar*w3_bar*d1,             0,        -c_1*w2_bar*w3_bar*d1;
           0,              w3_bar*w3_bar*d2,                   -w2_bar*w3_bar*d2;
          -c_1*w2_bar*w3_bar*d1     ,-w2_bar*w3_bar*d2, c_1*c_1*w2_bar*w2_bar*d1+w2_bar*w2_bar*d2 ];

  noomage=[ noomage_1;noomage_2;noomage_3];
  notao=B'*noS*J_biao*noomage-B'*J_biao*Jni_bar*(noGba*noomage+noDba*noomage);
  
  sys(1)= notao(1);
  sys(2)= notao(2);
%   sys(1)=[1,0,0]*(S*J_biao*omage-J_biao*Jni_bar*(Gba*omage+Dba*omage));
%   sys(2)=[0,1,0]*(S*J_biao*omage-J_biao*Jni_bar*(Gba*omage+Dba*omage));
  
  


%   sys=tao;

 
% 
%   



% end mdlOutputs

