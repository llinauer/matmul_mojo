import random 

fn init_random_matrix(rows: Int, cols: Int) -> List[List[Float32]]:
    # Seed the random number generator using the current time.
    random.seed()

    var A: List[List[Float32]] = []

    for _ in range(rows):
        var row_data: List[Float32] = []
        for _ in range(cols):
            # Generate a random 0 or 1 and append it to the row.
            row_data.append(Float32(random.random_float64(0, 1)))
        A.append(row_data)

    return A


fn init_unit_matrix(n: Int) -> List[List[Float32]]:
    # Init a nxn unit matrix
    var A: List[List[Float32]] = []

    for i in range(n):
        var row_data: List[Float32] = List[Float32](length=n, fill=0.)
        row_data[i] = 1.
        A.append(row_data)
    return A


fn matmul_v1(A: List[List[Float32]], B: List[List[Float32]]) raises -> List[List[Float32]]:

    # check shapes
    if len(A) != len(B[0]):
        raise Error("Matrices A & B have incompatible shapes")

    var rows: Int = len(A[0])
    var cols: Int = len(B)

    var C: List[List[Float32]] = List(length=len(A[0]), fill=List[Float32](length=len(B), fill=0.))

    for j in range(cols):
        for i in range(rows):
            for k in range(len(A)):
                C[i][j] += A[i][k]*B[k][j]

    return C


fn main():
    pass
