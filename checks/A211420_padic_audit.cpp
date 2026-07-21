#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <limits>
#include <string>
#include <tuple>
#include <vector>

// Exact p-adic audit for
//   a_n = (8n)! n! / ((4n)! (3n)! (2n)!)
// and D_{k,r}(n) = prod_{i=1}^r (kn+i).
//
// It checks v_p(D_{k,r}(n)) <= r v_p(lcm(1,...,8r-1)) + v_p(a_n)
// for every 0 <= n <= NMAX, 1 <= r <= RMAX, k in {1,2,3},
// and every prime p dividing D_{k,r}(n). All arithmetic is integral.

static long long factorial_vp(long long m, int p) {
    long long s = 0;
    while (m > 0) {
        m /= p;
        s += m;
    }
    return s;
}

static long long a_vp(int n, int p) {
    return factorial_vp(8LL * n, p) + factorial_vp(n, p)
         - factorial_vp(4LL * n, p) - factorial_vp(3LL * n, p)
         - factorial_vp(2LL * n, p);
}

static int lcm_vp(int r, int p) {
    // Number of j >= 1 with p^j < 8r.
    int e = 0;
    long long power = p;
    const long long cutoff = 8LL * r;
    while (power < cutoff) {
        ++e;
        if (power > (cutoff - 1) / p) break;
        power *= p;
    }
    return e;
}

int main(int argc, char** argv) {
    int NMAX = 10000;
    int RMAX = 1000;
    if (argc >= 2) NMAX = std::stoi(argv[1]);
    if (argc >= 3) RMAX = std::stoi(argv[2]);
    if (NMAX < 0 || RMAX < 1) {
        std::cerr << "Usage: " << argv[0] << " [NMAX>=0] [RMAX>=1]\n";
        return 2;
    }

    const int limit = 3 * NMAX + RMAX;
    std::vector<int> spf(limit + 1);
    for (int i = 0; i <= limit; ++i) spf[i] = i;
    if (limit >= 1) spf[1] = 1;
    for (int i = 2; 1LL * i * i <= limit; ++i) {
        if (spf[i] == i) {
            for (long long j = 1LL * i * i; j <= limit; j += i) {
                if (spf[(int)j] == j) spf[(int)j] = i;
            }
        }
    }

    // First independently verify nonnegativity of v_p(a_n) for all relevant p
    // in the search range, so the checker is not relying on assumed integrality.
    std::vector<int> primes;
    for (int p = 2; p <= std::max(2, 8 * NMAX); ++p) {
        bool is_prime = true;
        for (int d = 2; 1LL * d * d <= p; ++d) {
            if (p % d == 0) { is_prime = false; break; }
        }
        if (is_prime) primes.push_back(p);
    }
    // The simple prime construction above is deliberately transparent, but for
    // NMAX=10000 it is still small. Check all n,p pairs only while p <= 8n.
    for (int n = 0; n <= NMAX; ++n) {
        for (int p : primes) {
            if (p > 8 * n) break;
            long long va = a_vp(n, p);
            if (va < 0) {
                std::cout << "FAIL: negative v_p(a_n): n=" << n
                          << " p=" << p << " valuation=" << va << "\n";
                return 1;
            }
        }
    }

    std::uint64_t triples = 0;
    std::uint64_t prime_factor_updates = 0;
    long long minimum_slack = std::numeric_limits<long long>::max();
    std::tuple<int,int,int,int,long long,long long> min_case{};

    std::vector<long long> vpD(limit + 1, 0);
    std::vector<int> touched;
    touched.reserve(limit / 4 + 1);

    for (int n = 0; n <= NMAX; ++n) {
        for (int k = 1; k <= 3; ++k) {
            for (int p : touched) vpD[p] = 0;
            touched.clear();

            for (int r = 1; r <= RMAX; ++r) {
                ++triples;
                int x = k * n + r;
                std::vector<std::pair<int,int>> factors;
                while (x > 1) {
                    int p = spf[x];
                    int e = 0;
                    do { x /= p; ++e; } while (x > 1 && spf[x] == p);
                    factors.push_back({p,e});
                }

                for (auto [p,e] : factors) {
                    if (vpD[p] == 0) touched.push_back(p);
                    vpD[p] += e;
                    ++prime_factor_updates;

                    const long long lhs = vpD[p];
                    const long long va = a_vp(n, p);
                    const long long rhs = va + 1LL * r * lcm_vp(r, p);
                    const long long slack = rhs - lhs;
                    if (slack < minimum_slack) {
                        minimum_slack = slack;
                        min_case = {n,k,r,p,lhs,rhs};
                    }
                    if (slack < 0) {
                        std::cout << "COUNTEREXAMPLE\n"
                                  << "n=" << n << " k=" << k << " r=" << r
                                  << " p=" << p << "\n"
                                  << "v_p(D)=" << lhs
                                  << " v_p(a_n)=" << va
                                  << " v_p(L_r)=" << lcm_vp(r,p)
                                  << " RHS=" << rhs << "\n";
                        return 1;
                    }
                }
                // Primes not updated at this r cannot newly fail: their LHS is
                // unchanged, while r*v_p(L_r) is nondecreasing in r.
            }
        }
    }

    const auto [mn,mk,mr,mp,mlhs,mrhs] = min_case;
    std::cout << "PASS\n";
    std::cout << "range: 0 <= n <= " << NMAX
              << ", 1 <= r <= " << RMAX << ", k in {1,2,3}\n";
    std::cout << "triples checked: " << triples << "\n";
    std::cout << "prime-factor updates checked: " << prime_factor_updates << "\n";
    std::cout << "minimum valuation slack: " << minimum_slack << "\n";
    std::cout << "one minimum case: n=" << mn << " k=" << mk
              << " r=" << mr << " p=" << mp
              << " lhs=" << mlhs << " rhs=" << mrhs << "\n";
    return 0;
}
