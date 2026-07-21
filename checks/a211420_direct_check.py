from math import isqrt

N, R = 150, 60
M = 3*N + R
isprime = [True] * (M + 1)
isprime[0:2] = [False, False]
for i in range(2, isqrt(M) + 1):
    if isprime[i]:
        for j in range(i*i, M + 1, i):
            isprime[j] = False
primes = [i for i, ok in enumerate(isprime) if ok]

def vp_fact(n, p):
    ans = 0
    while n:
        n //= p
        ans += n
    return ans

def vp_a(n, p):
    return (vp_fact(8*n,p) + vp_fact(n,p) - vp_fact(4*n,p)
            - vp_fact(3*n,p) - vp_fact(2*n,p))

def vp_lcm(p, r):
    q, ans = p, 0
    while q < 8*r:
        ans += 1
        q *= p
    return ans

def vp_D(n, r, k, p):
    ans = 0
    for i in range(1, r+1):
        x = k*n + i
        while x % p == 0:
            ans += 1
            x //= p
    return ans

triples = checks = 0
min_slack = None
min_data = None
for n in range(N + 1):
    for r in range(1, R + 1):
        for k in (1, 2, 3):
            triples += 1
            for p in primes:  # primes above max_i(kn+i) have v_p(D)=0
                checks += 1
                slack = vp_a(n,p) + r*vp_lcm(p,r) - vp_D(n,r,k,p)
                if min_slack is None or slack < min_slack:
                    min_slack, min_data = slack, (n,r,k,p)
                if slack < 0:
                    raise SystemExit(f'COUNTEREXAMPLE n={n} r={r} k={k} p={p} slack={slack}')
print(f'OK triples={triples} all_prime_checks={checks} min_slack={min_slack} at={min_data}')
