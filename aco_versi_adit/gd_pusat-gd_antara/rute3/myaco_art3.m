%**************************************************************************
%          VRP Problem Using ACO rute 3 Gd Pusat -> Gd Antara
% -------------------------------------------------------------------------
% By     : Gita Anggita Lestari
% Contact: gitaanggitalstr@gmail.com             Last update: sept 13, 2019
% -------------------------------------------------------------------------                             
% This program is developed to find shortest path (minimum cost)between
% some cities. 
% 
% There are 4  parts in this program:
% 1.Main program of ACO (myaco.m)
% 2.Function to generate solution (ant_tour.m)
% 3.Function to calculate the cost (distance) (calculate_cost.m)
% 4.Function to update the traces (update_the_trace.m)
%**************************************************************************
 
%**************************************************************************
%                   The Program Start Here                    
%*------------------------------------------------------------------------
% function myaco(num_of_nodes,num_of_ants, max_iteration)
function myaco()
% inputs
miter=1000; % banyak iterasi
m=2; % banyak semut
n=3; %jumlah kotas
% parameters
e=0.6;            % evaporation coefficient.
alpha=1;          % effect of ants' sight.
beta=12;           % trace's effect.
t=0.02*ones(n); % primary tracing.
el=.97;           % common cost elimination. 
% -------------------------------------------------------------------------
% matrix coordinates of cities of rute 3s
map_index=[0	29	33];
map_x=[12.93	6.45	7.18];
map_y=[3.27	3.73	4.79];
node=[map_index;map_x;map_y];
% Generate coordinates of cities and plot
for i=1:n
    x(i)= map_x(i);
    y(i)= map_y(i);
end    

subplot(3,1,1);
plot(x,y,'o','MarkerFaceColor','k','MarkerEdgeColor','b','MarkerSize',10);
title('Titik Koordinat Kota (PT. XYZ)');
xlabel('x  (km)');
ylabel('y  (km)');

% generating distace between cities matrix.
%for i=1:n
%    for j=1:n
%        d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
%    end
%end
d=[0 6.9 7.1;
   6.9 0 2.8;
   7.1 2.8 0];

% generating sight matrix.
for i=1:n
    for j=1:n
        if d(i,j)==0
            h(i,j)=0;
        else
            h(i,j)=1/d(i,j);
        end
    end
end
h=h
% ------------------------------------------------------------------------
%             Main Algorithm: ACO Meta heuristic procedure
% a.  Probabilistic solution construction biased by
%     pheromone trails, without forward pheromone
%     updating
% b.  Deterministic backward path with loop elimination
%     and with pheromone updating--> update_the_trace
% c.  Evaluation of the quality of the solutions
%     generated and use of the solution quality in
%     determining the quantity of pheromone to deposit-->calculate_cost
% -------------------------------------------------------------------------
for i=1:miter
% Step 1: Forward ants and solution construction

% Generate places for each ant    
for j=1:m
    start_places(j,1)=fix(1+rand*(n-1));
end
% Step 2:probabilistic solution contruction   
    [tour]=ant_tour(start_places,m,n,h,t,alpha,beta);
    tour=horzcat(tour,tour(:,1));
    
% Step 3: Calculate the cost --> total distace
    [cost,f]=calculate_cost(m,n,d,tour,el);
    [t]=update_the_trace(m,n,t,tour,f,e);
    average_cost(i)=mean(cost);
    
% Step 4: Determine the best route
    [min_cost(i),best_index]=min(cost);
    besttour(i,:)=tour(best_index,:);
    iteration(i)=i;
end
% -------------------------------------------------------------------------

% Plot Average of tour distance vs Number of Iterations
subplot(3,1,2);plot(iteration,average_cost);
title('Rata-Rata Jarak vs Jumlah Iterasi');
xlabel('iteration');
ylabel('Jarak(Km)');

% Plot the best route
[k,l]=min(min_cost); % jarak
for i=1:n+1
    X(i)=x(besttour(l,i));
    Y(i)=y(besttour(l,i));
end
subplot(3,1,3);plot(X,Y,'--o',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',10)
xlabel('x (km)');ylabel('y (km)');
title(['Total Jarak(Km)= ',num2str(k)]);
% fprintf('\nTotal Jarak = %d\n',k);

% Get Route Path 
batas = length(map_index);
path = [];
for i=1:batas
    itter = 0;
    index_x = X(i);
    index_y = Y(i);
    for j=1:batas
        if index_x == node(2,[j]) && index_y == node(3,[j])
            itter = itter + 1;
            path(i)=node(1,[j]);
        end
    end
end
titik_awal = num2str(path(1));jalan = num2str(path);
fprintf('Total Jarak = ')
disp(min(min_cost));
fprintf('Rute =  ');
fprintf(titik_awal);fprintf('  ');
fprintf(jalan);fprintf('  ');
fprintf(titik_awal)
fprintf('\n')

end
%**************************************************************************
%                   Ending of Program                          
%**************************************************************************

