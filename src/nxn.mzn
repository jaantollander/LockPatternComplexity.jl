include "globals.mzn";

% Define a two-dimensional nxn grid.
int: n;
int: m = n*n;

% Cartesian coordinates
array[1..m] of int: x = [j | i in 1..n, j in 1..n];
array[1..m] of int: y = [i | i in 1..n, j in 1..n];

% Lock pattern is a permutation of the indices from 1 to m.
array[1..m] of var 1..m: p;
constraint alldifferent(p);

% Define permutations for symmetrical lock patterns
array[1..m] of int: flip_horizontal = [j+i*n | i in 0..n-1, j in reverse(1..n)];
array[1..m] of int: rotate_90 = [j+i*n | j in 1..n, i in reverse(0..n-1)];
array[1..m] of int: rotate_180 = [rotate_90[i] | i in rotate_90];
array[1..m] of int: rotate_270 = [rotate_180[i] | i in rotate_90];
array[1..m] of int: rotate_180_flip_h = [rotate_180[i] | i in flip_horizontal];
array[1..m] of int: rotate_270_flip_h = [rotate_270[i] | i in flip_horizontal];

% Break symmetrical lock patterns
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in flip_horizontal]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in rotate_90]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in rotate_180]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in rotate_180_flip_h]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in rotate_270]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in rotate_270_flip_h]));

% Differences
array[1..m-1] of var int: dx = [x[p[i]] - x[p[i+1]] | i in 1..m-1];
array[1..m-1] of var int: dy = [y[p[i]] - y[p[i+1]] | i in 1..m-1];

% Maximum complexity constraints.
predicate line(int: x1, int: y1, int: k) = exists(i in 1..m-1, c in 1..k)(
    (dx[i] = c*x1 /\ dy[i] = c*y1) \/ (dx[i] = -c*x1 /\ dy[i] = -c*y1)
);

int: N;
array[1..N] of int: xs;
array[1..N] of int: ys;
array[1..N] of int: ds;
constraint count(i in 1..N)(line(xs[i], ys[i], ds[i])) = min(N, m-1);
% constraint forall(i in 1..N)(line(xs[i], ys[i], ds[i]));

% Find max complexity patterns
solve satisfy;
output ["pattern=\(p)", "\n", "distance=\(sum(i in 1..m-1)(abs(dx[i]) + abs(dy[i])))"];

% Maximize distance
% var int: distance = sum(i in 1..m-1)(abs(dx[i]) + abs(dy[i]));
% solve maximize distance;
% output ["pattern=\(p)", "\n", "distance=\(distance)"];
