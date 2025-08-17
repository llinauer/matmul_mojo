import random

@fieldwise_init
struct Matrix(Copyable, Movable, Stringable):
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