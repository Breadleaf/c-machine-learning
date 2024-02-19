#ifndef DATUMOBJECT_H
#define DATUMOBJECT_H

typedef enum DatumType {
    NUMBER,
    STRING,
    NONE
} DatumType;

typedef struct Datum {
    DatumType type;
    union {
        double number;
        char *string;
    } value;
} Datum;

#endif // DATUMOBJECT_H