% Line types
int: N;
array[1..N] of int: tx;
array[1..N] of int: ty;
array[1..N] of int: tk;

% Maximum complexity constraints.
predicate line(int: x, int: y, int: k) = exists(i in 1..M, c in 1..k)(
    (dx[i] = c*x /\ dy[i] = c*y) \/ (dx[i] = -c*x /\ dy[i] = -c*y)
);

constraint if N = M then
    forall(i in 1..N)(line(tx[i], ty[i], tk[i]))
else
    count(i in 1..N)(line(tx[i], ty[i], tk[i])) = min(N, M)
endif;
