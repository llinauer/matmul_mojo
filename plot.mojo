from python import Python 

def main(): 
    csv = Python.import_module("csv") 
    plt = Python.import_module("matplotlib.pyplot") 
    builtins = Python.import_module("builtins") 
    python_file = builtins.open("numpy_matmul_benchmark.csv", "r") 
    mojo_file = builtins.open("mojo_matmul_benchmark.csv", "r") 
    python_reader = csv.reader(python_file) 
    mojo_reader = csv.reader(mojo_file)
    py_float = builtins.float
    
    var matmul_v1_times: List[Float32] = [] 
    var matmul_v2_times: List[Float32] = [] 
    var matmul_v3_times: List[Float32] = [] 
    var matmul_v4_times: List[Float32] = [] 
    var numpy_times: List[Float32] = [] 
    var matrix_sizes: List[Int] = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024] 
    var i: Int = 0 
    var j: Int = 0 
    
    for row in python_reader: 
        if i == 0: 
            i += 1 
            continue
        numpy_times.append(Float32(Python.float(row[1])))
        
    for row in mojo_reader: 
        if j == 0: 
            j += 1 
            continue 

        if row[0] == "v1": 
            matmul_v1_times.append(Float32(Python.float(row[2]))) 
        if row[0] == "v2": 
            matmul_v2_times.append(Float32(Python.float(row[2]))) 
        if row[0] == "v3": 
            matmul_v3_times.append(Float32(Python.float(row[2]))) 
        if row[0] == "v4": 
            matmul_v4_times.append(Float32(Python.float(row[2]))) 

    plt.plot(Python.list(matrix_sizes), Python.list(numpy_times), label="Python (NumPy)", marker="o", linestyle="solid") 
    plt.plot(Python.list(matrix_sizes), Python.list(matmul_v1_times), label="Mojo matmul_v1", marker="v", linestyle="dashed") 
    plt.plot(Python.list(matrix_sizes), Python.list(matmul_v2_times), label="Mojo matmul_v2", marker="x", linestyle="dotted") 
    plt.plot(Python.list(matrix_sizes), Python.list(matmul_v3_times), label="Mojo matmul_v3 (flattened)", marker="s", linestyle="dashdot") 
    plt.plot(Python.list(matrix_sizes), Python.list(matmul_v4_times), label="Mojo matmul_v4 (flattened + SIMD)", marker="P", linestyle=":") 
    plt.xlabel("Matrix Size (N)") 
    plt.ylabel("Time (s)") 
    plt.title("Matrix Multiplication Benchmark") 
    plt.legend() 
    plt.grid(True)
    plt.show(bbox_inches="tight")