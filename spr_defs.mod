# =========================
# Single-path routing: defs
# =========================

param moduleCapacity >= 0;

param maxNode >= 0, integer;
set Nodes := 1..maxNode;

set Links;
param link_nodeA{Links} in Nodes;
param link_nodeZ{Links} in Nodes;

# DAP:
param link_moduleCount{Links} >= 0 default 0;

# DDAP:
param link_moduleCost{Links} >= 0 default 0;

# Demands:
set Demands;
param demand_nodeA{Demands} in Nodes;
param demand_nodeZ{Demands} in Nodes;
param demand_maxPath{Demands} >= 0, integer default 0;
param demand_volume{Demands} >= 0 default 0;

# - DAP:  DemandPath_links[d, p]
# - DDAP: Demand_pathLinks[d, p]
set DemandPath_links{d in Demands, p in 1..demand_maxPath[d]} within Links default {};
set Demand_pathLinks{d in Demands, p in 1..demand_maxPath[d]} within Links default {};

set PathLinks{d in Demands, p in 1..demand_maxPath[d]} within Links
    := DemandPath_links[d,p] union Demand_pathLinks[d,p];

# Tryb pracy:
# isDDAP = 0 -> DAP
# isDDAP = 1 -> DDAP
param isDDAP binary default 0;

# z in DAP, for DDAP z = 0
param useZ binary default 1;
