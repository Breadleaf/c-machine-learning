#ifndef DATUMFUNCTIONS_H
#define DATUMFUNCTIONS_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "DatumObject.h"

Datum *createDatum(DatumType type, void *value);
void freeDatum(Datum *datum);

#endif // DATUMFUNCTIONS_H