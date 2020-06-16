# EHTIM

A thin wrapper for ehtim (eht-imaging) Python package, see https://github.com/achael/eht-imaging

## Installation

You have to install ehtim Python package manually. Maybe it is easiest to first install miniconda2 and set PyCall to use it, e.g.
```julia
ENV["PYTHON"] = "/home/kjwiik/miniconda2/bin/python
] add PyCall Pkg
Pkg.build("PyCall")
```
Then install ehtim and pynfft in miniconda2 environment:
```
conda install -c conda-forge pynfft
pip install ehtim
```

## Usage

```julia
eht = EHTIM.new()
testdata = eht.obsdata.load_uvfits("test.uvf", polrep="circ")
tstokes = testdata.copy().switch_polrep("stokes")
tstokes.plot_bl("AA","AP","amp",color="blue",legend=true,label="AA-AP")

 = tstokes.unpack_bl("AA","AP","amp")

```

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://KajWiik.github.io/EHTIM.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://KajWiik.github.io/EHTIM.jl/dev)
[![Build Status](https://travis-ci.com/KajWiik/EHTIM.jl.svg?branch=master)](https://travis-ci.com/KajWiik/EHTIM.jl)
[![Coverage](https://codecov.io/gh/KajWiik/EHTIM.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/KajWiik/EHTIM.jl)
