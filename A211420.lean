import Mathlib

open scoped BigOperators

namespace A211420

open Nat Finset

/-- The numerator `(8n)! n!` of the factorial ratio. -/
def ANum (n : ℕ) : ℕ :=
  (8 * n).factorial * n.factorial

/-- The denominator `(4n)! (3n)! (2n)!` of the factorial ratio. -/
def ADen (n : ℕ) : ℕ :=
  (4 * n).factorial * (3 * n).factorial * (2 * n).factorial

/-- The product of the `r` consecutive terms `kn+1, ..., kn+r`. -/
def D (k r n : ℕ) : ℕ :=
  ∏ i ∈ Finset.range r, (k * n + (i + 1))

/-- The least common multiple of exactly `1, ..., 8r-1`. -/
def L (r : ℕ) : ℕ :=
  Nat.lcmUpto (8 * r - 1)

/-- The nonnegative Landau contribution at denominator `q`. -/
def landau (n q : ℕ) : ℕ :=
  (8 * n) / q + n / q - ((4 * n) / q + (3 * n) / q + (2 * n) / q)

private theorem mul_div_decompose (c n q : ℕ) (hq : 0 < q) :
    (c * n) / q = c * (n / q) + (c * (n % q)) / q := by
  have hn : n = q * (n / q) + n % q := (Nat.div_add_mod n q).symm
  calc
    (c * n) / q = (c * (q * (n / q) + n % q)) / q :=
      congrArg (fun t ↦ t / q) (congrArg (fun t ↦ c * t) hn)
    _ = (q * (c * (n / q)) + c * (n % q)) / q := by
      congr 1
      ring
    _ = c * (n / q) + (c * (n % q)) / q :=
      Nat.mul_add_div hq (c * (n / q)) (c * (n % q))

private theorem two_mul_div_of_lt {x q : ℕ} (hx : x < q) :
    (2 * x) / q = if q ≤ 2 * x then 1 else 0 := by
  split_ifs with h
  · exact Nat.div_eq_of_lt_le (by omega) (by omega)
  · exact Nat.div_eq_of_lt (by omega)

private theorem three_mul_div_of_lt {x q : ℕ} (hx : x < q) :
    (3 * x) / q = if 2 * q ≤ 3 * x then 2 else if q ≤ 3 * x then 1 else 0 := by
  split_ifs with h₂ h₁
  · exact Nat.div_eq_of_lt_le (by omega) (by omega)
  · exact Nat.div_eq_of_lt_le (by omega) (by omega)
  · exact Nat.div_eq_of_lt (by omega)

private theorem four_mul_div_of_lt {x q : ℕ} (hx : x < q) :
    (4 * x) / q =
      if 3 * q ≤ 4 * x then 3 else if 2 * q ≤ 4 * x then 2 else
        if q ≤ 4 * x then 1 else 0 := by
  split_ifs with h₃ h₂ h₁
  · exact Nat.div_eq_of_lt_le (by omega) (by omega)
  · exact Nat.div_eq_of_lt_le (by omega) (by omega)
  · exact Nat.div_eq_of_lt_le (by omega) (by omega)
  · exact Nat.div_eq_of_lt (by omega)

private theorem floor_balance {x q : ℕ} (hq : 0 < q) (hx : x < q) :
    (4 * x) / q + (3 * x) / q + (2 * x) / q ≤ (8 * x) / q := by
  rw [Nat.le_div_iff_mul_le hq, two_mul_div_of_lt hx, three_mul_div_of_lt hx,
    four_mul_div_of_lt hx]
  split_ifs <;> omega

/-- The four exact support intervals, expressed without rational arithmetic. -/
def InLandauSupport (x q : ℕ) : Prop :=
  (q ≤ 8 * x ∧ 3 * x < q) ∨
  (3 * q ≤ 8 * x ∧ 2 * x < q) ∨
  (5 * q ≤ 8 * x ∧ 3 * x < 2 * q) ∨
  (7 * q ≤ 8 * x ∧ x < q)

private theorem floor_strict_on_support {x q : ℕ} (hq : 0 < q)
    (hs : InLandauSupport x q) :
    (4 * x) / q + (3 * x) / q + (2 * x) / q + 1 ≤ (8 * x) / q := by
  have hx : x < q := by rcases hs with h | h | h | h <;> omega
  rw [Nat.le_div_iff_mul_le hq, two_mul_div_of_lt hx, three_mul_div_of_lt hx,
    four_mul_div_of_lt hx]
  rcases hs with h | h | h | h <;> split_ifs <;> omega

theorem landau_balance (n q : ℕ) (hq : 0 < q) :
    (4 * n) / q + (3 * n) / q + (2 * n) / q ≤ (8 * n) / q + n / q := by
  have hx : n % q < q := Nat.mod_lt n hq
  have hbase := floor_balance hq hx
  rw [mul_div_decompose 4 n q hq, mul_div_decompose 3 n q hq,
    mul_div_decompose 2 n q hq, mul_div_decompose 8 n q hq]
  omega

theorem landau_add_den (n q : ℕ) (hq : 0 < q) :
    landau n q + ((4 * n) / q + (3 * n) / q + (2 * n) / q) =
      (8 * n) / q + n / q := by
  rw [landau, Nat.sub_add_cancel (landau_balance n q hq)]

theorem landau_pos_of_support (n q : ℕ) (hq : 0 < q)
    (hs : InLandauSupport (n % q) q) : 0 < landau n q := by
  have hstrict := floor_strict_on_support hq hs
  have hx : n % q < q := Nat.mod_lt n hq
  rw [landau, mul_div_decompose 4 n q hq, mul_div_decompose 3 n q hq,
    mul_div_decompose 2 n q hq, mul_div_decompose 8 n q hq]
  omega

private theorem dvd_remainder_factor {k n i q : ℕ} (h : q ∣ k * n + i) :
    q ∣ k * (n % q) + i := by
  rw [Nat.dvd_iff_mod_eq_zero] at h ⊢
  simpa [Nat.add_mod, Nat.mul_mod] using h

theorem support_of_large_dvd {n r k i q : ℕ} (hr : 0 < r)
    (hi₁ : 0 < i) (hir : i ≤ r) (hk : k = 1 ∨ k = 2 ∨ k = 3)
    (hq : 8 * r ≤ q) (hd : q ∣ k * n + i) :
    InLandauSupport (n % q) q := by
  have hqpos : 0 < q := by omega
  have hx : n % q < q := Nat.mod_lt n hqpos
  have hiq : 8 * i ≤ q := by omega
  rcases hk with rfl | rfl | rfl
  · have hd' : q ∣ 1 * (n % q) + i := dvd_remainder_factor hd
    have hypos : 0 < 1 * (n % q) + i := by omega
    have hqy : q ≤ 1 * (n % q) + i := Nat.le_of_dvd hypos hd'
    have hylt : 1 * (n % q) + i < 2 * q := by omega
    have hm := Nat.mul_div_cancel' hd'
    have hmpos : 0 < (1 * (n % q) + i) / q := Nat.div_pos hqy hqpos
    have hmlt : (1 * (n % q) + i) / q < 2 :=
      (Nat.div_lt_iff_lt_mul hqpos).2 hylt
    have hcase : (1 * (n % q) + i) / q = 1 := by omega
    unfold InLandauSupport
    omega
  · have hd' : q ∣ 2 * (n % q) + i := dvd_remainder_factor hd
    have hypos : 0 < 2 * (n % q) + i := by omega
    have hqy : q ≤ 2 * (n % q) + i := Nat.le_of_dvd hypos hd'
    have hylt : 2 * (n % q) + i < 3 * q := by omega
    have hm := Nat.mul_div_cancel' hd'
    have hmpos : 0 < (2 * (n % q) + i) / q := Nat.div_pos hqy hqpos
    have hmlt : (2 * (n % q) + i) / q < 3 :=
      (Nat.div_lt_iff_lt_mul hqpos).2 hylt
    interval_cases hcase : (2 * (n % q) + i) / q <;>
      (unfold InLandauSupport; omega)
  · have hd' : q ∣ 3 * (n % q) + i := dvd_remainder_factor hd
    have hypos : 0 < 3 * (n % q) + i := by omega
    have hqy : q ≤ 3 * (n % q) + i := Nat.le_of_dvd hypos hd'
    have hylt : 3 * (n % q) + i < 4 * q := by omega
    have hm := Nat.mul_div_cancel' hd'
    have hmpos : 0 < (3 * (n % q) + i) / q := Nat.div_pos hqy hqpos
    have hmlt : (3 * (n % q) + i) / q < 4 :=
      (Nat.div_lt_iff_lt_mul hqpos).2 hylt
    interval_cases hcase : (3 * (n % q) + i) / q <;>
      (unfold InLandauSupport; omega)

private theorem factorial_log_bound (p c n : ℕ) (hc : c ≤ 8) :
    Nat.log p (c * n) < 8 * n + 1 := by
  calc
    Nat.log p (c * n) ≤ c * n := Nat.log_le_self _ _
    _ ≤ 8 * n := Nat.mul_le_mul_right n hc
    _ < 8 * n + 1 := Nat.lt_succ_self _

private theorem ANum_ne_zero (n : ℕ) : ANum n ≠ 0 := by
  simp [ANum, Nat.factorial_ne_zero]

private theorem ADen_ne_zero (n : ℕ) : ADen n ≠ 0 := by
  simp [ADen, Nat.factorial_ne_zero]

/-- Legendre's formula, arranged to display the pointwise Landau surplus. -/
theorem factorization_ANum_eq_ADen_add_landau (n p b : ℕ) (hp : p.Prime)
    (hb : 8 * n < b) :
    (ANum n).factorization p = (ADen n).factorization p +
      ∑ j ∈ Finset.Ico 1 b, landau n (p ^ j) := by
  have hpj (j : ℕ) : 0 < p ^ j := pow_pos hp.pos _
  have h8 : Nat.log p (8 * n) < b := (Nat.log_le_self _ _).trans_lt hb
  have h4 : Nat.log p (4 * n) < b :=
    (Nat.log_le_self _ _).trans_lt (lt_of_le_of_lt (by omega) hb)
  have h3 : Nat.log p (3 * n) < b :=
    (Nat.log_le_self _ _).trans_lt (lt_of_le_of_lt (by omega) hb)
  have h2 : Nat.log p (2 * n) < b :=
    (Nat.log_le_self _ _).trans_lt (lt_of_le_of_lt (by omega) hb)
  have h1' : Nat.log p n < b :=
    (Nat.log_le_self _ _).trans_lt (lt_of_le_of_lt (by omega) hb)
  simp only [ANum, ADen]
  rw [Nat.factorization_mul (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _),
    Nat.factorization_mul (mul_ne_zero (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _))
      (Nat.factorial_ne_zero _),
    Nat.factorization_mul (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _)]
  simp only [Finsupp.coe_add, Pi.add_apply]
  rw [Nat.factorization_factorial hp h8, Nat.factorization_factorial hp h1',
    Nat.factorization_factorial hp h4, Nat.factorization_factorial hp h3,
    Nat.factorization_factorial hp h2]
  calc
    (∑ j ∈ Ico 1 b, 8 * n / p ^ j) +
        ∑ j ∈ Ico 1 b, n / p ^ j =
      ∑ j ∈ Ico 1 b, (8 * n / p ^ j + n / p ^ j) := by
        simp only [Finset.sum_add_distrib]
    _ = ∑ j ∈ Ico 1 b,
        (landau n (p ^ j) + (4 * n / p ^ j + 3 * n / p ^ j + 2 * n / p ^ j)) := by
      apply Finset.sum_congr rfl
      intro j hj
      exact (landau_add_den n (p ^ j) (hpj j)).symm
    _ = (((∑ j ∈ Ico 1 b, 4 * n / p ^ j) +
          (∑ j ∈ Ico 1 b, 3 * n / p ^ j)) +
          (∑ j ∈ Ico 1 b, 2 * n / p ^ j)) +
          (∑ j ∈ Ico 1 b, landau n (p ^ j)) := by
      simp only [Finset.sum_add_distrib]
      omega

/-- Exactness of the factorial quotient, proved before introducing division. -/
theorem integral_cross (n : ℕ) : ADen n ∣ ANum n := by
  apply (Nat.factorization_prime_le_iff_dvd (ADen_ne_zero n) (ANum_ne_zero n)).mp
  intro p hp
  rw [factorization_ANum_eq_ADen_add_landau n p (8 * n + 1) hp (by omega)]
  exact Nat.le_add_right _ _

/-- Number of factors in `D k r n` divisible by a given prime power. -/
def powerCount (q k r n : ℕ) : ℕ :=
  ((Finset.range r).filter fun i ↦ q ∣ k * n + (i + 1)).card

private theorem D_ne_zero (k r n : ℕ) : D k r n ≠ 0 := by
  unfold D
  apply Finset.prod_ne_zero_iff.mpr
  intro i hi
  omega

private theorem powerCount_le_r (q k r n : ℕ) : powerCount q k r n ≤ r := by
  unfold powerCount
  calc
    ((Finset.range r).filter fun i ↦ q ∣ k * n + (i + 1)).card ≤
        (Finset.range r).card := Finset.card_le_card (Finset.filter_subset _ _)
    _ = r := Finset.card_range r

private theorem powerCount_le_one {q k r n : ℕ} (hqr : r < q) :
    powerCount q k r n ≤ 1 := by
  rw [powerCount, Finset.card_le_one]
  intro a ha b hb
  simp only [Finset.mem_filter, Finset.mem_range] at ha hb
  rcases ha with ⟨ha, hda⟩
  rcases hb with ⟨hb, hdb⟩
  rcases le_total a b with hab | hba
  · have hsub := Nat.dvd_sub hdb hda
    have heq : (k * n + (b + 1)) - (k * n + (a + 1)) = b - a := by omega
    rw [heq] at hsub
    by_contra hne
    have hpos : 0 < b - a := by omega
    have hle := Nat.le_of_dvd hpos hsub
    omega
  · have hsub := Nat.dvd_sub hda hdb
    have heq : (k * n + (a + 1)) - (k * n + (b + 1)) = a - b := by omega
    rw [heq] at hsub
    by_contra hne
    have hpos : 0 < a - b := by omega
    have hle := Nat.le_of_dvd hpos hsub
    omega

private theorem powerCount_le_landau_of_large {q k r n : ℕ} (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) (hq : 8 * r ≤ q) :
    powerCount q k r n ≤ landau n q := by
  have hone : powerCount q k r n ≤ 1 := powerCount_le_one (by omega)
  by_cases hz : powerCount q k r n = 0
  · simp [hz]
  · have hcard : 0 < powerCount q k r n := Nat.pos_of_ne_zero hz
    rw [powerCount, Finset.card_pos] at hcard
    rcases hcard with ⟨j, hj⟩
    simp only [Finset.mem_filter, Finset.mem_range] at hj
    rcases hj with ⟨hjr, hd⟩
    have hs := support_of_large_dvd hr (i := j + 1) (by omega) (by omega) hk hq hd
    have hlandau : 1 ≤ landau n q := (landau_pos_of_support n q (by omega) hs)
    exact hone.trans hlandau

private def exponentBound (n r k : ℕ) : ℕ :=
  8 * n + k * n + r + 2

private theorem factorization_D_eq_sum_powerCount (n r k p : ℕ) (hp : p.Prime) :
    (D k r n).factorization p =
      ∑ j ∈ Finset.Ico 1 (exponentBound n r k), powerCount (p ^ j) k r n := by
  classical
  have hfactor (i : ℕ) (hi : i ∈ Finset.range r) : k * n + (i + 1) ≠ 0 := by
    simp only [Finset.mem_range] at hi
    omega
  rw [D, Nat.factorization_prod_apply hfactor]
  calc
    (∑ i ∈ Finset.range r, (k * n + (i + 1)).factorization p) =
        ∑ i ∈ Finset.range r,
          {j ∈ Finset.Ico 1 (exponentBound n r k) | p ^ j ∣ k * n + (i + 1)}.card := by
      apply Finset.sum_congr rfl
      intro i hi
      apply Nat.factorization_eq_card_pow_dvd_of_lt hp (by omega)
      have hi' : i < r := Finset.mem_range.mp hi
      calc
        k * n + (i + 1) < exponentBound n r k := by
          unfold exponentBound
          omega
        _ < p ^ exponentBound n r k := Nat.lt_pow_self hp.one_lt
    _ = ∑ i ∈ Finset.range r, ∑ j ∈ Finset.Ico 1 (exponentBound n r k),
        if p ^ j ∣ k * n + (i + 1) then 1 else 0 := by
      apply Finset.sum_congr rfl
      intro i hi
      exact (Finset.sum_boole (R := ℕ) (fun j ↦ p ^ j ∣ k * n + (i + 1)) _).symm
    _ = ∑ j ∈ Finset.Ico 1 (exponentBound n r k), ∑ i ∈ Finset.range r,
        if p ^ j ∣ k * n + (i + 1) then 1 else 0 := Finset.sum_comm
    _ = ∑ j ∈ Finset.Ico 1 (exponentBound n r k), powerCount (p ^ j) k r n := by
      apply Finset.sum_congr rfl
      intro j hj
      unfold powerCount
      exact Finset.sum_boole (R := ℕ) (fun i ↦ p ^ j ∣ k * n + (i + 1)) _

private theorem small_exponent_sum_le (b t r : ℕ) :
    (∑ j ∈ Finset.Ico 1 b, if j ≤ t then r else 0) ≤ r * t := by
  classical
  let s := (Finset.Ico 1 b).filter fun j ↦ j ≤ t
  have hs : s ⊆ Finset.Ico 1 (t + 1) := by
    intro j hj
    simp [s] at hj ⊢
    omega
  have hcard : s.card ≤ t := by
    calc
      s.card ≤ (Finset.Ico 1 (t + 1)).card := Finset.card_le_card hs
      _ = t := by simp [Nat.card_Ico]
  calc
    (∑ j ∈ Finset.Ico 1 b, if j ≤ t then r else 0) = ∑ j ∈ s, r := by
      exact (Finset.sum_filter (fun j ↦ j ≤ t) (fun _ ↦ r)).symm
    _ = s.card * r := by simp
    _ ≤ t * r := Nat.mul_le_mul_right r hcard
    _ = r * t := Nat.mul_comm _ _

private theorem factorization_D_bound (n r k p : ℕ) (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) (hp : p.Prime) :
    (D k r n).factorization p ≤ r * (L r).factorization p +
      ∑ j ∈ Finset.Ico 1 (exponentBound n r k), landau n (p ^ j) := by
  rw [factorization_D_eq_sum_powerCount n r k p hp]
  let t := Nat.log p (8 * r - 1)
  calc
    (∑ j ∈ Ico 1 (exponentBound n r k), powerCount (p ^ j) k r n) ≤
        ∑ j ∈ Ico 1 (exponentBound n r k),
          ((if j ≤ t then r else 0) + landau n (p ^ j)) := by
      apply Finset.sum_le_sum
      intro j hj
      split_ifs with hjt
      · exact (powerCount_le_r (p ^ j) k r n).trans (Nat.le_add_right _ _)
      · have hpow : 8 * r - 1 < p ^ j :=
          Nat.lt_pow_of_log_lt hp.one_lt (by simpa [t] using hjt)
        have hq : 8 * r ≤ p ^ j := by omega
        simpa using powerCount_le_landau_of_large hr hk hq
    _ = (∑ j ∈ Ico 1 (exponentBound n r k), if j ≤ t then r else 0) +
        ∑ j ∈ Ico 1 (exponentBound n r k), landau n (p ^ j) := by
      simp only [Finset.sum_add_distrib]
    _ ≤ r * t + ∑ j ∈ Ico 1 (exponentBound n r k), landau n (p ^ j) :=
      Nat.add_le_add_right (small_exponent_sum_le (exponentBound n r k) t r) _
    _ = r * (L r).factorization p +
        ∑ j ∈ Ico 1 (exponentBound n r k), landau n (p ^ j) := by
      rw [L, Nat.factorization_lcmUpto (8 * r - 1) hp]

/-- Mandatory strengthened theorem in division-free form. -/
theorem strengthened_cross (n r k : ℕ) (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    D k r n * ADen n ∣ (L r) ^ r * ANum n := by
  have hL : L r ≠ 0 := by simp [L, Nat.lcmUpto_ne_zero]
  have hleft : D k r n * ADen n ≠ 0 := mul_ne_zero (D_ne_zero k r n) (ADen_ne_zero n)
  have hright : (L r) ^ r * ANum n ≠ 0 :=
    mul_ne_zero (pow_ne_zero _ hL) (ANum_ne_zero n)
  apply (Nat.factorization_prime_le_iff_dvd hleft hright).mp
  intro p hp
  let b := exponentBound n r k
  have hb : 8 * n < b := by unfold b exponentBound; omega
  have hD := factorization_D_bound n r k p hr hk hp
  have hA := factorization_ANum_eq_ADen_add_landau n p b hp hb
  dsimp only [b] at hA
  have hleftFac : (D k r n * ADen n).factorization p =
      (D k r n).factorization p + (ADen n).factorization p := by
    rw [Nat.factorization_mul (D_ne_zero k r n) (ADen_ne_zero n)]
    rfl
  have hrightFac : ((L r) ^ r * ANum n).factorization p =
      r * (L r).factorization p + (ANum n).factorization p := by
    rw [Nat.factorization_mul (pow_ne_zero _ hL) (ANum_ne_zero n),
      Nat.factorization_pow]
    simp
  rw [hleftFac, hrightFac, hA]
  omega

/-- The exact constant is strictly positive. -/
theorem constant_pos (r : ℕ) (hr : 0 < r) : 0 < (L r) ^ r := by
  cases r with
  | zero => omega
  | succ r =>
      exact pow_pos (by simpa [L] using Nat.lcmUpto_pos (8 * (r + 1) - 1)) _

/-- Intended integral sequence, introduced only after exactness is proved. -/
def a (n : ℕ) : ℕ :=
  ANum n / ADen n

/-- The quotient is exact, not a truncation artifact. -/
theorem ADen_mul_a (n : ℕ) : ADen n * a n = ANum n := by
  unfold a
  exact Nat.mul_div_cancel' (integral_cross n)

/-- Mandatory quotient formulation of the strengthened theorem. -/
theorem strengthened (n r k : ℕ) (hr : 0 < r)
    (hk : k = 1 ∨ k = 2 ∨ k = 3) :
    D k r n ∣ (L r) ^ r * a n := by
  have hcross := strengthened_cross n r k hr hk
  rw [← ADen_mul_a n] at hcross
  have hcancel : D k r n * ADen n ∣ ((L r) ^ r * a n) * ADen n := by
    simpa only [mul_assoc, mul_left_comm, mul_comm] using hcross
  exact (Nat.mul_dvd_mul_iff_right (by unfold ADen; positivity)).mp hcancel

end A211420
