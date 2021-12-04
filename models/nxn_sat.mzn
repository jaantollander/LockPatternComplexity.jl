include "globals.mzn";
include "nxn_lock_pattern.mzn";
include "nxn_max_complexity.mzn";

% Find max complexity patterns
int: d_lb;
int: d_ub;
% var d_lb..d_ub: distance = sum(i in 1..m-1)(abs(dx[i]) + abs(dy[i]));
solve satisfy;
output ["pattern=\(p)", "\n", "distance=\(sum(i in 1..m-1)(abs(dx[i]) + abs(dy[i])))"];
