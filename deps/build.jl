using PyCall, Conda

Conda.add("pynfft", channel="conda-forge")

#const PACKAGES = ["ehtim"]
 PACKAGES = ["ehtim"]

try
    @pyimport pip
catch
    get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
    download("https://bootstrap.pypa.io/get-pip.py", get_pip)
    run(`$(PyCall.python) $get_pip --user`)
end

@pyimport pip # <<== HERE
#args = UTF8String[]
args = String[]
if haskey(ENV, "http_proxy")
    push!(args, "--proxy")
    push!(args, ENV["http_proxy"])
end
push!(args, "install")
push!(args, "--user")
append!(args, PACKAGES)

pip.main(args)
