include "nxn_cons.mzn";

% Maximize distance
% TODO: add tight bounds for distance variable?
var int: distance = sum(i in 1..m-1)(abs(dx[i]) + abs(dy[i]));
solve maximize distance;
output ["pattern=\(p)", "\n", "distance=\(distance)"];
