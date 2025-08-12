from matmul import matmul_v1, init_random_matrix, init_unit_matrix


fn test_matmul_v1(n: Int) raises:
    
    var A: List[List[Float64]] = init_random_matrix(n, n)
    var B: List[List[Float64]] = init_unit_matrix(n)
    C = matmul_v1(A, B)

    for i in range(n):
        for j in range(n):
            if C[i][j] != A[i][j]:
                raise Error("matmul_v1 incorrectly implemented")
    print("matrixmul_v1 works as expected!!")



fn main() raises:
    test_matmul_v1(10)
