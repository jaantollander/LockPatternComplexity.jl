include "globals.mzn";
include "nxn_lock_pattern.mzn";
include "nxn_max_complexity.mzn";

% Maximize distance
% TODO: add tight bounds for distance variable?
var int: distance = sum(i in 1..m-1)(abs(dx[i]) + abs(dy[i]));
solve maximize distance;
output ["pattern=\(p)", "\n", "distance=\(distance)"];
