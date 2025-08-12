import random 

fn init_random_matrix(rows: Int, cols: Int) -> List[List[Float64]]:
    # Seed the random number generator using the current time.
    random.seed()

    var A: List[List[Float64]] = []

    for _ in range(rows):
        var row_data: List[Float64] = []
        for _ in range(cols):
            # Generate a random 0 or 1 and append it to the row.
            row_data.append(random.random_float64(0, 1))
        A.append(row_data)

    return A


fn init_unit_matrix(n: Int) -> List[List[Float64]]:
    # Init a nxn unit matrix
    var A: List[List[Float64]] = []

    for i in range(n):
        var row_data: List[Float64] = List(length=n, fill=0.)
        row_data[i] = 1.
        A.append(row_data)
    return A


fn matmul_v1(A: List[List[Float64]], B: List[List[Float64]]) raises -> List[List[Float64]]:

    # check shapes
    if len(A) != len(B[0]):
        raise Error("Matrices A & B have incompatible shapes")

    var rows: Int = len(A[0])
    var cols: Int = len(B)

    var C: List[List[Float64]] = List(length=len(A[0]), fill=List(length=len(B), fill=0.))

    for j in range(cols):
        for i in range(rows):
            for k in range(len(A)):
                C[i][j] += A[i][k]*B[k][j]

    return C


fn main():
    pass
