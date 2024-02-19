#ifndef MATRIXFUNCTIONS_H
#define MATRIXFUNCTIONS_H

#include <stdio.h>
#include <stdlib.h>

#include "MatrixObject.h"

Matrix *createMatrix(int rows, int cols);
void freeMatrix(Matrix *matrix);

void setMatrix(Matrix *matrix, int row, int col, double value);
double getMatrix(Matrix *matrix, int row, int col);

#endif // MATRIXFUNCTIONS_H