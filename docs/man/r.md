

# Return Path to <code>r</code> Binary

[**Source code**](https://github.com/eddelbuettel/littler/tree/master/R/#L)

## Description

Return the path of the install <code>r</code> binary.

## Usage

<pre><code class='language-R'>r(usecat = FALSE)
</code></pre>

## Arguments

<table role="presentation">
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="usecat">usecat</code>
</td>
<td>
Optional toggle to request output to stdout (useful in Makefiles)
</td>
</tr>
</table>

## Details

The test for Windows is of course superfluous as we have no binary for
Windows. Maybe one day…

## Value

The path is returned as character variable. If the <code>usecat</code>
option is set the character variable is displayed via <code>cat</code>
instead.

## Author(s)

Dirk Eddelbuettel
