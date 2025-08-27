import random
from buffer import NDBuffer

@fieldwise_init
struct Matrix_v1(Copyable, Movable, Stringable):
    var rows: Int
    var cols: Int
    var data: List[List[Float32]]


    fn __str__(self) -> String:
        str = String()

        for row in range(self.rows):
            for col in range(self.cols):
                str = str + String(self.data[row][col])
                if col != self.cols - 1:
                    str += ", "
            if row != self.rows - 1:
                str += "\n"
        return str

    fn __getitem__(self, row: Int, col: Int) -> Float32:
        return self.data[row][col]

    fn __setitem__(mut self, row: Int, col: Int, value: Float32):
        self.data[row][col] = value

    fn __matmul__(self, other: Matrix_v1) raises -> Self:
        # check shapes
        if self.cols != other.rows:
            raise Error("Cannot multiply matrices with shape ({self.rows},{self.cols}) and ({other.rows},{other.cols})")

        var C: Matrix_v1 = Matrix_v1.zero(self.rows, other.cols)

        for j in range(self.cols):
            for i in range(self.cols):
                for k in range(self.rows):
                    C[i, j] += self[i, k]*other[k, j]
        return C

    fn __eq__(self, other: Matrix_v1) -> Bool:
        if self.rows != other.rows or self.cols != other.cols:
            return False
        
        for i in range(self.rows):
            for j in range(self.cols):
                if self[i, j] != other[i, j]:
                    return False
        return True


    @staticmethod
    fn random(rows: Int, cols: Int) -> Self:

        random.seed()

        var data: List[List[Float32]] = []

        for _ in range(rows):
            var row_data: List[Float32] = []
            for _ in range(cols):
                row_data.append(Float32(random.random_float64(0, 1)))
            data.append(row_data)

        return Self(rows, cols, data)

    @staticmethod
    fn unit(n: Int) -> Self:

        var data: List[List[Float32]] = []
        for i in range(n):
            var row_data: List[Float32] = List[Float32](length=n, fill=0.)
            row_data[i] = 1.
            data.append(row_data)
        return Self(n, n, data)

    @staticmethod
    fn zero(rows: Int, cols: Int) -> Self:

        var data: List[List[Float32]] = []
        for _ in range(rows):
            var row_data: List[Float32] = List[Float32](length=cols, fill=0.)
            data.append(row_data)
        return Self(rows, cols, data)


@fieldwise_init
struct Matrix_v2(Copyable, Movable, Stringable):
    var rows: Int
    var cols: Int
    var data: List[Float32]
    
    fn __init__(out self, rows: Int, cols: Int):
        self.rows = rows
        self.cols = cols
        self.data = List[Float32](length=rows * cols, fill=0.0)

    fn __getitem__(self, row: Int, col: Int) -> Float32:
        return self.data[row * self.cols + col]

    fn __setitem__(mut self, row: Int, col: Int, val: Float32):
        self.data[row * self.cols + col] = val


    fn __str__(self) -> String:
        str = String()

        for row in range(self.rows):
            for col in range(self.cols):
                str = str + String(self[row, col])
                if col != self.cols - 1:
                    str += ", "
            if row != self.rows - 1:
                str += "\n"
        return str

    @staticmethod
    fn random(rows: Int, cols: Int) -> Self:
        random.seed()
        var M = Self(rows, cols)
        for i in range(rows * cols):
            M.data[i] = Float32(random.random_float64(0.0, 1.0))
        return M

    @staticmethod
    fn unit(n: Int) -> Self:
        var M = Self(n, n)
        for i in range(n):
            M.data[i*n + i] = 1.0
        return M

    @staticmethod
    fn zero(rows: Int, cols: Int) -> Self:
        return Self(rows, cols)


    @staticmethod
    fn transpose_into(read B: Matrix_v2, mut BT: Matrix_v2) raises:
        if BT.rows != B.cols or BT.cols != B.rows:
            raise Error("transpose_into: BT must have shape ({B.cols},{B.rows})")

        for row in range(B.rows):
            for col in range(B.cols):
                BT.data[col * BT.cols + row] = B.data[row * B.cols + col]

    @staticmethod
    fn dot_scalar(a: List[Float32], a_off: Int,
                b: List[Float32], b_off: Int,
                K: Int) -> Float32:
        var s: Float32 = 0.0
        var k: Int = 0
        while k < K:
            s += a[a_off + k] * b[b_off + k]
            k += 1
        return s

    @staticmethod
    fn matmul(A: Matrix_v2, B: Matrix_v2) raises -> Matrix_v2:

        if A.cols != B.rows:
            raise Error("Cannot multiply matrices with shape ({A.rows},{A.cols}) and ({B.rows},{B.cols})")
        var M: Int = A.rows
        var K: Int = A.cols
        var N: Int = B.cols

        var BT = Matrix_v2(B.cols, B.rows)   
        Self.transpose_into(B, BT)

        var C: Matrix_v2 = Matrix_v2.zero(M, N)

        for i in range(M):
            for j in range(N):
                C[i, j] = Self.dot_scalar(A.data, i * A.cols, BT.data, j * BT.cols, K)
        return C