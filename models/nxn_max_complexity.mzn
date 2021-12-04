% Line types
int: N;
array[1..N] of int: xs;
array[1..N] of int: ys;
array[1..N] of int: ks;

% Maximum complexity constraints.
predicate line(int: x1, int: y1, int: k) = exists(i in 1..M, c in 1..k)(
    (dx[i] = c*x1 /\ dy[i] = c*y1) \/ (dx[i] = -c*x1 /\ dy[i] = -c*y1)
);

constraint if N = M then
    forall(i in 1..N)(line(xs[i], ys[i], ks[i]))
else
    count(i in 1..N)(line(xs[i], ys[i], ks[i])) = min(N, M)
endif;
