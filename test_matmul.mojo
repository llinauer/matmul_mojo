from matmul import matmul_v1, init_random_matrix, init_unit_matrix
from matrix import Matrix_v1

fn test_matmul_v1(n: Int) raises:
    
    var A: List[List[Float32]] = init_random_matrix(n, n)
    var B: List[List[Float32]] = init_unit_matrix(n)
    C = matmul_v1(A, B)

    for i in range(n):
        for j in range(n):
            if C[i][j] != A[i][j]:
                raise Error("matmul_v1 incorrectly implemented")
    print("matrixmul_v1 works as expected!!")


fn test_matrix(n: Int):

    var A: Matrix_v1 = Matrix_v1.random(n, n)
    var B: Matrix_v1 = Matrix_v1.unit(n)
    print("Matrix_v1 A:")
    print(String(A))
    print("Matrix_v1 B:")
    print(String(B))

fn test_matmul_v2(n: Int) raises:
    
    var A: Matrix_v1 = Matrix_v1.random(n, n)
    var B: Matrix_v1 = Matrix_v1.unit(n)
    if A@B == A:
        print("matrixmul_v2 works as expected!!")
    


fn main() raises:
    test_matmul_v1(10)
    test_matrix(5)
    test_matmul_v2(10)
