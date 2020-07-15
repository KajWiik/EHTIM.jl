module EHTIM
using PyCall, StructArrays, Dates

export structarray, bldict, get_obstime

new() = pyimport("ehtim")

function get_obstime(x::PyObject)
    if :unpack in keys(x)
        julian2datetime.(get(x.data, :time)/24 .+ 2400000.5 .+ x.mjd)
    else
        error("Use get_obstime only on Obsdata object.")
    end
end

function structarray(x::PyCall.PyObject; datetime = true)
    ref = :unpack in keys(x) ? x.data : x
    labels = ref.dtype.names |> collect
    data = []
    for (i,n) in enumerate(labels)
        # Handle for Unicode arrays that are not supported by PyArray
        # https://www.oreilly.com/library/view/python-for-finance/9781491945360/ch04.html
        push!(data, get(ref.dtype, i-1).str[2] == 'U' ? get.(ref, i-1) : PyArray(py"$ref[$n]"o))
    end
    if :unpack in keys(x) && datetime && any(ref.dtype.names .== "time")
        push!(labels, "datetime")
        push!(data, get_obstime(x))
    end

    (;zip(Symbol.(labels), data)...) |> StructArray
end

function structarray(x::Array{PyCall.PyObject,1})
    array = StructArray[]
    for element in x
        push!(array, structarray(element))
    end
    return array
end

function bldict(x::Array{StructArrays.StructArray,1})
    dict = Dict{String,StructArray}()
    for element in x
        if hasproperty(element, :t1) && hasproperty(element, :t2)
            dict[element.t1[1] > element.t2[1] ? element.t2[1]*"-"*element.t1[1] :
                 element.t1[1]*"-"*element.t2[1]] = element
        else
            error("No baseline information in data.")
        end
    end
    return dict
end

end # EHTIM
