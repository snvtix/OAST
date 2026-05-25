set Links;
set Demands;

param demand_maxPath{Demands};

set DemandPath_links {d in Demands, p in 1..demand_maxPath[d]};


param maxNode;
param moduleCapacity;              
param link_nodeA{Links};
param link_nodeZ{Links};
param link_moduleCount{Links};     # liczba modułów już dostępnych

param demand_nodeA{Demands};
param demand_nodeZ{Demands};
param demand_volume{Demands};      # h(d)

param xi{Links} default 1;

param M default 1000000;


var u {d in Demands, p in 1..demand_maxPath[d]} binary;

var y {Links} integer >= 0;



minimize TotalCost:
    sum{e in Links} xi[e] * y[e];


s.t. OnePath {d in Demands}:
    sum{p in 1..demand_maxPath[d]} u[d,p] = 1;

s.t. LinkCapacity {e in Links}:
    sum{
        d in Demands,
        p in 1..demand_maxPath[d] :
            e in DemandPath_links[d,p]
    } demand_volume[d] * u[d,p]
    <= (link_moduleCount[e] + y[e]) * moduleCapacity;
