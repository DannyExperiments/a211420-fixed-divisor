# Referee report

## Executive verdicts

**Audit A — mathematical correctness:** **CORRECT AFTER SPECIFIED REPAIRS.**
**Confidence:** high, approximately (0.99).

The proposed theorem is true, and the prime-power argument proves the stated constant
[
C(k,r)=L_r^r,\qquad L_r=\operatorname{lcm}(1,\dots,8r-1).
]
The repairs are formal rather than substantive: define (v_p) on positive rationals, explicitly prove (a_n\in\mathbb Z), state that all valuation sums are finite, and use (\Delta\ge 0) when discarding the small-prime-power terms from (v_p(a_n)).

**Audit B — provenance and priority:**

* For the **sharp strengthening (L_r^r)**: **no prior art found in the searched sources.**
  **Confidence:** moderate, approximately (0.75), because priority searches cannot certify absence.
* For the **weaker OEIS existence statement**, and specifically the proposed larger constant (((8r)!)^r): it is a **direct corollary of Landau’s classical multivariate factorial-ratio criterion**, after an explicit two-variable substitution and a short step-function verification.
  **Confidence:** high, approximately (0.98).
* I found no source recording that particular Landau substitution, but that is not enough to claim that it is new.

The current OEIS entry states the (k=1,2,3) conjecture and attributes it to Peter Bala, dated August 26, 2025. Its revision history shows that the initial August 26 version concerned the odd progression for (k=2), and the current consecutive-factor formulation for all three (k)'s was added on August 27, 2025. ([OEIS][1])

---

# Audit A: mathematical correctness

## 1. Strongest objection

The most serious defect in the proof as written is the transition from inequalities of valuations to an integer divisibility statement without first specifying that (v_p) is being applied to a rational number and without explicitly proving that (a_n) is an integer.

Legendre’s formula initially gives
[
v_p(a_n)
]
as the valuation of a positive rational factorial quotient. This is legitimate if (v_p\colon\mathbb Q_{>0}\to\mathbb Z) is being used, but one must then establish either:

1. (a_n\in\mathbb Z), before writing (D_{k,r}(n)\mid L_r^r a_n); or
2. directly that
   [
   \frac{L_r^r a_n}{D_{k,r}(n)}
   ]
   is a positive rational with nonnegative valuation at every prime, hence an integer.

The proof supplies exactly what is needed because (\Delta\ge0). It merely fails to state the closure argument.

A second omitted step occurs in the final inequality:
[
\sum_{p^j\ge8r}\Delta(n/p^j)\le v_p(a_n).
]
This uses (\Delta\ge0) for all omitted powers (p^j<8r). Again, this is true but should be explicit.

Neither defect changes the theorem or its constant.

---

## 2. Exact computation of (\Delta)

Because the coefficients satisfy
[
8+1-4-3-2=0,
]
one has
[
\Delta(x+1)=\Delta(x).
]

On ([0,1)), all breakpoints of the constituent floor functions are
[
0,\ \frac18,\ \frac14,\ \frac13,\ \frac38,\ \frac12,
\frac58,\ \frac23,\ \frac34,\ \frac78,\ 1.
]

The complete table is:

| Interval            | (\Delta(x)) |
| ------------------- | ----------: |
| ([0,\frac18))       |         (0) |
| ([\frac18,\frac14)) |         (1) |
| ([\frac14,\frac13)) |         (1) |
| ([\frac13,\frac38)) |         (0) |
| ([\frac38,\frac12)) |         (1) |
| ([\frac12,\frac58)) |         (0) |
| ([\frac58,\frac23)) |         (1) |
| ([\frac23,\frac34)) |         (0) |
| ([\frac34,\frac78)) |         (0) |
| ([\frac78,1))       |         (1) |

Thus
[
\Delta(x)\in{0,1},
]
and
[
\operatorname{supp}(\Delta)\cap[0,1)
====================================

\left[\frac18,\frac13\right)
\cup
\left[\frac38,\frac12\right)
\cup
\left[\frac58,\frac23\right)
\cup
\left[\frac78,1\right).
]

The exact endpoint values are
[
\begin{aligned}
&\Delta(0)=0,\qquad \Delta(1/8)=1,\qquad
\Delta(1/4)=1,\qquad \Delta(1/3)=0,\
&\Delta(3/8)=1,\qquad \Delta(1/2)=0,\qquad
\Delta(5/8)=1,\qquad \Delta(2/3)=0,\
&\Delta(3/4)=0,\qquad \Delta(7/8)=1,\qquad
\Delta(1)=0.
\end{aligned}
]

The points (1/4) and (3/4) are breakpoints of individual summands but not genuine jumps of (\Delta). The half-open conventions in the proposed support are correct because floor functions are right-continuous.

---

## 3. Legendre’s formula and integrality of (a_n)

Define (v_p) on (\mathbb Q_{>0}). Legendre’s formula gives
[
v_p(N!)=\sum_{j\ge1}\left\lfloor\frac{N}{p^j}\right\rfloor.
]
Therefore
[
\begin{aligned}
v_p(a_n)
&=
\sum_{j\ge1}
\left(
\left\lfloor\frac{8n}{p^j}\right\rfloor
+
\left\lfloor\frac n{p^j}\right\rfloor
-------------------------------------

## \left\lfloor\frac{4n}{p^j}\right\rfloor

## \left\lfloor\frac{3n}{p^j}\right\rfloor

\left\lfloor\frac{2n}{p^j}\right\rfloor
\right)\
&=\sum_{j\ge1}\Delta\left(\frac n{p^j}\right).
\end{aligned}
]

There is no convergence issue. If (p^j>8n), every displayed floor is zero, so only finitely many terms are nonzero. For (n=0), the entire sum is zero and (a_0=1).

Since (\Delta\ge0),
[
v_p(a_n)\ge0
]
for every prime (p). A positive rational number whose valuations are nonnegative at every prime is an integer: write it in lowest terms, and any prime dividing its denominator would have negative valuation. Hence
[
a_n\in\mathbb Z_{>0}.
]

This is also precisely the one-variable Landau criterion in this special case.

---

## 4. Valuation of (D_{k,r}(n))

Let
[
D_{k,r}(n)=\prod_{i=1}^r(kn+i).
]
Then
[
\begin{aligned}
v_p(D_{k,r}(n))
&=\sum_{i=1}^r v_p(kn+i)\
&=\sum_{i=1}^r\sum_{j\ge1}
\mathbf 1_{{p^j\mid kn+i}}\
&=\sum_{j\ge1}N_{p^j}.
\end{aligned}
]

This correctly counts repeated prime powers. For example, if (p^e\mid kn+i), then the (i)-th factor contributes once to each of
[
N_p,N_{p^2},\dots,N_{p^e}.
]
All sums are finite.

---

## 5. The bound (N_q\le1) for (q\ge8r)

In fact, only (q>r-1) is needed.

If (q) divides both (kn+i) and (kn+i'), then
[
q\mid i-i'.
]
For (1\le i,i'\le r) and (i\ne i'),
[
0<|i-i'|\le r-1<q,
]
which is impossible. Hence
[
N_q\le1.
]

Because (q\ge8r) implies (q>r), the stated assertion is correct.

---

## 6. Complete residue-class check

Assume (q=p^j\ge8r) and (q\mid kn+i), where (1\le i\le r). Write
[
kn+i=mq
]
and put
[
t=\frac{i}{kq}.
]
Then
[
0<t\le\frac{1}{8k},
]
with equality exactly when (q=8r) and (i=r), and
[
\frac nq=\frac mk-t.
]

### (k=1)

Here (m) is integral and
[
\left{\frac nq\right}=1-t\in\left[\frac78,1\right).
]
This lies in the fourth component of (I).

### (k=2)

If (m\equiv0\pmod2), then
[
\left{\frac nq\right}=1-t
\in\left[\frac{15}{16},1\right)
\subseteq\left[\frac78,1\right).
]

If (m\equiv1\pmod2), then
[
\left{\frac nq\right}=\frac12-t
\in\left[\frac7{16},\frac12\right)
\subseteq\left[\frac38,\frac12\right).
]

### (k=3)

If (m\equiv0\pmod3), then
[
\left{\frac nq\right}=1-t
\in\left[\frac{23}{24},1\right)
\subseteq\left[\frac78,1\right).
]

If (m\equiv1\pmod3), then
[
\left{\frac nq\right}=\frac13-t
\in\left[\frac7{24},\frac13\right)
\subseteq\left[\frac18,\frac13\right).
]

If (m\equiv2\pmod3), then
[
\left{\frac nq\right}=\frac23-t
\in\left[\frac58,\frac23\right).
]

Consequently, whenever (q\mid kn+i),
[
\Delta(n/q)=1.
]
Since (N_q\le1),
[
N_q\le\Delta(n/q).
]

### Edge cases

* **(q=8r,\ i=r):** equality in the lower bound produces one of
  [
  \frac78,\quad \frac7{16},\quad \frac{15}{16},
  \quad \frac7{24},\quad\frac58,\quad\frac{23}{24}.
  ]
  Every relevant lower endpoint is included.
* **Right endpoints:** never attained because (i>0), hence (t>0).
* **(n=0):** then (kn+i=i\le r<q), so no (q\ge8r) divides a factor; thus (N_q=0).
* **(p\mid k):** harmless. The proof never divides a congruence by (k) modulo (q); it only uses the exact equality (kn+i=mq).
* **Prime-power equality (p^j=8r):** correctly belongs to the large-(q) part and is covered by the included endpoints.

---

## 7. The least-common-multiple identity

For a prime (p),
[
v_p(L_r)
========

\max{e\ge0:p^e\le8r-1}.
]
Because (p^e) is integral,
[
p^e\le8r-1
\quad\Longleftrightarrow\quad
p^e<8r.
]
Therefore
[
v_p(L_r)
========

#{j\ge1:p^j<8r}.
]

This includes exactly the powers assigned to the small-prime-power part.

---

## 8. Final valuation argument

For every prime (p),
[
\begin{aligned}
v_p(D_{k,r}(n))
&=\sum_{p^j<8r}N_{p^j}
+\sum_{p^j\ge8r}N_{p^j}\
&\le
r,#{j:p^j<8r}
+\sum_{p^j\ge8r}\Delta(n/p^j)\
&=
r,v_p(L_r)
+\sum_{p^j\ge8r}\Delta(n/p^j)\
&\le
r,v_p(L_r)
+\sum_{j\ge1}\Delta(n/p^j)\
&=
r,v_p(L_r)+v_p(a_n)\
&=
v_p(L_r^r a_n).
\end{aligned}
]

The penultimate inequality is where the proof must explicitly invoke
[
\Delta(x)\ge0.
]

Since (D_{k,r}(n)) and (L_r^r a_n) are positive integers, the prime-by-prime inequalities imply
[
D_{k,r}(n)\mid L_r^r a_n.
]

Thus the theorem is proved with
[
C(k,r)=L_r^r>0.
]
The same constant works for all three (k)'s.

Because
[
L_r\mid(8r-1)!\mid(8r)!,
]
both
[
((8r-1)!)^r
\quad\text{and}\quad
((8r)!)^r
]
also work.

---

## 9. Counterexample search

Two independent exact searches found no counterexample.

### Large optimized search

The search covered
[
0\le n\le10{,}000,\qquad
1\le r\le1{,}000,\qquad
k\in{1,2,3}.
]

That is:

* (30{,}003{,}000) triples ((n,r,k));
* (75{,}347{,}906) exact prime-valuation checks;
* integer floor arithmetic only;
* no factorials converted to floating point;
* no counterexample.

The minimum checked slack was zero, attained, for example, at
[
n=1,\quad r=1,\quad k=2,\quad p=3.
]

The optimized search checks a prime whenever its left-hand valuation changes. This is sufficient because, for fixed (n,p),
[
v_p(a_n)+r,v_p(L_r)
]
is nondecreasing in (r), whereas (v_p(D_{k,r}(n))) changes only when (p\mid kn+r).

The exact C++ source referenced by the original Pro run was not present in the
supplied handoff. The [large-search run log](../checks/a211420_exact_search.log)
is preserved.

Source SHA-256:

```text
cb62c94bf1587f572ee1ea708484ce17341101f2711ddb21529c59aef4377cbb
```

### Independent direct search

A separate direct implementation recomputed (v_p(D)) from its defining product and tested every relevant prime for
[
0\le n\le150,\qquad 1\le r\le60,\qquad k\in{1,2,3}.
]

It checked:

* (27{,}180) triples;
* (2{,}636{,}460) prime inequalities;
* no counterexample.

[Independent direct-check source](../checks/a211420_direct_check.py)
[Independent check log](../checks/a211420_direct_check.log)

These computations support the audit, but the correctness verdict rests on the valuation proof, not on the computation.

---

## 10. Does it prove the intended OEIS statement?

Yes.

The current OEIS assertion asks for a constant (C(k,r)), independent of (n), such that
[
\frac{C(k,r)a_n}{(kn+1)\cdots(kn+r)}
]
is integral for every (n). It does not literally state (C(k,r)>0), but the displayed examples (35,3,5) and the intended divisibility language make the nonzero positive interpretation clear. ([OEIS][1])

The proof gives the explicit positive integer
[
C(k,r)=L_r^r\ge1,
]
independent of (n). It therefore proves a nonvacuous statement strictly stronger than the intended conjecture.

---

## 11. Formalization status

No Lean 4, Isabelle, or Coq executable was available in the audit environment, so I did not complete or claim a machine-checked proof.

A clean formal specification should avoid natural-number division and state the result in cross-multiplied form. For example, the intended Lean-style specification is:

```lean
def ANum (n : ℕ) : ℕ :=
  (8 * n).factorial * n.factorial

def ADen (n : ℕ) : ℕ :=
  (4 * n).factorial * (3 * n).factorial * (2 * n).factorial

def D (k r n : ℕ) : ℕ :=
  ∏ i in Finset.range r, (k * n + (i + 1))

def L (r : ℕ) : ℕ :=
  (Finset.range (8 * r - 1)).lcm (fun i => i + 1)

theorem a211420_strengthened
    (n r k : ℕ)
    (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    0 < L r ^ r ∧
    ADen n ∣ ANum n ∧
    D k r n * ADen n ∣ L r ^ r * ANum n := by
  ...
```

The final conjunct is equivalent to the desired divisibility once
[
\operatorname{ADen}(n)\mid\operatorname{ANum}(n)
]
has been established. This formulation explicitly asserts that the constant (L_r^r) is positive and cannot be satisfied vacuously by (C=0).

---

# Audit B: provenance, literature, and priority

## 1. Closest prior result: Landau’s multivariate criterion

### Bibliographic record

Edmund Landau, “Sur les conditions de divisibilité d’un produit de factorielles par un autre,” *Nouvelles annales de mathématiques*, 3rd series, **19** (1900), 344–362.

* Relevant conclusion: pp. 354–355.
* DOI: none located.
* arXiv: none.
* MR/Zbl: none located; the paper predates those databases.

Landau proves the necessary-and-sufficient nonnegativity criterion for factorial ratios built from nonnegative integral linear forms. A modern exact restatement appears as Bober’s Theorem 3.1, p. 7: the factorial ratio is integral for all nonnegative integer inputs iff the associated floor step function is nonnegative on the unit cube. ([Numdam][2])

### Exact substitution

Fix (k\in{1,2,3}) and (r\ge1). Introduce a second nonnegative integer (t) and define
[
B_{k,r}(n,t)=
\frac{
(8n)!,n!,(kn)!,\bigl((8r)t\bigr)!^{,r}
}{
(4n)!,(3n)!,(2n)!,(kn+rt)!
}.
]

At (t=1),
[
\begin{aligned}
B_{k,r}(n,1)
&=
\frac{((8r)!)^r(8n)!,n!,(kn)!}
{(4n)!(3n)!(2n)!(kn+r)!}\
&=
\frac{((8r)!)^r a_n}
{(kn+1)(kn+2)\cdots(kn+r)}.
\end{aligned}
]

The associated two-variable Landau function is
[
G(x,y)
======

\Delta(x)+\lfloor kx\rfloor
+r\lfloor8ry\rfloor
-\lfloor kx+ry\rfloor .
]

Set
[
E=\lfloor kx+ry\rfloor-\lfloor kx\rfloor.
]

If (y\ge1/(8r)), then
[
r\lfloor8ry\rfloor\ge r
\quad\text{and}\quad
E\le r,
]
so (G(x,y)\ge\Delta(x)\ge0).

If (0\le y<1/(8r)), then (0\le ry<1/8) and (E\in{0,1}).

* If (E=0), then (G=\Delta\ge0).
* If (E=1), then
  [
  {kx}+ry\ge1,
  \qquad\text{hence}\qquad
  {kx}>7/8.
  ]
  For (k=1,2,3), this forces (x) into exactly the same support intervals used in the candidate proof:
  [
  \begin{array}{c|c}
  k & {kx}>7/8\text{ forces}\ \hline
  1 & x\in(7/8,1)\
  2 & x\in(7/16,1/2)\cup(15/16,1)\
  3 & x\in(7/24,1/3)\cup(5/8,2/3)\cup(23/24,1).
  \end{array}
  ]
  Thus (\Delta(x)=1) and (G=0).

Therefore (G\ge0) on ([0,1]^2), so Landau’s theorem gives
[
B_{k,r}(n,t)\in\mathbb Z
]
for all (n,t\ge0). Taking (t=1) proves
[
(kn+1)\cdots(kn+r)\mid ((8r)!)^r a_n.
]

### Classification

* For the OEIS existence conjecture and the constant (((8r)!)^r):
  **DIRECT COROLLARY OF A MORE GENERAL RESULT.**
* For the sharper constant (L_r^r):
  **SAME METHOD BUT NOT THE RESULT.**

This is the closest prior result. It materially weakens any priority claim for the existence theorem, even though I found no source spelling out this exact substitution.

---

## 2. Bober 2009

Jonathan W. Bober, “Factorial ratios, hypergeometric series, and a family of step functions,” *Journal of the London Mathematical Society* (2) **79** (2009), no. 2, 422–444.

* DOI: 10.1112/jlms/jdn078.
* arXiv: 0709.1977.
* MR: MR2496522.
* Zbl identifier: not independently verified in this audit. ([arXiv][3])

### Theorem 1.2, arXiv p. 3

Bober’s third infinite family is
[
u_n(a,b)=
\frac{(2an)!(bn)!}
{(an)!(2bn)!((a-b)n)!},
\qquad a>b,\quad (a,b)=1.
]

Substituting
[
a=4,\qquad b=1
]
gives exactly
[
u_n(4,1)
========

\frac{(8n)!n!}{(4n)!(2n)!(3n)!}
=a_n.
]

Thus Bober proves that (a_n) is integral. He does not establish divisibility by a growing product ((kn+1)\cdots(kn+r)), nor a fixed multiplier for that quotient. 

**Classification:** **SAME METHOD BUT NOT THE RESULT.**

### Theorem 3.1, arXiv p. 7

This is the multivariate Landau theorem used above. It does imply the coarse OEIS bound after the new substitution (B_{k,r}(n,t)). 

**Classification for the coarse bound:** **DIRECT COROLLARY OF A MORE GENERAL RESULT.**

### Theorem 4.6, arXiv pp. 12–13

For a balanced one-variable factorial ratio, the generating function is algebraic precisely in the height-one integral case. This explains the algebraicity of the generating function of (a_n), but not the target divisibility. 

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 3. Rodriguez-Villegas

Fernando Rodriguez-Villegas, “Integral ratios of factorials and algebraic hypergeometric functions,” *Oberwolfach Reports* **2** (2005), no. 3, 1813–1816; preprint arXiv:math/0701362.

* Article-level DOI: none found in the searched sources.
* MR/Zbl: none independently verified.

### Theorem 1, preprint p. 1

For a regular finitely supported sequence (\gamma), the associated generating function is “algebraic iff (\gamma) is integral and (d=1).” 

For the present sequence, take
[
\gamma_8=\gamma_1=1,\qquad
\gamma_4=\gamma_3=\gamma_2=-1,
]
and all other (\gamma_\nu=0). Then
[
a_n=\prod_{\nu\ge1}(\nu n)!^{\gamma_\nu}.
]
It is regular because
[
8+1-4-3-2=0,
]
and its dimension is
[
d=-\sum_\nu\gamma_\nu=1.
]

Rodriguez-Villegas’s theorem therefore connects the integrality of (a_n) to the algebraicity of its generating function. The paper also states the one-variable Landau valuation formula and criterion. 

It does not produce a fixed constant for division by (D_{k,r}(n)).

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 4. Bell–Bober

Jason P. Bell and Jonathan W. Bober, “Bounded step functions and factorial ratio sequences,” *International Journal of Number Theory* **5** (2009), no. 8, 1419–1431.

* DOI: 10.1142/S1793042109002742.
* arXiv: 0710.3459.
* MR/Zbl: not independently verified. ([University of Bristol][4])

### Theorem 1.1, arXiv p. 2

For a balanced nonnegative factorial-ratio step function of height (D=L-K), the theorem bounds the total number of factorial factors:
[
K+L\ll D^2(\log D)^2.
]
It is a structural finiteness/boundedness result, not a theorem about division of a particular integral factorial ratio by linear factors. 

There is no substitution that yields
[
D_{k,r}(n)\mid C a_n.
]

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 5. Soundararajan

K. Soundararajan, “Integral factorial ratios,” *Duke Mathematical Journal* **171** (2022), no. 3, 633–672.

* DOI: 10.1215/00127094-2021-0017.
* arXiv: 1901.05133.
* MR: MR4383251.
* Zbl: not independently verified.

### Theorem 1.1, p. 1

The theorem rederives the complete height-one classification: three infinite families and 52 sporadic cases. The third family contains (a_n) under (a=4,b=1). 

No fixed-denominator or rising-factorial divisibility theorem is stated.

**Classification:** **SAME METHOD BUT NOT THE RESULT.**

A companion paper, K. Soundararajan, “Integral factorial ratios: irreducible examples with height larger than 1,” *Philosophical Transactions of the Royal Society A* **378** (2020), article 20180444, arXiv:1906.06413, constructs and studies higher-height factorial-ratio families. Its introduction explicitly traces the height-one classification through Rodriguez-Villegas and Bober, but its results concern classification and irreducibility, not the target divisibility. ([arXiv][5])

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 6. Adolphson–Sperber

### 2020 paper

Alan Adolphson and Steven Sperber, “On the integrality of factorial ratios and mirror maps,” *INTEGERS* **20** (2020), A10, 15 pp.; arXiv:1802.08348.

### Theorem 1, p. 2

The paper gives a modern multivariate statement of Landau’s theorem: under the balanced condition, the ratio is integral for all nonnegative integer vectors iff the associated step function is nonnegative on ([0,1)^r). Its subsequent remark states that without balance the criterion remains valid with ([0,1]). 

The auxiliary ratio (B_{k,r}(n,t)) is unbalanced in the (t)-variable, so the remark is the exact applicable version. It yields the coarse constant after the verification above.

**Classification for (((8r)!)^r):** **DIRECT COROLLARY OF A MORE GENERAL RESULT.**

**Classification for (L_r^r):** **SAME METHOD BUT NOT THE RESULT.**

### 2021 paper

Alan Adolphson and Steven Sperber, “On the integrality of hypergeometric series whose coefficients are factorial ratios,” *Acta Arithmetica* **200** (2021), 39–59.

* DOI: 10.4064/aa200427-5-4.
* arXiv: 2001.03296.

Example 2, pp. 14–15, generalizes one direction of Landau’s theorem for (A)-hypergeometric series. It concerns integrality of multivariate factorial-ratio coefficients, not division of one fixed sequence by the rising products in the conjecture. ([arXiv][6])

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 7. Mirror maps and Landau-function extensions

### Delaygue 2013

Éric Delaygue, “A criterion for the integrality of the Taylor coefficients of mirror maps in several variables,” *Advances in Mathematics* **234** (2013), 414–452.

* DOI: 10.1016/j.aim.2012.09.028.
* arXiv: 1108.4352. ([arXiv][7])

Theorem 1, pp. 4–5, gives a Landau-function criterion for integrality of canonical coordinates or mirror maps. Its conclusion concerns coefficients of
[
z_k\exp(G_k/F),
]
not the fixed multiplier needed to divide (a_n) by (D_{k,r}(n)). 

**Classification:** **RELATED BUT INSUFFICIENT.**

### Delaygue–Rivoal–Roques 2017

Éric Delaygue, Tanguy Rivoal, and Julien Roques, “On Dwork’s (p)-adic formal congruences theorem and hypergeometric mirror maps,” *Memoirs of the American Mathematical Society* **246** (2017), no. 1163, v+94 pp.

* DOI: 10.1090/memo/1163.
* arXiv: 1309.5902. ([American Mathematical Society][8])

Theorem 1, p. 4 of the preprint, gives an explicit Eisenstein constant (C_{\alpha,\beta}) for an (N)-integral hypergeometric series. Here (N)-integrality means that
[
F_{\alpha,\beta}(cz)\in\mathbb Z[[z]]
]
for some rational (c), so the (n)-th coefficient is multiplied by (c^n), not by one fixed integer independent of (n). 

That distinction is decisive: an Eisenstein constant does not establish
[
D_{k,r}(n)\mid C a_n
]
with fixed (C).

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 8. Recent denominator-bound literature

Christian Krattenthaler and Tanguy Rivoal, “Arithmetic properties of the Taylor coefficients of differentially algebraic power series,” arXiv:2502.09259 (2025).

* No journal publication or journal DOI was found in the searched sources as of July 21, 2026. ([arXiv][9])

### Theorem 2, preprint pp. 8–9

For nonlinear recurrences whose denominator contains split linear factors
[
\prod_i(a_i n+b_i),
]
the theorem gives effective denominator bounds of the form
[
\delta^{n+1}(\nu n+\nu)!^{2s}.
]
Its proof uses detailed (p)-adic control and a finite exceptional-prime factor. 

This is methodologically close to the present problem because it separates uniform large-prime behavior from finitely many small primes. But its hypotheses and conclusions do not specialize to
[
\frac{a_n}{(kn+1)\cdots(kn+r)}
]
with the fixed multiplier (L_r^r).

**Classification:** **RELATED BUT INSUFFICIENT.**

---

## 9. Thesis, MathOverflow, and other screened sources

Jonathan W. Bober, *Integer Ratios of Factorials, Hypergeometric Functions, and Related Step Functions*, PhD dissertation, University of Michigan, 2009, develops the same classification, hypergeometric, and step-function framework. No target fixed-denominator theorem was found in the thesis. ([Deep Blue][10])

**Classification:** **SAME METHOD BUT NOT THE RESULT.**

The MathOverflow question “Integer-valued factorial ratios,” asked by Wadim Zudilin in 2010, discusses the Legendre/Landau proof for Chebyshev’s factorial ratio and points to Bober’s classification. It contains no result about the A211420 rising-factorial denominator. ([MathOverflow][11])

**Classification:** **RELATED BUT INSUFFICIENT.**

I also screened literature on globally bounded hypergeometric series, Christol’s criterion, algebraic hypergeometric functions, (G)-functions, mirror maps, Lucas-type congruences, quotient singularities, and higher-height integral factorial ratios. Those theories concern integrality of the original factorial ratio, algebraicity, coefficient rescaling by (C^n), congruences, or classification. I found no theorem in them that directly supplies the sharp constant (L_r^r).

---

## 10. Hypergeometric reformulation and why global boundedness is insufficient

The sequence can be written as
[
a_n=
\left(\frac{2^{14}}{27}\right)^n
\frac{
(1/8)_n(3/8)_n(5/8)_n(7/8)_n
}{
(1/3)_n(1/2)_n(2/3)_n,n!
}.
]
This is the coefficient sequence of the ({}_4F_3) recorded in OEIS. ([OEIS][1])

Moreover,
[
\frac1{kn+i}
============

\frac1i,\frac{(i/k)_n}{(i/k+1)*n},
]
and therefore
[
\frac{a_n}{D*{k,r}(n)}
======================

\frac{a_n}{r!}
\prod_{i=1}^r
\frac{(i/k)_n}{(i/k+1)_n}.
]

This embeds the quotient into a generalized hypergeometric coefficient problem. But standard global boundedness gives a scaling
[
C^n\frac{a_n}{D_{k,r}(n)}\in\mathbb Z,
]
not a fixed multiplier
[
C\frac{a_n}{D_{k,r}(n)}\in\mathbb Z
]
uniformly in (n). Hence Christol/Eisenstein/G-function denominator results do not by themselves imply the conjecture.

---

# Required final report

## 1. Correctness verdict and confidence

**CORRECT AFTER SPECIFIED REPAIRS.**

**Confidence: high, (0.99).**

Necessary repairs:

1. Define (v_p) on (\mathbb Q_{>0}).
2. Give the complete (\Delta)-table and establish (\Delta\ge0).
3. State that the Legendre and product-valuation sums are finite.
4. Deduce (a_n\in\mathbb Z_{>0}), or use the equivalent rational-valuation closure argument.
5. Explicitly use (\Delta\ge0) when replacing the large-(p^j) sum by (v_p(a_n)).
6. State
   [
   C(k,r)=L_r^r>0
   ]
   and conclude divisibility between positive integers.

No alteration to the theorem or the constant is required.

## 2. Prior-art verdict and confidence

For the exact strengthening with (L_r^r):

> **No prior art found in the searched sources.**

**Confidence:** moderate, (0.75).

For the weaker OEIS existence statement and the constant (((8r)!)^r):

> **DIRECT COROLLARY OF LANDAU’S MULTIVARIATE CRITERION**, after the explicit auxiliary ratio (B_{k,r}(n,t)) and the step-function check above.

**Confidence:** high, (0.98).

I found no source recording that exact auxiliary ratio or substitution. That is not proof that it was previously unknown.

## 3. Strongest mathematical objection considered

The proof initially treats (a_n) as though it were already an integer and concludes integer divisibility solely from valuations. The missing rational-to-integer step is logically necessary.

After adding
[
\Delta\ge0
\Longrightarrow
v_p(a_n)\ge0\quad\forall p
\Longrightarrow
a_n\in\mathbb Z,
]
and explicitly invoking (\Delta\ge0) in the final truncation, the objection disappears.

The most dangerous substantive boundary case,
[
q=8r,\qquad i=r,
]
also checks: it produces included left endpoints of the support intervals.

## 4. Closest prior result and exact logical mapping

The closest prior result is Landau’s 1900 multivariate factorial-ratio criterion, in the modern form of Bober’s Theorem 3.1.

Use
[
B_{k,r}(n,t)=
\frac{
(8n)!,n!,(kn)!,\bigl((8r)t\bigr)!^r
}{
(4n)!(3n)!(2n)!(kn+rt)!
}.
]
Its Landau step function is
[
G(x,y)
======

\Delta(x)+\lfloor kx\rfloor
+r\lfloor8ry\rfloor-\lfloor kx+ry\rfloor.
]
The residue-support check proves (G\ge0) on ([0,1]^2), so (B_{k,r}(n,t)) is integral. Setting (t=1) gives
[
\frac{((8r)!)^r a_n}{(kn+1)\cdots(kn+r)}\in\mathbb Z.
]

That proves the OEIS conjecture but does not produce the sharper (L_r^r).

## 5. Sources searched and meaningful coverage gaps

The search included:

* the exact identifier A211420 and its OEIS revision history;
* the exact factorial quotient in multiple orderings;
* its binomial representations and ({}_4F_3) parameters;
* rising factorial, Pochhammer, fixed denominator, fixed divisor, and polynomial-divisibility terminology;
* Landau’s original paper and modern statements;
* Bober, Rodriguez-Villegas, Bell–Bober, Soundararajan, Adolphson–Sperber, Delaygue, Delaygue–Rivoal–Roques, and Krattenthaler–Rivoal;
* Bober’s dissertation;
* MathOverflow and searches directed at Mathematics Stack Exchange;
* arXiv, journal/publisher pages, institutional repositories, theses, and representative citation descendants;
* French, German, Russian, and Chinese search variants;
* globally bounded hypergeometric series, Christol criteria, Eisenstein constants, (G)-functions, mirror maps, Lucas congruences, and (p)-adic denominator bounds.

Meaningful gaps remain:

* no search can cover unpublished or private manuscripts;
* subscription-only MathSciNet and zbMATH citation graphs were not exhaustively traversable;
* Google Scholar and Semantic Scholar result sets were incomplete or access-limited;
* older nondigitized books and proceedings may not be full-text indexed;
* non-English institutional repositories are unevenly indexed;
* work circulated after the search date or under unrelated terminology may be missed.

Accordingly, the negative result must remain source-bounded.

## 6. Defensible wording

### “This proves the A211420 conjecture.”

**Yes, defensible.**

A more precise formulation is:

> This proves the current A211420 conjecture for (k=1,2,3), with the explicit positive constant
> [
> C(k,r)=\operatorname{lcm}(1,\ldots,8r-1)^r.
> ]

That statement is mathematically justified.

### “This is the first proof.”

**No, not presently defensible.**

Two independent reasons:

1. No-prior-art searches cannot prove originality.
2. The original existence conjecture with the coarser constant (((8r)!)^r) is already a direct specialization of Landau’s 1900 multivariate criterion, although I found no source that records the specialization.

The strongest defensible priority statement is:

> No prior proof of the explicit (L_r^r) strengthening, and no prior publication of this exact prime-power cutoff argument, was found in the searched sources.

[1]: https://oeis.org/A211420 "A211420 - OEIS"
[2]: https://www.numdam.org/item/NAM_1900_3_19__344_1.pdf "Sur les conditions de divisibilité d'un produit de factorielles par un autre"
[3]: https://arxiv.org/abs/0709.1977 "[0709.1977] Factorial ratios, hypergeometric series, and a family of step functions"
[4]: https://research-information.bris.ac.uk/en/publications/bounded-step-functions-and-factorial-ratio-sequences "
        Bounded step functions and factorial ratio sequences
      \-  University of Bristol"
[5]: https://arxiv.org/abs/1906.06413 "Integral factorial ratios: Irreducible examples with height larger than 1"
[6]: https://arxiv.org/abs/2001.03296 "[2001.03296] On the integrality of hypergeometric series whose coefficients are factorial ratios"
[7]: https://arxiv.org/abs/1108.4352 "[1108.4352] Criterion for the integrality of the Taylor coefficients of mirror maps in several variables"
[8]: https://www.ams.org/books/memo/1163/memo1163.pdf?utm_source=chatgpt.com "On Dwork's 𝑝-Adic Formal Congruences Theorem and ..."
[9]: https://arxiv.org/abs/2502.09259 "[2502.09259] Arithmetic properties of the Taylor coefficients of differentially algebraic power series"
[10]: https://deepblue.lib.umich.edu/bitstreams/19fb5c27-c7f4-48e0-91c7-743cf6356d4f/download?utm_source=chatgpt.com "Integer ratios of factorials, hypergeometric functions, and ..."
[11]: https://mathoverflow.net/questions/26336/integer-valued-factorial-ratios "nt.number theory - Integer-valued factorial ratios - MathOverflow"
