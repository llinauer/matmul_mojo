from matmul import matmul_v1, init_random_matrix, init_unit_matrix
from matrix import Matrix_v1, Matrix_v2

fn test_matmul_v1(n: Int) raises:
    
    var A: List[List[Float32]] = init_random_matrix(n, n)
    var B: List[List[Float32]] = init_unit_matrix(n)
    C = matmul_v1(A, B)

    for i in range(n):
        for j in range(n):
            if C[i][j] != A[i][j]:
                raise Error("matmul_v1 incorrectly implemented")
    print("\nmatmul_v1 works as expected!!")


fn test_matrix_v1(n: Int):
    print()
    print("\n-------- Matrix_v1 ---------")
    var A: Matrix_v1 = Matrix_v1.random(n, n)
    var B: Matrix_v1 = Matrix_v1.unit(n)
    print("\nMatrix_v1 A:")
    print(String(A))
    print("\nMatrix_v1 B:")
    print(String(B))

fn test_matmul_v2(n: Int) raises:
    
    var A: Matrix_v1 = Matrix_v1.random(n, n)
    var B: Matrix_v1 = Matrix_v1.unit(n)
    if A@B == A:
        print("\nmatmul_v2 works as expected!!")


fn test_matrix_v2(n: Int):
    print()
    print("\n-------- Matrix_v2 ---------")
    var A: Matrix_v2 = Matrix_v2.random(n, n)
    var B: Matrix_v2 = Matrix_v2.unit(n)
    var C: Matrix_v2 = Matrix_v2.zero(n, 1)
    print("\nMatrix_v2 A:")
    print(String(A))
    print("\nMatrix_v2 B:")
    print(String(B))
    print("\nMatrix_v2 C:")
    print(String(C))


fn test_matmul_v3(n: Int) raises:
    
    var A: Matrix_v2 = Matrix_v2.random(n, n)
    var B: Matrix_v2 = Matrix_v2.unit(n)
    if A.matmul(B) == A:
        print("\nmatmul_v3 works as expected!!")
    
fn test_matmul_simd(n: Int) raises:
    
    var A: Matrix_v2 = Matrix_v2.random(n, n)
    var B: Matrix_v2 = Matrix_v2.unit(n)
    if A@B == A:
        print("\nmatmul_simd works as expected!!")


fn main() raises:
    test_matmul_v1(10)
    test_matrix_v1(5)
    test_matmul_v2(10)
    test_matrix_v2(4)
    test_matmul_v3(10)
    test_matmul_simd(10)

