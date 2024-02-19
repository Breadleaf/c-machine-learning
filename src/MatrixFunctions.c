#include "MatrixFunctions.h"

Matrix *createMatrix(int rows, int cols) {
    Matrix *m = malloc(sizeof(Matrix));
    
    m->rows = rows;
    m->cols = cols;

    m->data = malloc(rows * cols * sizeof(double *));
    if (m->data == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        free(m);
        exit(1);
    }

    for (int i = 0; i < rows; i++) {
        m->data[i] = malloc(cols * sizeof(double));
        if (m->data[i] == NULL) {
            fprintf(stderr, "Memory allocation failed\n");
            free(m->data);
            free(m);
            exit(1);
        }

        for (int j = 0; j < cols; j++) {
            m->data[i][j] = NULL;
        }
    }

    return m;
}

void freeMatrix(Matrix *m) {
    if (m == NULL) {
        return;
    }

    for (int i = 0; i < m->rows; i++) {
        free(m->data[i]);
    }
    
    free(m->data);
    free(m);

    m = NULL;
}

void setMatrix(Matrix *m, int row, int col, double value) {
    if (row < 0 || row >= m->rows || col < 0 || col >= m->cols) {
        fprintf(stderr, "Index out of bounds\n");
        exit(1);
    }

    m->data[row][col] = value;
}

double getMatrix(Matrix *m, int row, int col) {
    if (row < 0 || row >= m->rows || col < 0 || col >= m->cols) {
        fprintf(stderr, "Index out of bounds\n");
        exit(1);
    }

    return m->data[row][col];
}
