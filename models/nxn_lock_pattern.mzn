% Define a two-dimensional grid.
int: m;
array[1..m] of int: gx;
array[1..m] of int: gy;
int: M = m - 1;

% Lock pattern is a permutation of the indices from 1 to m.
array[1..m] of var 1..m: p;
constraint alldifferent(p);

% Differences
array[1..M] of var int: dx = [gx[p[i]] - gx[p[i+1]] | i in 1..M];
array[1..M] of var int: dy = [gy[p[i]] - gy[p[i+1]] | i in 1..M];

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
