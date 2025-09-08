import numpy as np
import time
import csv

sizes =  [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024] 
repeats = 20
output_file = "numpy_matmul_benchmark.csv"

results = []

for N in sizes:

    A = np.random.rand(N, N).astype(np.float32)
    B = np.random.rand(N, N).astype(np.float32)

    # Warmup run (ensure caches, JIT, etc.)
    _ = A @ B

    times = []
    for _ in range(repeats):
        start = time.time()
        _ = A @ B
        end = time.time()
        times.append(end - start)
    avg_time = sum(times) / repeats
    results.append((N, avg_time*10**9))

with open(output_file, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["size", "runtime_ns"])
    writer.writerows(results)

print(f"\nResults saved to {output_file}")
