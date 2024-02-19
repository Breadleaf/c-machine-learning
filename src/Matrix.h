#ifndef MATRIX_H
#define MATRIX_H

#include "MatrixObject.h"
#include "MatrixFunctions.h"

struct MatrixInterface {
    Matrix *(*create)(int rows, int cols);
    void (*free)(Matrix *matrix);
};

extern const struct MatrixInterface matrixInterface;

#endif // MATRIX_H