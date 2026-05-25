include "spr_defs.mod";
let isDDAP := 0;
let useZ   := 1;

var u{d in Demands, p in 1..demand_maxPath[d]} >= 0, <= 1;
var y{e in Links} integer >= 0;
var z;
var load{e in Links} >= 0;

include "spr_core.mod";
