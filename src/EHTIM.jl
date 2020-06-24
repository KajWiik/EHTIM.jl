module EHTIM
using PyCall, StructArrays

export structarray, bldict

new() = pyimport("ehtim")

function structarray(x::PyCall.PyObject)
    labels = Symbol.(x.dtype.names)
    data = []
    for (i,n) in enumerate(labels)
        # Handle for Unicode arrays that are not supported by PyArray
        # https://www.oreilly.com/library/view/python-for-finance/9781491945360/ch04.html
        push!(data, get(x.dtype, i-1).str[2] == 'U' ? get.(x, i-1) : PyArray(py"$x[$n]"o))
    end
    (;zip(labels, data)...)|>StructArray
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
