include "globals.mzn";

% Define a two-dimensional nxn grid.
int: n;
int: m;
array[1..m] of int: x;
array[1..m] of int: y;
int: M;

% Lock pattern is a permutation of the indices from 1 to m.
array[1..m] of var 1..m: p;
constraint alldifferent(p);

% Define permutations for symmetrical lock patterns
array[1..m] of int: r90;
array[1..m] of int: r180;
array[1..m] of int: r270;
array[1..m] of int: reflect;
array[1..m] of int: r180_reflect;
array[1..m] of int: r270_reflect;

% Break symmetrical lock patterns
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in reflect]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in r90]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in r180]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in r180_reflect]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in r270]));
constraint symmetry_breaking_constraint(lex_lesseq(p, [p[i] | i in r270_reflect]));

% Differences
array[1..M] of var int: dx = [x[p[i]] - x[p[i+1]] | i in 1..M];
array[1..M] of var int: dy = [y[p[i]] - y[p[i+1]] | i in 1..M];

% Maximum complexity constraints.
predicate line(int: x1, int: y1, int: k) = exists(i in 1..M, c in 1..k)(
    (dx[i] = c*x1 /\ dy[i] = c*y1) \/ (dx[i] = -c*x1 /\ dy[i] = -c*y1)
);

% Line types
int: N;
array[1..N] of int: xs;
array[1..N] of int: ys;
array[1..N] of int: ks;

constraint if N = M then
    forall(i in 1..N)(line(xs[i], ys[i], ks[i]))
else
    count(i in 1..N)(line(xs[i], ys[i], ks[i])) = min(N, M)
endif;
