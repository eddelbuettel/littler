#!/usr/bin/r

if (getRversion() < "3.4.0") stop("Not available for R (< 3.4.0). Please upgrade.", call.=FALSE)

tools::package_native_routine_registration_skeleton(".")
