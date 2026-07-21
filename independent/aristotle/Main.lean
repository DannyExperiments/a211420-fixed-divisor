import Mathlib

open scoped BigOperators

set_option maxHeartbeats 8000000
set_option maxRecDepth 4000
set_option relaxedAutoImplicit false
set_option autoImplicit false

namespace A211420

/-- Numerator of the factorial ratio. -/
def ANum (n : Nat) : Nat := (8 * n).factorial * n.factorial

/-- Denominator of the factorial ratio. -/
def ADen (n : Nat) : Nat :=
  (4 * n).factorial * (3 * n).factorial * (2 * n).factorial

/-- A product of `r` consecutive integers starting just after `k*n`. -/
def D (k r n : Nat) : Nat :=
  ∏ i ∈ Finset.range r, (k * n + (i + 1))

/-- The least common multiple of exactly `1, ..., 8*r-1`. -/
def L (r : Nat) : Nat :=
  (Finset.range (8 * r - 1)).lcm (fun i => i + 1)

/-
The denominator divides the numerator exactly.
-/
theorem integral_cross (n : Nat) : ADen n ∣ ANum n := by
  -- By definition of $ADen$ and $ANum$, we can write them in terms of factorials.
  have h_def : ADen n = (4 * n).factorial * (3 * n).factorial * (2 * n).factorial ∧ ANum n = (8 * n).factorial * n.factorial := by
    exact ⟨ rfl, rfl ⟩;
  -- Consider the prime factorization of the numerator and denominator.
  have h_factorization : ∀ p : ℕ, Nat.Prime p → (Nat.factorization ((8 * n).factorial * n.factorial)) p ≥ (Nat.factorization ((4 * n).factorial * (3 * n).factorial * (2 * n).factorial)) p := by
    intro p pp; rw [ Nat.factorization_mul, Nat.factorization_mul, Nat.factorization_mul ] <;> first | positivity | simp +decide [ Nat.factorization_mul, Nat.factorial_ne_zero ] ;
    -- By Legendre's formula, we have $v_p((kn)!) = \sum_{i=1}^{\infty} \left\lfloor \frac{kn}{p^i} \right\rfloor$.
    have h_legendre : ∀ k : ℕ, Nat.factorization ((k * n).factorial) p = ∑ i ∈ Finset.Ico 1 (Nat.log p (k * n) + 1), (k * n) / p ^ i := by
      intro k; rw [ Nat.factorization_def ];
      · haveI := Fact.mk pp; rw [ padicValNat_factorial ] ; aesop;
      · assumption;
    -- Applying Legendre's formula to each term, we get:
    have h_apply_legendre : ∀ i ∈ Finset.Ico 1 (Nat.log p (8 * n) + 1), (4 * n / p ^ i) + (3 * n / p ^ i) + (2 * n / p ^ i) ≤ (8 * n / p ^ i) + (n / p ^ i) := by
      intro i hi; rw [ show 8 * n = 4 * n + 4 * n by ring, show 4 * n = 3 * n + n by ring ] ; norm_num [ Nat.add_div ( pow_pos pp.pos _ ) ] ; ring_nf;
      rw [ show n * 2 = n + n by ring, Nat.add_div ( pow_pos pp.pos _ ) ] ; ring_nf;
      split_ifs <;> norm_num at *;
      rw [ show n * 4 = n * 3 + n by ring, Nat.add_mod ] at *;
      rw [ Nat.mul_mod ] at *;
      rcases k : 3 % p ^ i with ( _ | _ | _ | k ) <;> simp_all +arith +decide [ Nat.mod_eq_of_lt ];
      · grind;
      · grind;
      · grind;
      · grind +splitImp;
    -- Summing over all $i$ from $1$ to $\log_p(8n)$, we get the desired inequality.
    have h_sum : ∑ i ∈ Finset.Ico 1 (Nat.log p (8 * n) + 1), (4 * n / p ^ i + 3 * n / p ^ i + 2 * n / p ^ i) ≤ ∑ i ∈ Finset.Ico 1 (Nat.log p (8 * n) + 1), (8 * n / p ^ i + n / p ^ i) := by
      exact Finset.sum_le_sum h_apply_legendre;
    simp_all +decide [ Finset.sum_add_distrib ];
    refine le_trans ?_ ( h_sum.trans ?_ );
    · gcongr <;> norm_num;
    · rw [ Nat.factorization_def ];
      · haveI := Fact.mk pp; rw [ padicValNat_factorial ] ; simp +decide [ Nat.factorization ] ;
        exact Nat.log_mono_right ( by linarith );
      · assumption;
  rw [ h_def.1, h_def.2, ← Nat.factorization_le_iff_dvd ] <;> try positivity;
  exact fun p => if hp : Nat.Prime p then h_factorization p hp else by aesop;

/-- Nonnegativity of the basic factorial-ratio floor surplus on one residue. -/
lemma basic_floor_residue (s q : Nat) (hq : 0 < q) (hs : s < q) :
    (4 * s) / q + (3 * s) / q + (2 * s) / q ≤ (8 * s) / q := by
  have h2 : 2 * s / q < 2 := (Nat.div_lt_iff_lt_mul hq).2 (by omega)
  have h3 : 3 * s / q < 3 := (Nat.div_lt_iff_lt_mul hq).2 (by omega)
  have h4 : 4 * s / q < 4 := (Nat.div_lt_iff_lt_mul hq).2 (by omega)
  have h8 : 8 * s / q < 8 := (Nat.div_lt_iff_lt_mul hq).2 (by omega)
  have lo2 : q * (2 * s / q) ≤ 2 * s := Nat.mul_div_le _ _
  have lo3 : q * (3 * s / q) ≤ 3 * s := Nat.mul_div_le _ _
  have lo4 : q * (4 * s / q) ≤ 4 * s := Nat.mul_div_le _ _
  have lo8 : q * (8 * s / q) ≤ 8 * s := Nat.mul_div_le _ _
  have up2 : 2 * s < (2 * s / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).1 (Nat.lt_succ_self _)
  have up3 : 3 * s < (3 * s / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).1 (Nat.lt_succ_self _)
  have up4 : 4 * s < (4 * s / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).1 (Nat.lt_succ_self _)
  have up8 : 8 * s < (8 * s / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).1 (Nat.lt_succ_self _)
  interval_cases h2v : 2 * s / q <;> interval_cases h3v : 3 * s / q <;>
    interval_cases h4v : 4 * s / q <;> interval_cases h8v : 8 * s / q <;> omega

/-
Large-modulus residue bound, case `k = 1`.
-/
lemma floor_residue_large_one (s r q : Nat) (hr : 0 < r) (hq : 0 < q)
    (hs : s < q) (hlarge : 8 * r ≤ q) :
    (s + r) / q + (4 * s) / q + (3 * s) / q + (2 * s) / q ≤ (8 * s) / q := by
  by_contra h_contra; push_neg at h_contra; (
  -- Since $8r \le q$, we have $(s + r) / q \le 1$.
  have h1 : (s + r) / q ≤ 1 := by
    exact Nat.le_of_lt_succ ( Nat.div_lt_of_lt_mul <| by linarith );
  interval_cases _ : ( s + r ) / q <;> norm_num at *;
  · exact absurd h_contra ( by have := basic_floor_residue s q hq hs; omega );
  · have h2 : 4 * s / q ≤ 3 := by
      exact Nat.le_of_lt_succ ( Nat.div_lt_of_lt_mul <| by linarith )
    have h3 : 3 * s / q ≤ 2 := by
      exact Nat.le_of_lt_succ ( Nat.div_lt_of_lt_mul <| by linarith ) ;
    have h4 : 2 * s / q ≤ 1 := by
      exact Nat.le_of_lt_succ ( Nat.div_lt_of_lt_mul <| by linarith )
    have h5 : 8 * s / q ≤ 7 := by
      omega;
    interval_cases _ : 4 * s / q <;> interval_cases _ : 3 * s / q <;> interval_cases _ : 2 * s / q <;> interval_cases _ : 8 * s / q <;> simp_all +decide only ;
    all_goals rw [ Nat.div_eq_iff ] at * <;> omega;);

/-
Large-modulus residue bound, case `k = 2`.
-/
lemma floor_residue_large_two (s r q : Nat) (hr : 0 < r) (hq : 0 < q)
    (hs : s < q) (hlarge : 8 * r ≤ q) :
    (2 * s + r) / q + (4 * s) / q + (3 * s) / q + (2 * s) / q ≤
      (2 * s) / q + (8 * s) / q := by
  have h_bounds : 2 * s / q ≤ 1 ∧ 3 * s / q ≤ 2 ∧ 4 * s / q ≤ 3 ∧ 8 * s / q ≤ 7 ∧ (2 * s + r) / q ≤ 2 := by
    exact ⟨ Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith, Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith, Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith, Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith, Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith ⟩;
  have := Nat.div_add_mod ( 2 * s + r ) q; have := Nat.mod_lt ( 2 * s + r ) hq; simp_all +arith +decide;
  have := Nat.div_add_mod ( 3 * s ) q; have := Nat.mod_lt ( 3 * s ) hq; have := Nat.div_add_mod ( 4 * s ) q; have := Nat.mod_lt ( 4 * s ) hq; have := Nat.div_add_mod ( 8 * s ) q; have := Nat.mod_lt ( 8 * s ) hq; norm_num at * ;
  rcases h_bounds with ⟨ h₁, h₂, h₃, h₄, h₅ ⟩ ; interval_cases _ : ( 2 * s + r ) / q <;> interval_cases _ : 3 * s / q <;> interval_cases _ : 4 * s / q <;> simp_all +decide only;
  all_goals interval_cases _ : 8 * s / q <;> simp_all +decide only;
  all_goals omega

/-
Large-modulus residue bound, case `k = 3`.
-/
lemma floor_residue_large_three (s r q : Nat) (hr : 0 < r) (hq : 0 < q)
    (hs : s < q) (hlarge : 8 * r ≤ q) :
    (3 * s + r) / q + (4 * s) / q + (3 * s) / q + (2 * s) / q ≤
      (3 * s) / q + (8 * s) / q := by
  simp +arith +decide [ add_assoc ] at *;
  have h_bound : (3 * s + r) / q ≤ 3 ∧ 2 * s / q ≤ 1 ∧ 4 * s / q ≤ 3 := by
    exact ⟨ Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith, Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith, Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by linarith ⟩;
  rcases h_bound with ⟨ h₁, h₂, h₃ ⟩ ; interval_cases _ : ( 3 * s + r ) / q <;> interval_cases _ : 2 * s / q <;> interval_cases _ : 4 * s / q <;> simp_all +decide only ;
  all_goals rw [ Nat.le_div_iff_mul_le hq ] ; norm_num;
  all_goals rw [ Nat.div_eq_iff ] at * <;> omega;

/-
The symbolic residue calculation underlying the floor inequality.
-/
lemma floor_residue_bound (s r k q : Nat) (hr : 0 < r) (hq : 0 < q) (hs : s < q)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    (k * s + r) / q + (4 * s) / q + (3 * s) / q + (2 * s) / q ≤
      (k * s) / q + r * (if q < 8 * r then 1 else 0) + (8 * s) / q := by
  rcases hk with ( rfl | rfl | rfl );
  · split_ifs <;> norm_num at *;
    · -- Apply the basic_floor_residue lemma to the terms involving $s$.
      have h_basic : (4 * s) / q + (3 * s) / q + (2 * s) / q ≤ (8 * s) / q := by
        convert basic_floor_residue s q hq hs using 1;
      linarith [ show ( s + r ) / q ≤ s / q + r by exact Nat.le_of_lt_succ <| Nat.div_lt_of_lt_mul <| by nlinarith [ Nat.div_add_mod s q, Nat.mod_lt s hq ] ];
    · convert floor_residue_large_one s r q hr hq hs ‹_› using 1 ; ring;
      rw [ Nat.div_eq_of_lt hs, zero_add ];
  · split_ifs;
    · have := basic_floor_residue s q hq hs;
      nlinarith [ Nat.div_mul_le_self ( 2 * s + r ) q, Nat.div_add_mod ( 2 * s ) q, Nat.mod_lt ( 2 * s ) hq ];
    · convert floor_residue_large_two s r q hr hq hs ( by linarith ) using 1;
  · split_ifs;
    · have h_ineq : (3 * s + r) / q ≤ (3 * s) / q + r := by
        exact Nat.le_of_lt_succ ( Nat.div_lt_of_lt_mul <| by nlinarith [ Nat.div_add_mod ( 3 * s ) q, Nat.mod_lt ( 3 * s ) hq ] );
      linarith [ basic_floor_residue s q hq hs ];
    · convert floor_residue_large_three s r q hr hq hs ( by linarith ) using 1

/-
The pointwise floor inequality underlying the prime-power argument.
-/
lemma floor_step_bound (n r k q : Nat) (hr : 0 < r) (hq : 0 < q)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    (k * n + r) / q + (4 * n) / q + (3 * n) / q + (2 * n) / q ≤
      (k * n) / q + r * (if q < 8 * r then 1 else 0) +
        (8 * n) / q + n / q := by
  obtain ⟨s, t, hs, ht⟩ : ∃ s t : ℕ, s < q ∧ n = q * t + s := by
    exact ⟨ n % q, n / q, Nat.mod_lt _ hq, by rw [ Nat.div_add_mod ] ⟩;
  -- Rewrite each term using `Nat.mod_add_div` and `Nat.add_mul_div_left`:
  have h_rewrite : (k * n + r) / q = k * t + (k * s + r) / q ∧ (4 * n) / q = 4 * t + (4 * s) / q ∧ (3 * n) / q = 3 * t + (3 * s) / q ∧ (2 * n) / q = 2 * t + (2 * s) / q ∧ (8 * n) / q = 8 * t + (8 * s) / q ∧ n / q = t + s / q := by
    simp +decide [ *, Nat.add_div, Nat.mul_div_assoc, Nat.mul_mod, Nat.mul_add, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm ];
    norm_num [ Nat.add_mod, Nat.mul_mod, Nat.mod_lt _ hq ];
  have := floor_residue_bound s r k q hr hq hs hk; simp_all +decide [ mul_add, add_assoc ] ;
  grind

/-
Prime-valuation summation of `floor_step_bound` for factorials and the lcm.
-/
lemma factorial_interval_cross (n r k : Nat) (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    (k * n + r).factorial * (4 * n).factorial *
        (3 * n).factorial * (2 * n).factorial ∣
      (L r) ^ r * (k * n).factorial * (8 * n).factorial * n.factorial := by
  -- By the properties of prime factorization, it suffices to show that for every prime $p$, the $p$-adic valuation of the left-hand side is less than or equal to the $p$-adic valuation of the right-hand side.
  suffices h_suff : ∀ p : ℕ, Nat.Prime p → (Nat.factorization ((Nat.factorial (k * n + r)) * (Nat.factorial (4 * n)) * (Nat.factorial (3 * n)) * (Nat.factorial (2 * n)))) p ≤ (Nat.factorization ((L r) ^ r * (Nat.factorial (k * n)) * (Nat.factorial (8 * n)) * (Nat.factorial n))) p by
    rw [ ← Nat.factorization_le_iff_dvd ] <;> try positivity;
    · exact fun p => if hp : Nat.Prime p then h_suff p hp else by aesop;
    · exact mul_ne_zero ( mul_ne_zero ( mul_ne_zero ( pow_ne_zero _ ( Nat.ne_of_gt ( Nat.pos_of_ne_zero ( mt Finset.lcm_eq_zero_iff.mp ( by aesop ) ) ) ) ) ( Nat.factorial_ne_zero _ ) ) ( Nat.factorial_ne_zero _ ) ) ( Nat.factorial_ne_zero _ );
  intro p hp; simp +decide [ Nat.factorization_mul, Nat.factorial_ne_zero, hp ] ;
  -- By Legendre's formula, we can express the $p$-adic valuation of each factorial in terms of sums of floor functions.
  have h_legendre : ∀ m : ℕ, (Nat.factorization (Nat.factorial m)) p = ∑ j ∈ Finset.Ico 1 (Nat.log p m + 1), (m / p ^ j) := by
    intro m; rw [ Nat.factorization_def ];
    · haveI := Fact.mk hp; rw [ padicValNat_factorial ] ; aesop;
    · assumption;
  -- Applying the floor_step_bound to each term in the sum, we get:
  have h_sum_floor_step_bound : ∑ j ∈ Finset.Ico 1 (Nat.log p (max (k * n + r) (8 * n)) + 1), ((k * n + r) / p ^ j + (4 * n) / p ^ j + (3 * n) / p ^ j + (2 * n) / p ^ j) ≤ ∑ j ∈ Finset.Ico 1 (Nat.log p (max (k * n + r) (8 * n)) + 1), ((k * n) / p ^ j + (8 * n) / p ^ j + n / p ^ j + if p ^ j < 8 * r then r else 0) := by
    refine Finset.sum_le_sum fun j hj => ?_;
    convert floor_step_bound n r k ( p ^ j ) hr ( pow_pos hp.pos j ) hk using 1 ; ring;
    split_ifs <;> ring;
  -- The term $\sum_{j=1}^{\infty} \left\lfloor \frac{r}{p^j} \right\rfloor$ is bounded by the sum of the floor functions of $r$ divided by powers of $p$, which is at most $r \cdot \text{factorization}(L(r))_p$.
  have h_bound : ∑ j ∈ Finset.Ico 1 (Nat.log p (max (k * n + r) (8 * n)) + 1), (if p ^ j < 8 * r then r else 0) ≤ r * (Nat.factorization (L r)) p := by
    -- The term $\sum_{j=1}^{\infty} \left\lfloor \frac{r}{p^j} \right\rfloor$ is bounded by the sum of the floor functions of $r$ divided by powers of $p$, which is at most $r \cdot \text{factorization}(L(r))_p$. This follows from the definition of $L(r)$.
    have h_bound : ∑ j ∈ Finset.Ico 1 (Nat.log p (max (k * n + r) (8 * n)) + 1), (if p ^ j < 8 * r then 1 else 0) ≤ (Nat.factorization (L r)) p := by
      -- The term $\sum_{j=1}^{\infty} \left\lfloor \frac{r}{p^j} \right\rfloor$ is bounded by the $p$-adic valuation of $L(r)$, which is the maximum $j$ such that $p^j \leq 8r-1$.
      have h_bound : (Nat.factorization (L r)) p ≥ Nat.log p (8 * r - 1) := by
        have h_bound : p ^ Nat.log p (8 * r - 1) ∣ L r := by
          have h_bound : p ^ Nat.log p (8 * r - 1) ≤ 8 * r - 1 := by
            exact Nat.pow_log_le_self p ( Nat.sub_ne_zero_of_lt ( by linarith ) );
          exact Finset.dvd_lcm ( Finset.mem_range.mpr ( show p ^ Nat.log p ( 8 * r - 1 ) - 1 < 8 * r - 1 from lt_of_lt_of_le ( Nat.sub_lt ( pow_pos hp.pos _ ) zero_lt_one ) h_bound ) ) |> fun x => dvd_trans ( by simp +decide [ Nat.sub_add_cancel ( Nat.one_le_pow _ _ hp.pos ) ] ) x;
        rw [ ← Nat.factorization_le_iff_dvd ] at h_bound <;> norm_num at *;
        · simpa [ hp ] using h_bound p;
        · aesop;
        · exact Nat.ne_of_gt <| Nat.pos_of_ne_zero <| mt Finset.lcm_eq_zero_iff.mp <| by aesop;
      simp +zetaDelta at *;
      refine' le_trans _ h_bound;
      refine' le_trans ( Finset.card_le_card _ ) _;
      exact Finset.Ico 1 ( Nat.log p ( 8 * r - 1 ) + 1 );
      · intro x hx; simp_all +decide [ Finset.subset_iff ] ;
        exact Nat.le_log_of_pow_le hp.one_lt ( Nat.le_sub_one_of_lt hx.2 );
      · simp +arith +decide;
    simpa [ mul_comm, Finset.sum_ite ] using Nat.mul_le_mul_left r h_bound;
  rw [ Nat.factorization_mul, Nat.factorization_mul, Nat.factorization_mul ] <;> simp_all +decide [ Nat.factorial_ne_zero ];
  · simp_all +decide [ Finset.sum_add_distrib ];
    refine le_trans ?_ ( h_sum_floor_step_bound.trans ?_ );
    · gcongr <;> norm_num;
      · grind;
      · exact Or.inr ( by linarith );
      · exact Or.inr ( by linarith );
    · rw [ add_comm ];
      rw [ add_assoc, add_assoc ];
      rw [ add_assoc ];
      refine add_le_add h_bound ?_;
      rw [ ← Finset.sum_subset ( Finset.Ico_subset_Ico_right ( Nat.succ_le_succ ( Nat.log_mono_right ( show k * n ≤ max ( k * n + r ) ( 8 * n ) by exact le_max_of_le_left ( Nat.le_add_right _ _ ) ) ) ) ), ← Finset.sum_subset ( Finset.Ico_subset_Ico_right ( Nat.succ_le_succ ( Nat.log_mono_right ( show 8 * n ≤ max ( k * n + r ) ( 8 * n ) by exact le_max_right _ _ ) ) ) ), ← Finset.sum_subset ( Finset.Ico_subset_Ico_right ( Nat.succ_le_succ ( Nat.log_mono_right ( show n ≤ max ( k * n + r ) ( 8 * n ) by exact le_max_of_le_right ( by linarith ) ) ) ) ) ] <;> simp +decide [ Finset.sum_Ico_eq_sum_range ]; all_goals exact fun x hx₁ hx₂ hx₃ => Or.inr <| Nat.lt_pow_of_log_lt hp.one_lt <| hx₃ hx₁;
  · exact fun h => absurd h <| ne_of_gt <| Nat.pos_of_ne_zero <| mt Finset.lcm_eq_zero_iff.mp <| by aesop;
  · exact fun h => absurd h <| ne_of_gt <| Nat.pos_of_ne_zero <| mt Finset.lcm_eq_zero_iff.mp <| by aesop;
  · exact fun h => absurd h <| ne_of_gt <| Nat.pos_of_ne_zero <| mt Finset.lcm_eq_zero_iff.mp <| by aesop;

/-
The primary, cross-multiplied divisibility theorem.
-/
theorem strengthened_cross (n r k : Nat) (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    D k r n * ADen n ∣ (L r) ^ r * ANum n := by
  obtain ⟨ m, hm ⟩ := factorial_interval_cross n r k hr hk;
  -- By definition of $D$, we know that $(k * n + r)! = (k * n)! * D k r n$.
  have hD : (k * n + r).factorial = (k * n).factorial * D k r n := by
    exact Nat.recOn r ( by norm_num [ D ] ) fun n ihn => by rw [ Nat.add_succ, Nat.factorial_succ, Nat.mul_comm ] ; simp +decide [ *, D, Finset.prod_range_succ ] ; ring;
  exact ⟨ m, by rw [ show ADen n = ( 4 * n ).factorial * ( 3 * n ).factorial * ( 2 * n ).factorial by rfl, show ANum n = ( 8 * n ).factorial * n.factorial by rfl ] ; rw [ hD ] at hm; nlinarith [ Nat.factorial_pos ( k * n ) ] ⟩

/-
The constant occurring in `strengthened_cross` is positive.
-/
theorem constant_pos (r : Nat) (hr : 0 < r) : 0 < (L r) ^ r := by
  exact pow_pos ( Nat.pos_of_ne_zero ( mt Finset.lcm_eq_zero_iff.mp ( by aesop ) ) ) _

/-- The integral factorial ratio, defined only after exactness has been proved. -/
def a (n : Nat) : Nat := ANum n / ADen n

/-
The quotient form, derived from the cross-multiplied theorem.
-/
theorem strengthened (n r k : Nat) (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    D k r n ∣ (L r) ^ r * a n := by
  convert Nat.dvd_div_of_mul_dvd _ using 1;
  rotate_left;
  exact ADen n;
  exact L r ^ r * ANum n;
  · convert strengthened_cross n r k hr hk using 1 ; ring;
  · rw [ Nat.mul_div_assoc _ ( integral_cross n ), show a n = ANum n / ADen n from rfl ]

end A211420