close all;

xd=-5;
yd=5;

figure 
arrowPlot(out.state(:,1),out.state(:,3), 'number', 3, 'color', 'k', 'LineWidth', 1.2, 'scale',1.0);
xlabel('$x$(m)','Interpreter','latex');
ylabel('$y$(m)','Interpreter','latex');
hold on
grid on
figure
plot(out.tout,out.state(:,1)-xd,'k','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.state(:,3)-yd,'--b','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.state(:,5),'-.r','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('\textit{\textbf{q}}', 'Interpreter', 'Latex');%
legend('$x_e$(m)', '$y_e$(m)', '$\theta$(rad)', 'Interpreter', 'Latex','Location','best');
figure
plot(out.tout,out.controller(:,1),'k','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.controller(:,2),'--b','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('$\textit{\textbf{v}} (\textrm{N}\cdot\textrm{m})$', 'Interpreter', 'Latex');%
legend('$v_1$', '$v_2$', 'Interpreter', 'Latex','Location','best');




figure 
arrowPlot(out.state(:,5),out.state(:,6), 'number', 3, 'color', 'k', 'LineWidth', 1.2, 'scale',0.25);
xlabel('$\theta$(rad)','Interpreter','latex');
ylabel('$\dot{\theta}$(rad/s)','Interpreter','latex');
hold on
grid on

figure 
plot(out.tout,out.state(:,2),'k','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.state(:,4),'--b','LineWidth',1.2);
hold on
grid on
plot(out.tout,out.state(:,6),'-.r','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('$\dot{\textit{\textbf{q}}}$', 'Interpreter', 'Latex');%
legend('$\dot{x}_e$(m/s)', '$\dot{y}_e$(m/s)', '$\dot{\theta}$(rad/s)', 'Interpreter', 'Latex','Location','best');

figure 
plot(out.tout,out.controller(:,3),'k','LineWidth',1.2);
hold on
grid on
xlabel('time(s)');
ylabel('$\overline{E}_{p}(\textit{\textbf{q}})(\textrm{N}\cdot\textrm{m})$', 'Interpreter', 'Latex','FontName','Times New Roman');
hold on
grid on



figure 
subplot(3,1,1)
arrowPlot(out.state(:,1),out.state(:,3), 'number', 3, 'color', 'k', 'LineWidth', 1.5, 'scale',1.5);
xlabel('x(m)');
ylabel('$y$(m)','Interpreter','latex');
set(gca,'FontName','Times New Roman');
hold on
grid on
subplot(3,1,2)
plot(out.tout,out.state(:,1)-xd,'k','LineWidth',1.5);
hold on
grid on
plot(out.tout,out.state(:,3)-yd,'--b','LineWidth',1.5);
hold on
grid on
plot(out.tout,out.state(:,5),'-.r','LineWidth',1.5);
hold on
grid on
xlabel('time(s)');
ylabel('\textit{\textbf{q}}', 'Interpreter', 'Latex');%
legend('$x_e$(m)', '$y_e$(m)', '$\theta$(rad)', 'Interpreter', 'Latex','Location','best');
set(gca,'FontName','Times New Roman');
subplot(3,1,3)
plot(out.tout,out.controller(:,1),'k','LineWidth',1.5);
hold on
grid on
plot(out.tout,out.controller(:,2),'--b','LineWidth',1.5);
hold on
grid on
xlabel('time(s)');
ylabel('$\textit{\textbf{v}} (\textrm{N}\cdot\textrm{m})$', 'Interpreter', 'Latex');%
legend('$v_1$', '$v_2$', 'Interpreter', 'Latex','Location','best');
set(gca,'FontName','Times New Roman');



figure 
subplot(3,1,1)
arrowPlot(out.state(:,5),out.state(:,6), 'number', 3, 'color', 'k', 'LineWidth', 1.5, 'scale',0.5);
xlabel('\theta(rad)');
ylabel('$\dot{\theta}$(rad/s)','Interpreter','latex');
set(gca,'FontName','Times New Roman');
hold on
grid on
subplot(3,1,2)
plot(out.tout,out.state(:,2),'k','LineWidth',1.5);
hold on
grid on
plot(out.tout,out.state(:,4),'--b','LineWidth',1.5);
hold on
grid on
plot(out.tout,out.state(:,6),'-.r','LineWidth',1.5);
hold on
grid on
xlabel('time(s)');
ylabel('$\dot{\textit{\textbf{q}}}$', 'Interpreter', 'Latex');%
legend('$\dot{x}_e$(m/s)', '$\dot{y}_e$(m/s)', '$\dot{\theta}$(rad/s)', 'Interpreter', 'Latex','Location','best');
set(gca,'FontName','Times New Roman');
subplot(3,1,3)
plot(out.tout,out.controller(:,3),'k','LineWidth',1.5);
hold on
grid on
xlabel('time(s)');
ylabel('$\overline{E}_{p}(\textit{\textbf{q}})(\textrm{N}\cdot\textrm{m})$', 'Interpreter', 'Latex','FontName','Times New Roman');
hold on
set(gca,'FontName','Times New Roman');








