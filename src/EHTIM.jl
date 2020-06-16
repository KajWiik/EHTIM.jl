module EHTIM
using PyCall, StructArrays

export structarray

new() = pyimport("ehtim")

function structarray(x::PyObject)
    p = x.ctypes.data
    a = unsafe_wrap(Array, Ptr{NamedTuple{(Symbol.(x.dtype.names)...,), Tuple{Float64, Float64, Float64, Float64}}}(p), length(x))|>StructArray
    GC.@preserve x a
    return a
end
end # EHTIM
