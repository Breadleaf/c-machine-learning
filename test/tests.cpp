#include "TestSuite.hpp"
#include "Matrix.h"

int main() {
    Matrix *matrix = NULL;
    const int ROWS = 3;
    const int COLS = 3;

    TestSuite ts("C Machine Learning Test Suite");

    ts.addTest("Make Matrix", [&]() {
        matrix = matrixInterface.create(ROWS, COLS);
        return matrix != NULL;
    });

    ts.addTest("Use Matrix", [&]() {
        double value = 1.0;
        matrixInterface.set(matrix, 0, 0, value);
        return matrixInterface.get(matrix, 0, 0) == value;
    });

    ts.addTest("Free Matrix", [&]() {
        matrixInterface.free(matrix);
        return matrix == NULL;
    });

    ts.runTests();
}
