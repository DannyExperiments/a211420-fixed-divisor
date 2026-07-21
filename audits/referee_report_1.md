# Executive findings

**Audit A — mathematical correctness:** **CORRECT AFTER SPECIFIED REPAIRS.**
**Confidence:** high, approximately (0.99).

The proof has no substantive (p)-adic or endpoint error. Its main defect is logical ordering: it uses integer divisibility involving (a_n) before explicitly proving (a_n\in\mathbb Z). This is repaired by initially interpreting (v_p(a_n)) as the valuation of a positive rational number, proving (\Delta\ge 0), and then concluding (a_n\in\mathbb Z_{>0}). The finiteness of the valuation sums and the positivity of the proposed constant should also be stated.

**Audit B — provenance and priority:**

* The **existence assertion in the OEIS conjecture** is a **DIRECT COROLLARY OF A MORE GENERAL RESULT**, namely Landau’s multivariate factorial-ratio criterion. An explicit two-variable substitution gives the larger constant (((8r)!)^r).
* The sharper statement with (L_r^r) is not a consequence of Bober’s classification theorem alone. **No prior art was found in the searched sources for the full (L_r^r) strengthening.**
* Several exact or stronger special cases were already published, notably Sun’s (k=3,r=1) result and Yang’s two-shift result for (k=2).
* Consequently, **“This proves the A211420 conjecture” is defensible.**
* **“This is the first proof” is not defensible.** At most: “No prior proof of the full (L_r^r) strengthening was found in the searched sources.”

The current OEIS entry states the broad conjecture under an August 26, 2025 attribution, but the revision history shows that the original August 26 submission concerned the odd progression (2n+1,2n+3,\ldots), and the version covering (k=1,2,3) and consecutive factors was entered on August 27, 2025. ([OEIS][1])

---

# Audit A: mathematical correctness

## 1. Exact value and support of (\Delta)

Because
[
8+1-4-3-2=0,
]
we have
[
\Delta(x+1)=\Delta(x).
]
Thus it suffices to work on ([0,1)).

The complete ordered list of breakpoints is
[
0,\frac18,\frac14,\frac13,\frac38,\frac12,
\frac58,\frac23,\frac34,\frac78,1.
]

Since floor functions are right-continuous, the exact table is

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

Therefore
[
\Delta(x)\in{0,1}
]
and
[
\Delta(x)=1
\iff
{x}\in
\left[\frac18,\frac13\right)
\cup
\left[\frac38,\frac12\right)
\cup
\left[\frac58,\frac23\right)
\cup
\left[\frac78,1\right).
]

The values at every breakpoint are
[
\begin{array}{c|ccccccccccc}
x&0&\frac18&\frac14&\frac13&\frac38&\frac12&
\frac58&\frac23&\frac34&\frac78&1\ \hline
\Delta(x)&0&1&1&0&1&0&1&0&0&1&0.
\end{array}
]

So the claimed support, including all open and closed endpoints, is exactly correct.

---

## 2. Legendre’s formula, finiteness, and integrality

At the beginning of the argument, define (v_p) on (\mathbb Q^\times), not merely on nonzero integers. Then Legendre’s formula gives
[
\begin{aligned}
v_p(a_n)
&=
\sum_{j\ge1}
\left(
\left\lfloor\frac{8n}{p^j}\right\rfloor
+
\left\lfloor\frac{n}{p^j}\right\rfloor
--------------------------------------

## \left\lfloor\frac{4n}{p^j}\right\rfloor

## \left\lfloor\frac{3n}{p^j}\right\rfloor

\left\lfloor\frac{2n}{p^j}\right\rfloor
\right)\
&=\sum_{j\ge1}\Delta!\left(\frac{n}{p^j}\right).
\end{aligned}
]

There is no convergence issue. For (n>0), if (p^j>8n), then
[
0\le \frac{n}{p^j}<\frac18,
]
so the corresponding term is zero. For (n=0), every term is zero.

Because (\Delta\in{0,1}),
[
v_p(a_n)\ge0
]
for every prime (p). Since (a_n) is a positive rational number, this proves
[
a_n\in\mathbb Z_{>0}.
]

This missing sentence repairs the only significant logical gap. It is also the standard Landau argument; Bober’s Theorem 1.2 independently gives integrality by taking (a=4,b=1) in his family (8). ([arXiv][2])

---

## 3. The identity for (v_p(D_{k,r}(n)))

For each positive integer (M),
[
v_p(M)=\sum_{j\ge1}\mathbf 1_{p^j\mid M}.
]
Therefore
[
\begin{aligned}
v_p(D_{k,r}(n))
&=\sum_{i=1}^r v_p(kn+i)\
&=\sum_{i=1}^r\sum_{j\ge1}\mathbf 1_{p^j\mid kn+i}\
&=\sum_{j\ge1}#{1\le i\le r:p^j\mid kn+i}\
&=\sum_{j\ge1}N_{p^j}.
\end{aligned}
]

Repeated powers of the same prime are counted correctly. For example, if (p^3\mid kn+i), that factor contributes once to each of (N_p,N_{p^2},N_{p^3}), hence three to the sum.

All sums are finite because the factors (kn+i) are fixed positive integers.

---

## 4. Why (N_q\le1) for (q\ge8r)

Suppose (q) divides both (kn+i) and (kn+i'), with (1\le i<i'\le r). Then
[
q\mid(i'-i).
]
But
[
0<i'-i\le r-1<q,
]
because (q\ge8r>r). This is impossible.

Hence
[
N_q\le1.
]

No hypothesis such as (\gcd(k,q)=1) is needed.

---

## 5. Complete residue and endpoint audit

Assume (q\ge8r) and (q\mid kn+i). Write
[
kn+i=mq.
]
Since (i\ge1), one has (m\ge1). Set
[
\varepsilon=\frac{i}{kq}.
]
Then
[
0<\varepsilon\le\frac{r}{k(8r)}=\frac1{8k},
\qquad
\frac nq=\frac mk-\varepsilon.
]

Write (m=kt+s), where (0\le s<k). Then
[
\left{\frac nq\right}
=====================

\begin{cases}
1-\varepsilon,&s=0,[2mm]
\dfrac{s}{k}-\varepsilon,&1\le s<k.
\end{cases}
]

### (k=1)

There is only (s=0), so
[
\left{\frac nq\right}=1-\varepsilon
\in\left[\frac78,1\right).
]

### (k=2)

If (m\equiv0\pmod2),
[
\left{\frac nq\right}
\in\left[\frac{15}{16},1\right).
]

If (m\equiv1\pmod2),
[
\left{\frac nq\right}
\in\left[\frac7{16},\frac12\right).
]

Both intervals are contained in (I):
[
\left[\frac{15}{16},1\right)\subseteq\left[\frac78,1\right),
\qquad
\left[\frac7{16},\frac12\right)\subseteq\left[\frac38,\frac12\right).
]

### (k=3)

If (m\equiv0\pmod3),
[
\left{\frac nq\right}
\in\left[\frac{23}{24},1\right).
]

If (m\equiv1\pmod3),
[
\left{\frac nq\right}
\in\left[\frac7{24},\frac13\right).
]

If (m\equiv2\pmod3),
[
\left{\frac nq\right}
\in\left[\frac58,\frac23\right).
]

Again,
[
\left[\frac{23}{24},1\right)\subseteq\left[\frac78,1\right),
]
[
\left[\frac7{24},\frac13\right)\subseteq\left[\frac18,\frac13\right),
]
and the third interval is already a component of (I).

### Delicate cases

* **(q=8r,\ i=r):** this gives equality in the lower bounds. The resulting values are
  [
  \frac78,\quad\frac{15}{16},\quad\frac7{16},
  \quad\frac{23}{24},\quad\frac7{24},\quad\frac58,
  ]
  all of which lie either at included left endpoints of (I) or in its interior.
* **Upper endpoints:** none is attained because (i>0), so (\varepsilon>0).
* **(n=0):** then (kn+i=i<q), so (q\nmid kn+i), and (N_q=0).
* **(p\mid k):** irrelevant. The proof never divides by (k) modulo (q); it only sorts the ordinary integer (m) modulo (k).
* **Prime-power equality:** whether (8r) itself happens to be a prime power makes no difference; if it is, it is handled by the included endpoints above.

Thus whenever (N_q=1),
[
\Delta(n/q)=1,
]
and hence, for every prime power (q\ge8r),
[
N_q\le\Delta(n/q).
]

---

## 6. The least-common-multiple identity

For any prime (p),
[
v_p(L_r)
========

\max{e\ge0:p^e\le8r-1}.
]
Since (p^e) is integral,
[
p^e\le8r-1
\iff
p^e<8r.
]
Consequently,
[
v_p(L_r)=#{j\ge1:p^j<8r}.
]

This identity is exact, including the strict inequality.

---

## 7. Final valuation argument

Split the valuation into small and large prime powers:
[
v_p(D_{k,r}(n))
===============

\sum_{p^j<8r}N_{p^j}
+
\sum_{p^j\ge8r}N_{p^j}.
]

For the small prime powers,
[
\sum_{p^j<8r}N_{p^j}
\le
r,#{j:p^j<8r}
=============

r,v_p(L_r).
]

For the large prime powers,
[
\sum_{p^j\ge8r}N_{p^j}
\le
\sum_{p^j\ge8r}\Delta(n/p^j)
\le
v_p(a_n).
]

Therefore
[
v_p(D_{k,r}(n))
\le
r,v_p(L_r)+v_p(a_n)
===================

v_p(L_r^r a_n)
]
for every prime (p).

All quantities are now known to be positive integers, so
[
\boxed{
\prod_{i=1}^r(kn+i)\mid L_r^r a_n
}.
]

---

## 8. Counterexample search

An exact integer (p)-adic checker tested

[
0\le n\le10{,}000,\qquad
1\le r\le1{,}000,\qquad
k\in{1,2,3}.
]

It checked (30{,}003{,}000) triples and (75{,}347{,}906) prime-factor updates using Legendre valuations and exact integer factorization. No floating-point factorials were used. No counterexample was found.

The minimum valuation slack was zero, for example at
[
n=1,\quad k=2,\quad r=1,\quad p=3.
]

This computation is corroborative only; the proof above is independent of it.

* [Exact (p)-adic checker](../checks/A211420_padic_audit.cpp)
* [Checker output](../checks/A211420_padic_audit.log)

As a control showing that the restriction (k\in{1,2,3}) is genuine, the same assertion fails for (k=4). Take
[
n=8,\qquad r=1.
]
Then (4n+1=33), but
[
v_{11}(a_8)=0,\qquad v_{11}(L_1)=v_{11}(420)=0.
]
Thus
[
33\nmid420a_8.
]

---

## 9. Does this prove the intended OEIS statement?

Yes.

For each (r\ge1) and (k\in{1,2,3}), take
[
C(k,r)=L_r^r.
]
Then

* (C(k,r)\in\mathbb Z_{>0});
* it is independent of (n);
* in fact it is independent of (k);
* and
  [
  \frac{C(k,r)a_n}{(kn+1)\cdots(kn+r)}\in\mathbb Z
  ]
  for every (n\ge0).

This is the intended nonvacuous formulation, not the trivial statement obtained by permitting (C=0). The still larger constant (((8r)!)^r) works because
[
L_r\mid(8r)!.
]

---

## 10. Formalization status

No Lean 4, Isabelle, or Coq toolchain was available in the execution environment, so I did not claim a machine-checked formalization or provide an uncompiled script as if it were verification.

The correct nonvacuous formal target is explicitly
[
0<L_r^r
\quad\land\quad
\forall n\in\mathbb N,;
D_{k,r}(n)\mid L_r^r a_n,
]
under
[
r\ge1,\qquad k=1\lor k=2\lor k=3.
]

In a formal development, (a_n) should either be defined as an integer only after the Landau-step integrality lemma, or the principal theorem should first be stated in cross-multiplied factorial form. Defining (a_n) by natural-number division before proving exact divisibility would conceal the same logical issue identified above.

---

# Audit B: provenance, literature, and priority

## 1. The central prior-art fact: the existence conjecture follows from Landau

Landau’s multivariate theorem says that a ratio of factorials of homogeneous linear forms is integral for every tuple of nonnegative integers exactly when its associated floor-function sum is nonnegative on the unit cube. Bober states this as Theorem 3.1 on page 7: the factorial ratio is integral “if and only if the step function … is nonnegative.” ([Numdam][3])

For fixed (k\in{1,2,3}) and (r\ge1), introduce a second nonnegative integer (t) and define
[
U_{n,t}
=======

\frac{(8n)!,n!,(kn)!,\big((8r)t\big)!^r}
{(4n)!(3n)!(2n)!(kn+rt)!}.
]

At (t=1),
[
U_{n,1}
=======

\frac{((8r)!)^r a_n}
{(kn+1)(kn+2)\cdots(kn+r)}.
]

The corresponding two-variable Landau function is
[
\begin{aligned}
F(x,y)
&=
\lfloor8x\rfloor+\lfloor x\rfloor+\lfloor kx\rfloor
+r\lfloor8ry\rfloor\
&\quad-\lfloor4x\rfloor-\lfloor3x\rfloor-\lfloor2x\rfloor
-\lfloor kx+ry\rfloor\
&=
\Delta(x)+r\lfloor8ry\rfloor
-\lfloor{kx}+ry\rfloor.
\end{aligned}
]

If (y\ge1/(8r)), then
[
r\lfloor8ry\rfloor\ge r
]
while
[
\lfloor{kx}+ry\rfloor\le r,
]
so (F(x,y)\ge0).

If (0\le y<1/(8r)), then (\lfloor8ry\rfloor=0). The last floor is either zero or one. If it is one, then
[
{kx}+ry\ge1,
\qquad\text{so}\qquad
{kx}>1-\frac18=\frac78.
]

For (x\in[0,1]), the condition ({kx}>7/8) gives:

[
\begin{array}{c|l}
k&{x:{kx}>7/8}\ \hline
1&(7/8,1),\
2&(7/16,1/2)\cup(15/16,1),\
3&(7/24,1/3)\cup(5/8,2/3)\cup(23/24,1).
\end{array}
]

Every one of these intervals lies in the support (I) of (\Delta). Hence (\Delta(x)=1), which pays for the final floor. Therefore
[
F(x,y)\ge0
]
throughout ([0,1]^2).

Landau’s theorem now proves (U_{n,t}\in\mathbb Z) for all (n,t\ge0). Taking (t=1) gives
[
\boxed{
(kn+1)\cdots(kn+r)\mid((8r)!)^r a_n
}.
]

### Classification

* For the **OEIS existence assertion:**
  **DIRECT COROLLARY OF A MORE GENERAL RESULT.**
* For the sharper **(L_r^r) theorem:**
  **SAME METHOD BUT NOT THE RESULT.**

I found no searched source that records this exact two-variable substitution for A211420. Nevertheless, the logical implication from Landau’s theorem is exact; an exact published substitution is not required for the result to be a consequence of the general theorem.

---

## 2. Is it a corollary of Bober’s classification?

Not of Bober’s **classification theorem** itself.

Bober’s Theorem 1.2, page 3, classifies one-dimensional integral factorial ratios with one more denominator factorial than numerator factorials. Its family (8) is
[
\frac{(2an)!(bn)!}
{(an)!(2bn)!((a-b)n)!}.
]
Substituting (a=4,b=1) gives exactly (a_n), proving its integrality. It says nothing directly about dividing (a_n) by affine factors (kn+i). ([arXiv][2])

The larger-constant result comes instead from Bober’s quoted **multivariate Landau theorem**, Theorem 3.1. The (L_r^r) refinement uses additional information:

1. the exact support of this particular (\Delta);
2. the fact that a large prime power can divide at most one of the consecutive factors;
3. the cutoff (p^j\ge8r);
4. an economical allocation of only (r) copies of each small prime power through (L_r^r).

Thus the candidate proof is not merely “set (a=4,b=1) in Bober’s classification.” Its method is standard Landau–Legendre machinery, but its sharp constant argument is additional.

---

# Source-by-source prior-art assessment

## A. Edmund Landau

**Citation.** Edmund Landau, “Sur les conditions de divisibilité d’un produit de factorielles par un autre,” *Nouvelles annales de mathématiques*, 3rd series, 19 (1900), 344–362. NUMDAM identifier `NAM_1900_3_19__344_1`; no modern DOI or arXiv identifier. ([Numdam][3])

**Result.** The multivariate homogeneous-linear-form factorial-ratio criterion, restated as Bober’s Theorem 3.1, page 7.

**Identifying quotation.** “integer … if and only if the step function … is nonnegative.”

**Substitution.** The (U_{n,t}) construction above.

**Classification.**

* **DIRECT COROLLARY OF A MORE GENERAL RESULT** for the OEIS existence conjecture with (C=((8r)!)^r).
* **SAME METHOD BUT NOT THE RESULT** for the sharper (L_r^r) constant.

---

## B. Jonathan W. Bober

**Citation.** Jonathan W. Bober, “Factorial ratios, hypergeometric series, and a family of step functions,” *Journal of the London Mathematical Society* (2) 79(2) (2009), 422–444. DOI `10.1112/jlms/jdn078`; arXiv:0709.1977. ([arXiv][2])

### Theorem 1.2, page 3

**Result.** Complete classification in the height-one case; family (8) contains (a_n).

**Substitution.**
[
a=4,\quad b=1
]
gives
[
\frac{(8n)!n!}{(4n)!(2n)!(3n)!}=a_n.
]

**Classification.** **RELATED BUT INSUFFICIENT.** It establishes integrality of (a_n), not divisibility by ((kn+1)\cdots(kn+r)).

### Theorem 3.1, page 7

**Result.** Bober’s statement of Landau’s multivariate criterion. ([arXiv][2])

**Substitution.** The (U_{n,t}) construction.

**Classification.** **DIRECT COROLLARY OF A MORE GENERAL RESULT** for the larger constant.

---

## C. Fernando Rodriguez-Villegas

**Citation.** Fernando Rodriguez-Villegas, “Integral ratios of factorials and algebraic hypergeometric functions,” arXiv:math/0701362 (2007). An earlier conference-report version appeared in *Oberwolfach Reports* 2 (2005), 1813–1816. ([arXiv][4])

**Result.** For regular factorial-ratio data of dimension one, integrality is equivalent to algebraicity of the associated hypergeometric series. Pages 2–3 also record
[
v_p(u_n)=\sum_{j\ge1}L(n/p^j)
]
and Landau’s nonnegativity criterion. ([arXiv][5])

**Identifying quotation.** “integral if and only if (L(x)\ge0).”

**Substitution.** The factorial vector
[
(8,1;,4,3,2)
]
produces the A211420 hypergeometric series, but the paper supplies no affine-factor or fixed-(C) theorem.

**Classification.** **RELATED BUT INSUFFICIENT.**

---

## D. Zhi-Wei Sun: exact published subcase

**Citation.** Zhi-Wei Sun, “On divisibility of binomial coefficients,” *Journal of the Australian Mathematical Society* 93(1–2) (2012), 189–201. DOI `10.1017/S1446788712000171`. ([SciSpace][6])

**Result.** Theorem 1.3(ii), pages 190–191:
[
\binom{2n}{n}
\mid
(k+1)_0,C_n^{(k-1)}
\binom{2kn}{kn},
]
where ((k+1)_0) is the odd part of (k+1) and
[
C_n^{(h)}=\frac1{hn+1}\binom{(h+1)n}{n}.
]

**Substitution.** Put the paper’s (k=4). Then
[
(k+1)_0=5,\qquad
C_n^{(3)}=\frac1{3n+1}\binom{4n}{n},
]
and hence
[
\binom{2n}{n}
\mid
\frac5{3n+1}\binom{4n}{n}\binom{8n}{4n}.
]
Using
[
a_n=
\frac{\binom{8n}{4n}\binom{4n}{n}}
{\binom{2n}{n}},
]
this is exactly
[
\boxed{\frac{5a_n}{3n+1}\in\mathbb Z}.
]

**Classification.** **RELATED BUT INSUFFICIENT** for the full theorem, but an **exact prior result for the subcase (k=3,r=1)**.

This predates the 2025 OEIS comment by thirteen years.

---

## E. Quan-Hui Yang: closest same-method divisibility result

**Citation.** Quan-Hui Yang, “Proof of a conjecture of Amdeberhan and Moll on a divisibility property of binomial coefficients,” *Electronic Journal of Combinatorics* 22(1) (2015), Paper P1.9, 6 pp. ArXiv version: “Proof of a conjecture related to divisibility properties of binomial coefficients,” arXiv:1401.1108. ([arXiv][7])

**Result.** Theorem 1:
[
(2bn+1)(2bn+3)\binom{2bn}{bn}
\mid
3(a-b)(3a-b)
\binom{2an}{an}\binom{an}{bn}.
]

The proof uses Legendre’s formula and floor-function inequalities, exactly the broad methodological family of the candidate proof. ([arXiv][8])

**Substitution.** Put (a=4,b=1):
[
(2n+1)(2n+3)\binom{2n}{n}
\mid
99\binom{8n}{4n}\binom{4n}{n},
]
so
[
\boxed{(2n+1)(2n+3)\mid99a_n}.
]

This is stronger than the current (k=2,r=1) existence claim, though its second factor is (2n+3), not the consecutive factor (2n+2).

**Classification.** **SAME METHOD BUT NOT THE RESULT.**

It also exactly matches the first constant (99=9\cdot11) in the narrower odd-progression conjecture appearing in the original August 26 OEIS edit. ([OEIS][9])

---

## F. Victor J. W. Guo

**Citation.** Victor J. W. Guo, “Proof of two divisibility properties of binomial coefficients conjectured by Z.-W. Sun,” *Electronic Journal of Combinatorics* 21(2) (2014), Paper P2.54. DOI `10.37236/4258`. ([ECNU Math Department][10])

**Results.** Theorems 1.1–1.3 give divisibility by linear factors such as (2n+3,2n+5,2n+7,2n+9) for the related factorial ratio
[
S_n=
\frac{(6n)!n!}{(3n)!(2n)!^2},
]
up to small fixed constants. The proof explicitly uses
[
v_p(n!)=\sum_i\lfloor n/p^i\rfloor
]
and floor identities conditioned by divisibility of a linear form. ([ECNU Math Department][10])

**Substitution.** There is no parameter substitution turning the factorial vector
[
(6,1;,3,2,2)
]
into
[
(8,1;,4,3,2).
]

**Classification.** **SAME METHOD BUT NOT THE RESULT.**

---

## G. Bell–Bober and Soundararajan

**Citation.** Jason P. Bell and Jonathan W. Bober, “Bounded step functions and factorial ratio sequences,” *International Journal of Number Theory* 5(8) (2009), 1419–1431. DOI `10.1142/S1793042109002742`; arXiv:0710.3459. ([University of Bristol][11])

**Result.** Theorem 1.1 bounds the number of factorial terms in terms of the height of a nonnegative Landau step function. Its identifying conclusion is
[
K+L\ll D^2(\log D)^2.
]
([arXiv][12])

**Substitution.** It applies to structural classification of the factorial ratio (a_n), but contains no affine denominator (kn+i) and no fixed multiplier theorem.

**Classification.** **RELATED BUT INSUFFICIENT.**

**Citation.** K. Soundararajan, “Integral factorial ratios,” *Duke Mathematical Journal* 171(3) (2022), 633–672. DOI `10.1215/00127094-2021-0017`; MR 4383251; arXiv:1901.05133. ([arXiv][13])

**Result.** Theorem 1.1 gives a new proof of the Bober height-one classification and explicitly lists
[
\frac{(2an)!(bn)!}{(an)!(2bn)!((a-b)n)!}
]
as one of the three infinite families. The paper states that known integrality approaches proceed by comparing (p)-adic valuations and lead to Landau’s floor function. ([arXiv][13])

**Substitution.** Again (a=4,b=1) yields (a_n), but no fixed affine-factor denominator is present.

**Classification.** **RELATED BUT INSUFFICIENT.**

---

## H. Hypergeometric valuation and denominator literature

### Franc–Gannon–Mason

**Citation.** Cameron Franc, Terry Gannon, and Geoffrey Mason, “On unbounded denominators and hypergeometric series,” *Journal of Number Theory* 192 (2018), 197–220. DOI `10.1016/j.jnt.2018.04.009`; arXiv:1708.04213; Zbl 1454.11082. ([arXiv][14])

**Result.** Theorem 3.4, page 8, expresses the (p)-adic valuation of a hypergeometric coefficient as a difference of numbers of (p)-adic carries. ([arXiv][15])

**Substitution.** The parameters
[
\left[\frac18,\frac38,\frac58,\frac78\right];
\left[\frac13,\frac12,\frac23\right]
]
fit its general framework, but the theorem does not provide a single multiplier independent of (n) after adjoining the factors (1/(kn+i)).

**Classification.** **SAME METHOD BUT NOT THE RESULT.**

### Adolphson–Sperber

**Citation.** Alan Adolphson and Steven Sperber, “On the integrality of hypergeometric series whose coefficients are factorial ratios,” arXiv:2001.03296.

**Result.** Theorem 7.14, page 16, is another multivariate form of Landau’s criterion:
[
E(m_1,\ldots,m_r)\in\mathbb N
\iff
\Phi(x_1,\ldots,x_r)\ge0.
]
([arXiv][16])

**Substitution.** It supports the same (U_{n,t}) construction as Landau/Bober, but does not identify the (L_r^r) refinement.

**Classification.**

* **DIRECT COROLLARY OF A MORE GENERAL RESULT** for the larger constant;
* **RELATED BUT INSUFFICIENT** for the sharp constant.

### Fürnsinn–Yurkevich and Eisenstein constants

**Citation.** Florian Fürnsinn and Sergey Yurkevich, “Algebraicity of hypergeometric functions with arbitrary parameters,” arXiv:2308.12855.

The A211420 generating function is
[
{}_4F_3!\left[
\begin{matrix}
1/8,3/8,5/8,7/8\
1/3,1/2,2/3
\end{matrix};
\frac{2^{14}}{27}z
\right],
]
as recorded by OEIS. ([OEIS][1])

Moreover,
[
\prod_{i=1}^r
\frac{(i/k)_n}{(1+i/k)_n}
=========================

# \prod_{i=1}^r\frac{i}{kn+i}

\frac{r!}{D_{k,r}(n)}.
]
Hence
[
\sum_{n\ge0}\frac{a_n}{D_{k,r}(n)}z^n
=====================================

\frac1{r!}
{}*{4+r}F*{3+r}!\left[
\begin{matrix}
1/8,3/8,5/8,7/8,1/k,\ldots,r/k\
1/3,1/2,2/3,1+1/k,\ldots,1+r/k
\end{matrix};
\frac{2^{14}}{27}z
\right].
]

Eisenstein/global-boundedness results concern rescaling the argument:
[
f(Mz)\in\mathbb Z[[z]]
]
up to an overall multiplier. This permits coefficient denominators growing like (M^n). It does **not** imply the existence of one constant (C) such that
[
C,a_n/D_{k,r}(n)
]
is integral for every (n). The paper itself presents Christol-type criteria for global boundedness rather than fixed coefficientwise multipliers. ([arXiv][17])

**Classification.** **RELATED BUT INSUFFICIENT.**

---

# Prior-art verdict

## For the OEIS existence conjecture

[
\exists C(k,r)>0\quad
D_{k,r}(n)\mid C(k,r)a_n
\quad\forall n
]

is a **DIRECT COROLLARY OF A MORE GENERAL RESULT**, namely Landau’s multivariate criterion, using
[
C(k,r)=((8r)!)^r.
]

**Confidence:** high.

I found no source that explicitly writes this A211420 substitution, but the implication is mathematically exact.

## For the candidate strengthening

[
D_{k,r}(n)\mid L_r^r a_n
]

**no prior art was found in the searched sources.**

**Confidence:** moderate, approximately (0.80).

This is not proof of originality. Formula indexing is incomplete, older proceedings and theses can be poorly indexed, and some relevant material may be behind subscription databases or in non-searchable scans.

---

# Sources searched and coverage gaps

The search covered:

* the current OEIS entry and its full visible revision history;
* exact searches for `A211420`;
* the factorial ratio in multiple orderings and binomial representations;
* the ({}_4F_3) parameters;
* “rising factorial,” “Pochhammer,” “fixed denominator,” “fixed divisor,” “polynomial divisibility,” and shifted-linear-factor formulations;
* Landau step functions, integral factorial ratios, globally bounded hypergeometric series, G-functions, Eisenstein constants, and (p)-adic valuations;
* arXiv, publisher and DOI pages, NUMDAM, institutional repositories, accessible journal copies, theses/preprint searches, MathOverflow, Mathematics Stack Exchange, and broad web full-text search;
* English, French, German, Russian, Chinese, Japanese, and Korean query variants;
* major papers citing or extending Bober and Rodriguez-Villegas, including Bell–Bober, Soundararajan, Adolphson–Sperber, Franc–Gannon–Mason, and recent hypergeometric-algebraicity work;
* the separate binomial-divisibility literature represented by Sun, Guo, Guo–Krattenthaler, and Yang.

Meaningful gaps remain:

* no complete subscription-level MathSciNet or Zentralblatt citation-graph audit;
* no exhaustive line-by-line examination of every paper citing Bober or Rodriguez-Villegas;
* paywalled books, unindexed proceedings, and older theses may be absent;
* mathematical formula search remains significantly less reliable than ordinary text search;
* non-English and scanned sources may not be machine-indexed.

Accordingly, the negative conclusion is only:

> **No prior art was found in the searched sources for the full (L_r^r) strengthening.**

It is not a certification of originality.

---

# Required final report

## 1. Correctness verdict and confidence

[
\boxed{\textbf{CORRECT AFTER SPECIFIED REPAIRS}}
]

**Confidence:** high.

Required repairs:

1. Treat (v_p(a_n)) initially as a rational valuation.
2. Use (\Delta\ge0) to prove (a_n\in\mathbb Z_{>0}).
3. State that all Legendre and divisor-count sums are finite.
4. Explicitly state
   [
   C(k,r)=L_r^r>0.
   ]

## 2. Prior-art verdict and confidence

* **OEIS existence assertion:** direct corollary of Landau’s multivariate criterion.
  **Confidence:** high.
* **Full (L_r^r) strengthening:** no prior art found in the searched sources.
  **Confidence:** moderate.

## 3. Strongest mathematical objection considered

The proof, as presented, invokes integer divisibility involving (a_n) before explicitly establishing that (a_n) is an integer. This is a genuine logical omission but not a mathematical failure: the preceding (\Delta)-calculation immediately supplies the missing integrality proof.

All more dangerous potential objections—(q=8r), equality at interval endpoints, (n=0), primes dividing (k), repeated prime powers, and the strict LCM cutoff—check out exactly.

## 4. Closest prior result and exact logical mapping

The closest general result is Landau’s multivariate criterion, as stated in Bober’s Theorem 3.1. The exact mapping is
[
U_{n,t}
=======

\frac{(8n)!n!(kn)!((8r)t)!^r}
{(4n)!(3n)!(2n)!(kn+rt)!},
]
whose Landau function is
[
F(x,y)=\Delta(x)+r\lfloor8ry\rfloor-\lfloor{kx}+ry\rfloor\ge0.
]
At (t=1),
[
U_{n,1}
=======

\frac{((8r)!)^r a_n}{D_{k,r}(n)}.
]

The closest exact published overlap is Sun’s 2012 Theorem 1.3(ii), which gives precisely
[
\frac{5a_n}{3n+1}\in\mathbb Z.
]

The closest same-method divisibility result is Yang’s 2015 theorem, which gives
[
(2n+1)(2n+3)\mid99a_n.
]

## 5. Sources searched and meaningful gaps

As detailed above: extensive OEIS, literature, citation-descendant, repository, forum, hypergeometric, factorial-ratio, and multilingual searching; but not an exhaustive subscription-database or unindexed-archive audit.

## 6. Defensible wording

### “This proves the A211420 conjecture.”

**Yes**, after inserting the specified integrality and finiteness sentences.

A precise formulation is:

> For (L_r=\operatorname{lcm}(1,\ldots,8r-1)),
> [
> (kn+1)\cdots(kn+r)\mid L_r^r a_n
> ]
> for all (n\ge0), (r\ge1), and (k\in{1,2,3}). In particular, this proves the positive-constant conjecture recorded in A211420.

### “This is the first proof.”

**No.**

The existence statement is already a direct consequence of Landau’s general theorem, and exact special cases appeared in the literature before the OEIS comment. The strongest defensible priority statement from this audit is:

> **No prior proof of the full (L_r^r) strengthening was found in the searched sources.**

[1]: https://oeis.org/A211420 "https://oeis.org/A211420"
[2]: https://arxiv.org/pdf/0709.1977 "https://arxiv.org/pdf/0709.1977"
[3]: https://www.numdam.org/item/NAM_1900_3_19__344_1/ "https://www.numdam.org/item/NAM_1900_3_19__344_1/"
[4]: https://arxiv.org/abs/math/0701362 "https://arxiv.org/abs/math/0701362"
[5]: https://arxiv.org/pdf/math/0701362 "https://arxiv.org/pdf/math/0701362"
[6]: https://scispace.com/pdf/on-divisibility-of-binomial-coefficients-42vmscjf3i.pdf "https://scispace.com/pdf/on-divisibility-of-binomial-coefficients-42vmscjf3i.pdf"
[7]: https://arxiv.org/abs/1401.1108 "https://arxiv.org/abs/1401.1108"
[8]: https://arxiv.org/pdf/1401.1108 "https://arxiv.org/pdf/1401.1108"
[9]: https://oeis.org/history?seq=A211420&start=10 "https://oeis.org/history?seq=A211420&start=10"
[10]: https://math.ecnu.edu.cn/~jwguo/maths/3bino4.pdf "https://math.ecnu.edu.cn/~jwguo/maths/3bino4.pdf"
[11]: https://research-information.bris.ac.uk/en/publications/bounded-step-functions-and-factorial-ratio-sequences "https://research-information.bris.ac.uk/en/publications/bounded-step-functions-and-factorial-ratio-sequences"
[12]: https://arxiv.org/pdf/0710.3459 "https://arxiv.org/pdf/0710.3459"
[13]: https://arxiv.org/pdf/1901.05133 "https://arxiv.org/pdf/1901.05133"
[14]: https://arxiv.org/abs/1708.04213 "https://arxiv.org/abs/1708.04213"
[15]: https://arxiv.org/pdf/1708.04213 "https://arxiv.org/pdf/1708.04213"
[16]: https://arxiv.org/pdf/2001.03296 "https://arxiv.org/pdf/2001.03296"
[17]: https://arxiv.org/pdf/2308.12855 "https://arxiv.org/pdf/2308.12855"
