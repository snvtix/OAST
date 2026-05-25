set Links;                      
set Demands;                    

param demand_maxPath {Demands};

set Demand_pathLinks {d in Demands, p in 1..demand_maxPath[d]} within Links;


param maxNode;

param moduleCapacity;
param link_nodeA {Links};
param link_nodeZ {Links};
param link_moduleCost {Links};     # koszt modułu na łączu e

param demand_nodeA {Demands};
param demand_nodeZ {Demands};
param demand_volume {Demands};     # h(d)

param xi {e in Links} := link_moduleCost[e];

param M default 1;

param z default 0;


var u {d in Demands, p in 1..demand_maxPath[d]} binary;

var y {Links} integer >= 0;


minimize TotalCost:
    sum {e in Links} xi[e] * y[e];


s.t. OnePath {d in Demands}:
    sum {p in 1..demand_maxPath[d]} u[d,p] = 1;

s.t. LinkCapacity {e in Links}:
    sum{
        d in Demands,
        p in 1..demand_maxPath[d] :
            e in Demand_pathLinks[d,p]
    } demand_volume[d] * u[d,p]
    <= M * y[e] * (moduleCapacity + z);
