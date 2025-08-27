import random

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
struct Matrix(Copyable, Movable, Stringable):
    var rows: Int
    var cols: Int
    var data: List[List[Float32]]