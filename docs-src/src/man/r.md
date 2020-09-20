## Return Path to `r` Binary

### Description

Return the path of the install `r` binary.

### Usage

    r(usecat = FALSE)

### Arguments

| Argument | Description                                                       |
| -------- | ----------------------------------------------------------------- |
| `usecat` | Optional toggle to request output to stdout (useful in Makefiles) |

### Details

The test for Windows is of course superfluous as we have no binary for
Windows. Maybe one day...

### Value

The path is returned as character variable. If the `usecat` option is
set the character variable is displayed via `cat` instead.

### Author(s)

Dirk Eddelbuettel
