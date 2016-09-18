"""
import random

N = 100
print N

random.seed(1234)

for i in range(N):
    print random.randint(1,10**5), random.randint(1, 10**5)
"""

N = input()
w = [0]*N
h = [0]*N
for i in range(N):
    w[i],h[i] = map(int, raw_input().split())

n = [1]*N
for i in range(N):
    for j in range(N):
        for k in range(N):
            if w[j]<w[k] and h[j]<h[k]:
                n[k] = max(n[k], n[j]+1)
print hex(max(n))
#"""
