using Comonicon
using DataFrames

# in a script or module

"""
sum two numbers.

# Args

- `x`: first number
- `y`: second number

# Options

- `-p, --precision=<type>`: precision of the calculation.

# Flags

- `-f, --fastmath`: enable fastmath.

"""

@cast function df(x; fastmath::Bool=false)
    # implementation
    println(DataFrame(x=[1,2,3]))
end


@main
