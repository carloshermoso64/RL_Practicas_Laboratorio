clear all
close all
clc

%% 5.3/5.4 Computation of RCS of complex shapes for two different spheres:

fc=1.5*10^9;
sigma1=0; % En dBsm que deberemos pasar a lineal dentro de la función
% sigma1 = sigma2 = 0dBsm = 1m^2

RCS_values=[sigma1 sigma1];

L=1;
L2=0.1;
L3=0.01;

RCS_Locations=[L/2 0 0
             -L/2 0 0];

RCS_Locations2=[L2/2 0 0
              -L2/2 0 0];
          
RCS_Locations3=[L3/2 0 0
              -L3/2 0 0];
  
R=10^6;
theta=90; % deg fijos
phi=0; % deg variables entre 0 y 360

% Creamos la matriz de coordenadas esféricas:

Sphere_Coord=[];
cont=1;

while(phi<=360)
    
    Sphere_Coord(cont,1)=R;
    Sphere_Coord(cont,2)=theta;
    Sphere_Coord(cont,3)=phi;
    
    cont=cont+1; % Contador extra porque la matriz no admite posiciones no enteras
    phi=phi+0.1; % Si el incremento de phi es más pequeño incrementamos la resolución en el plot polar
    
end


Monostatic_RCSs=RCS_Location(RCS_values,RCS_Locations,Sphere_Coord,fc);
Monostatic_RCSs2=RCS_Location(RCS_values,RCS_Locations2,Sphere_Coord,fc);
Monostatic_RCSs3=RCS_Location(RCS_values,RCS_Locations3,Sphere_Coord,fc);


figure();
subplot(1,2,1)
polar(Sphere_Coord(:,3)*pi/180,(10.^(Monostatic_RCSs/10)')); % Debemos pasar los grados a radianes para la función polar
title('Polar for L=1m')
subplot(1,2,2)
plot(Sphere_Coord(:,3)*pi/180,Monostatic_RCSs'); % Aquí es sin pasar el vector output de la función a lineal
title('Cartesian plot for L=1m')


figure();
subplot(1,2,1)
polar(Sphere_Coord(:,3)*pi/180,(10.^(Monostatic_RCSs2/10)'));
title('Polar for L=0.1m')
subplot(1,2,2)
plot(Sphere_Coord(:,3)*pi/180,Monostatic_RCSs2');
title('Cartesian plot for L=0.1m')

figure();
subplot(1,2,1)
polar(Sphere_Coord(:,3)*pi/180,(10.^(Monostatic_RCSs3/10)'));
title('Polar for L=0.01m')
subplot(1,2,2)
plot(Sphere_Coord(:,3)*pi/180,Monostatic_RCSs3');
title('Cartesian plot for L=0.01m')


figure();
plot(Sphere_Coord(:,3)*pi/180,Monostatic_RCSs');
hold on
plot(Sphere_Coord(:,3)*pi/180,Monostatic_RCSs2');
plot(Sphere_Coord(:,3)*pi/180,Monostatic_RCSs3');
legend('L=1m','L=0.1m','L=0.01m')
legend('boxoff')
hold off

% close all
%% 5.5 Swerling model statistics I and II:

fc2=3*10^9;
n=10; % Número de targets (puntos de scatter), en este caso tenemos 10

R2=1000; % Distancia radar - puntos de scatter

% Rand trabaja de 0 a 1, deberemos escalar para los valores deseados:

RCS_values_rand=(0.01*rand(n,1))'; % Valores cercanos a 0dBsm, transponemos para pasarle un vector a la función

Rs=10*rand(n,1);
thetas(1:10,1)=90; % Creamos un vector de 10 posiciones de 90 grados siempre
phis=360*rand(n,1);

% Ahora debemos crear la matriz de posiciones de los scatters con los
% valores aleatorios obtenidos, antes nos la daban (lo que pasaremos a la
% función):

RCS_x=Rs.*sind(thetas).*cosd(phis);
RCS_y=Rs.*sind(thetas).*sind(phis);
RCS_z=Rs.*cosd(thetas);

RCS_Locations4=[RCS_x,RCS_y,RCS_z]; % Lo que pasaremos a la función

% Ahora formamos la matriz de posiciones del radar en coordenadas
% esféricas:

SphereCoord2_R(1:3601)=R2; % La distancia que nos da el enunciado
SphereCoord2_Theta(1:3601)=90;
SphereCoord2_Phi=linspace(0,360,3601); % Genera 3601 puntos entre 0 y 360, espaciados de igual forma entre ellos


% Montamos la matriz:

Sphere_Coord2=[SphereCoord2_R',SphereCoord2_Theta',SphereCoord2_Phi']; % Cada variable en una columna como antes

Monostatic_RCSs4=RCS_Location(RCS_values_rand,RCS_Locations4,Sphere_Coord2,fc2);

figure();
polar(Sphere_Coord2(:,3)*pi/180,(10.^(Monostatic_RCSs4/10)'));

figure();
hist(10.^(Monostatic_RCSs4/10),250); % Se parece a chi cuadrada con dos grados de libertad
title('Densidad de probabilidad casos Swerling I/II')

%% 5.6 Swerling model statistics III and IV:

RCS_grande=max(RCS_values_rand)+17; % Le sumamos 17dB al punto de scatter más brillante de los creados para hacerlo destacar sobre los demás
[~,pos]=min(RCS_values_rand); % Obtenemos la posición del valor más pequeño de los creados random
RCS_values_rand(pos)=RCS_grande; % Insertamos el valor grande+17dB en la posición del más pequeño (por ejemplo)

% Ahora volvemos a realizar el proceso anterior pero con el vector random
% modificado para tener un punto a +17dB de los demás:

Monostatic_RCSs5=RCS_Location(RCS_values_rand,RCS_Locations4,Sphere_Coord2,fc2);

figure();
polar(Sphere_Coord2(:,3)*pi/180,(10.^(Monostatic_RCSs5/10)'));

figure();
hist(10.^(Monostatic_RCSs5/10),250); % Se parece a chi cuadrada con cuatro grados de libertad
title('Densidad de probabilidad casos Swerling III/IV')

% Podemos observar que cuando hay un valor predominante en un área en
% concreto, la probabilidad se centra en ese área, pero si no se dispersan
% uniformemente los valores

% SWI,II: Valores más cercanos a 10m^2
% SWIII,IV: Valores más cercanos a 50m^2
