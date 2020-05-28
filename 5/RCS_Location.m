function[RCS_dBsm]=RCS_Location(RCS_values,Rect_Coord,Sphere_Coord,fc)

% Rect_Coord es fijo, son las posiciones en Cartesianas de las RCS del
% blanco

% Sphere_Coord es variable, nos dan las distintas posiciones del radar en
% coordenadas esféricas y habrá que pasarlas a Cartesianas para poder restar

% RCS_values son las secciones en dBsm del blanco (distintas
% RCS basadas en una esfera)

c=3*10^8;
lambda=c/fc;

k=(2*pi)/lambda; % Número de onda

RCS_values_lin=10.^(RCS_values/10); % Pasamos a lineal para trabajar aquí

% Recorremos la matriz de coord del radar para convertirlas en Cartesianas:

i=1;
Radar_Locations_Cart=[];
while(i<=length(Sphere_Coord(:,1)))
    
    R=Sphere_Coord(i,1);
    theta=Sphere_Coord(i,2);
    phi=Sphere_Coord(i,3);
    
    x=R*sind(theta)*cosd(phi); % Usamos cosd sind para que trabajen en deg
    y=R*sind(theta)*sind(phi);
    z=R*cosd(theta);
    
    Radar_Locations_Cart(i,1)=x;
    Radar_Locations_Cart(i,2)=y;
    Radar_Locations_Cart(i,3)=z;    
    
    i=i+1;
    
end

j=1;
Extended_Mat=[];
r_mat=[]; % Matriz de r

while(j<=length(Rect_Coord(:,1)))
    
    fila=Rect_Coord(j,:);
    
    Extended_Mat=repmat(fila,length(Radar_Locations_Cart),1); 
    % Replicamos cada posición de RCS tantas veces como la longitud de la matriz 
    % de coordenadas cartesianas del radar para poder restarlas
    
    Variaciones=Extended_Mat-Radar_Locations_Cart;
    
    n=1;
    r_vec=[]; % Cada una de las filas de la matriz de r
    
    while(n<=length(Variaciones(:,1)))
        
        xvar=Variaciones(n,1);
        yvar=Variaciones(n,2);
        zvar=Variaciones(n,3);
        
        r=sqrt(xvar^2+yvar^2+zvar^2);
        
        r_vec(n)=r;
        
        n=n+1;
        
    end
    
    r_mat(j,:)=r_vec;
    
    j=j+1;
    
end

phase_mat=2*k*r_mat; % Matriz de fases que deberemos usar para calcular
% las secciones correspondientes a cada input


% Ahora queda realizar el sumatorio de la expresión, con el valor de sección
% recta y las fases que aplicamos con la matriz obtenida en el punto
% anterior

n=1;
j=1i;
SigmasRes=[]; % Vector resultante output de la función

while(n<=length(phase_mat(1,:))) % Recorremos la matriz de fases, de 2 filas (2 pos RCS) por 361 columnas (361 posiciones de matriz de fases)
    
    l=1; % Contador para recorrer el vector input de valores de RCSs
    phase=0; % Valor acumulativo para cada sumatorio
    
    while(l<=length(RCS_values_lin))
        
       phase=phase+sqrt(RCS_values_lin(l))*exp(j*phase_mat(l,n)); % Sumatorio (ejemplo: para 2 pos RCS, las dos pos RCS con todas las fases conformarán el vector resultante)
       l=l+1;
        
    end
    
    SigmasRes(n)=(abs(phase))^2;
    n=n+1;
       
end

RCS_dBsm=10*log10(SigmasRes);

end