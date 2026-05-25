# =========================
# Single-path routing: core
# (vars are declared in wrappers)
# =========================

# Variables:
# var u{d,p} ...  (binary lub 0..1)
# var y{e} ...    (integer>=0 lub >=0)
# var z;
# var load{e} >= 0;

# Single-path:
subject to cns_single_path{d in Demands}:
    sum{p in 1..demand_maxPath[d]} u[d,p] = 1;

# Load:
subject to cns_link_load{e in Links}:
    load[e] =
        sum{d in Demands}
        sum{p in 1..demand_maxPath[d] : e in PathLinks[d,p]}
            demand_volume[d] * u[d,p];

# Capacity:
# DAP: capacity = moduleCapacity * link_moduleCount[e]
# DDAP: capacity = moduleCapacity * y[e]
subject to cns_capacity{e in Links}:
    load[e] <= moduleCapacity * ((1-isDDAP)*link_moduleCount[e] + isDDAP*y[e])
              + (if useZ=1 then z else 0);

subject to cns_fix_z_when_unused:
    (1-useZ) * z = 0;

# - DAP: minimize z
# - DDAP: minimize cost
minimize Obj:
    z;
