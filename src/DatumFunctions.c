#include "DatumFunctions.h"

// Datum *createDatum(DatumType type, void *value);
// void freeDatum(Datum *datum);

Datum *createDatum(DatumType type, void *value) {
    Datum *d = malloc(sizeof(Datum));
    if (d == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    d->type = type;

    switch (type) {
        case NUMBER:
            d->value = malloc(sizeof(double));
            if (d->value == NULL) {
                fprintf(stderr, "Memory allocation failed\n");
                free(d);
                exit(1);
            }

            *(double *)d->value = *(double *)value;
            break;
        case STRING:
            d->value = malloc(strlen((char *)value) + 1);
            if (d->value == NULL) {
                fprintf(stderr, "Memory allocation failed\n");
                free(d);
                exit(1);
            }

            strcpy((char *)d->value, (char *)value);
            break;
        case NONE:
            
    }

    return d;
}