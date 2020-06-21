module EHTIM
using PyCall, StructArrays

export structarray

new() = pyimport("ehtim")

function structarray(x)
    labels = Symbol.(x.dtype.names)
    data = []
    for (i,n) in enumerate(labels)
        # Handle for Unicode arrays that are not supported by PyArray
        push!(data, get(x.dtype, i-1).str[2] == 'U' ? get.(x, i-1) : PyArray(py"$x[$n]"o))
    end
    (;zip(labels, data)...)|>StructArray
end
end # EHTIM
