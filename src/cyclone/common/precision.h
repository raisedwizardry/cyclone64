/*
 * Interface file for code that changes when the core's precision is
 * altered.
 *
 * Part of the Cyclone physics system.
 *
 * Copyright (c) Icosagon 2003. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 */

/**
 * @file
 *
 * Because Cyclone is designed to work at either single or double
 * precision, mathematical functions such as sqrt cannot be used
 * in the source code or headers. This file provides defines for
 * the real number type and mathematical formulae that work on it.
 *
 * @note All the contents of this file need to be changed to compile
 * Cyclone at a different precision.
 */

#include <cfloat>

//#define FLT_MAX=3.402823466e+38F
//#define FLT_EPSILON 1.19209290E-07F

#ifndef CYCLONE_PRECISION_H
#define CYCLONE_PRECISION_H

namespace cyclone {
    /** Defines the highest value for the real number. */
    #define REAL_MAX FLT_MAX

    /** Defines the precision of the square root operator. */
    #define real_sqrt sqrtf
    /** Defines the precision of the absolute magnitude operator. */
    #define real_abs fabsf
    /** Defines the precision of the sine operator. */
    #define real_sin sinf

    /** Defines the precision of the cosine operator. */
    #define real_cos cosf

    /** Defines the precision of the exponent operator. */
    #define real_exp expf
    /** Defines the precision of the power operator. */
    #define real_pow powf

    /** Defines the precision of the floating point modulo operator. */
    #define real_fmod fmodf
    
    /** Defines the number e on which 1+e == 1 **/
    #define real_epsilon FLT_EPSILON

    #define R_PI 3.14159f

}

#endif // CYCLONE_PRECISION_H
