close all;

figure 
plot(out.tout,out.state(:,1),'k','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.state(:,3),'--b','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('\textit{\textbf{q}}(rad)', 'Interpreter', 'Latex');%
legend('\theta_1', '\theta_2','Location','best');
%set(gca,'FontName','Times New Roman');
hold on

figure 
plot(out.tout,out.state(:,2),'k','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.state(:,4),'--b','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('$\dot{\textit{\textbf{q}}}$(rad/s)', 'Interpreter', 'Latex');%
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', 'Interpreter', 'Latex','Location','best');
%set(gca,'FontName','Times New Roman');
hold on


figure
plot(out.tout,out.controller(:,1),'k','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('$u_1$(N$\cdot$m)', 'Interpreter', 'Latex');
hold on
%set(gca,'FontName','Times New Roman');


figure
plot(out.tout,out.controller(:,2),'k','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('$\overline{E}_{p}(\textit{\textbf{q}})$(N$\cdot$m)', 'Interpreter', 'Latex');
%ylabel('$\overline{E}_{p}(\textit{\textbf{q}})(\textrm{N}\cdot\textrm{m})$', 'Interpreter', 'Latex','FontName','Times New Roman');
hold on
%set(gca,'FontName','Times New Roman');


