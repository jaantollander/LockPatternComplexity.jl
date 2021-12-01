```@meta
CurrentModule = LockPatternComplexity
```

# Solving the Most Complex Lock Patterns
Documentation for [LockPatternComplexity](https://github.com/jaantollander/LockPatternComplexity.jl).

## Grid
We define a **grid** of size $n×n$ where $n∈ℕ$ as set of points

$$G=\{1,...,n\}×\{1,...,n\}=\{(x, y) ∣ x,y∈\{1,...,n\}\}.$$

The set of **indices** of a grid is

$$I=\{1,2,...,n^2\}.$$

We denote indidual points $(x_i, y_i)$ where $i∈I.$

!!! example
    We define a $3×3$ grid as $G=\{(1, 1), (2, 1), (3, 1), (1, 2), (2, 2), (3, 2), (1, 3), (2, 3), (3, 3)\}$ with indices $I=\{1, 2, 3, 4, 5, 6, 7, 8, 9\}.$


## Lines
A **line** connects two points in the grid. We represent lines as a pair of indices $(i,j)$ where $i,j∈I.$ We denote the **difference** between the endpoints of a line as $(x_{i,j}, y_{i,j})$ where $x_{i,j}=x_j-x_i$ and $y_{i,j}=y_j-y_i.$ 

We define a **line type** as a tuple $(x,y)$ such that $x≥0$ and $x$ and $y$ are coprime, that is, $\gcd(x,y)=1.$ We can calculate the type for a line as

$$t(i,j)=\begin{cases}
(x_{i,j}/d, y_{i,j}/d), & x_{i,j}≥0 \\
(-x_{i,j}/d, -y_{i,j}/d) & x_{i,j}<0
\end{cases}.$$

where the greatest common divisor between the differences is

$$d=\gcd(x_{i,j},y_{i,j}).$$

That is, we regard all lines with differences of form $(c⋅x_{i,j}/d,c⋅y_{i,j}/d)$ where $c∈ℤ$ as the same type.

---

The set of all possible lines

$$L=\{(i, j) ∣ i,j∈I, i≠j\}$$

All differences

$$Δ=\{(x_j-x_i, y_j-y_i)∣ (i,j)∈L\}$$

All **line types**

$$T=\{(x, y) ∣ (x,y)∈Δ, \gcd(x, y)=1, x≥0\}$$

We consider $(x,y)$ and $(-x, -y)$ are same type, therefore, we add the constraint $x≥0.$

Lower bound for line types. [How Many Rational Slopes](https://math.stackexchange.com/questions/1325258/how-many-rational-slopes)

$$|T|≥12⋅(n-1)^2/π^2.$$


## Lock Pattern
A **lock-pattern**, or simply **pattern**, connects all points in the grid with lines such that we visit each point only once. Therefore, we can represent a pattern $p$ as a permutation of the indices $I,$ such that each pair $(i,i+1)$ for all $i∈\{1,...,n^2-1\}$ represents a line.

Number of lines is 

$$n^2-1.$$

We can prove that

$|T|≥n^2-1$

Plot $|T|$, $n^2-1$, and $12⋅(n-1)^2/π^2$.


## Maximum Complexity Pattern
A **maximum complexity pattern** is a pattern whose lines contains at least one of each line type $T.$


## Maximizing the Taxicab Distance


## Symmetrical Patterns
Two patterns are symmetrical a permutation from one to the other preserves distances.


## Index
```@index
```

```@autodocs
Modules = [LockPatternComplexity]
```
