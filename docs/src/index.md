# Logomaker.jl Documentation

A Julia wrapper of the [Logomaker](https://logomaker.readthedocs.io/en/latest/index.html) Python package to plot sequence logos.

## Installation

The package is registered and can be installed with:

```julia
import Pkg
Pkg.add("Logomaker")
```

## Quick usage

```julia
import Logomaker

chars = collect("ACGU-")
weights = rand(length(chars), 20)
logo = Logomaker.Logo(weights, chars)
logo.fig
```

## Where to go next

- See [Reference](@ref) for API docstrings.
- See **Examples → RFAM** in the docs sidebar for a full workflow.
- Source code: <https://github.com/cossio/Logomaker.jl>.
