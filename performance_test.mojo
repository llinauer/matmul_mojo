import time
from matmul import init_random_matrix, matmul_v1
from matrix import Matrix_v1, Matrix_v2

fn write_results_to_csv(results: List[(String, Int, Float64)], filename: String) raises:
    var f = open(filename, "w")
    f.write("version,n,runtime\n")
    for (ver, size, runtime) in results:
        var line: String = String(ver) + "," + String(size) + "," + String(runtime) + "\n"
        f.write(line)
    f.close()

fn main() raises:

    var iterations: Int = 20
    var matrix_sizes: List[Int] = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
    var results: List[(String, Int, Float64)] = []

    print("Mojo Matrix Multiplication Performance Test")
    print("--------------------------------------------")

    # comparison of Matrix multiplication implementation runtimes
    for n in matrix_sizes:

        print("\nMatrix size: " + String(n))

        # init matrices 
        var A_v1: List[List[Float32]] = init_random_matrix(n, n)
        var B_v1: List[List[Float32]] = init_random_matrix(n, n)

        var A_v2: Matrix_v1 = Matrix_v1.random(n, n)
        var B_v2: Matrix_v1 = Matrix_v1.random(n, n)       

        var A_v3: Matrix_v2 = Matrix_v2.random(n, n)
        var B_v3: Matrix_v2 = Matrix_v2.random(n, n)

        var A_v4: Matrix_v2 = Matrix_v2.random(n, n)
        var B_v4: Matrix_v2 = Matrix_v2.random(n, n)

        # v1
        t0 = time.perf_counter_ns()
        for _ in range(iterations):
            _ = matmul_v1(A_v1, B_v1)
        t_delta = time.perf_counter_ns() - t0
        results.append(("v1", n, t_delta / iterations))

        # v2
        t0 = time.perf_counter_ns()
        for _ in range(iterations):
            _ = A_v2 @ B_v2
        t_delta = time.perf_counter_ns() - t0
        results.append(("v2", n, t_delta / iterations))

        # v3
        t0 = time.perf_counter_ns()
        for _ in range(iterations):
            _ = A_v3.matmul(B_v3)
        t_delta = time.perf_counter_ns() - t0
        results.append(("v3", n, t_delta / iterations))

        # v4
        t0 = time.perf_counter_ns()
        for _ in range(iterations):
            _ = A_v4 @ B_v4
        t_delta = time.perf_counter_ns() - t0
        results.append(("v4", n, t_delta / iterations))

        write_results_to_csv(results, "mojo_matmul_benchmark.csv")