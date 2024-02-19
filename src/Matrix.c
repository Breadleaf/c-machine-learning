#include "Matrix.h"

const struct MatrixInterface matrixInterface = {
    .create = createMatrix,
    .free = freeMatrix
};