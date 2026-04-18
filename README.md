# Logomaker Julia package

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://cossio.github.io/Logomaker.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://cossio.github.io/Logomaker.jl/dev)

A Julia wrapper of the [Logomaker](https://logomaker.readthedocs.io/en/latest/index.html) Python package to plot sequence logos.

## Installation

```julia
import Pkg
Pkg.add("Logomaker")
```

## Quick start

```julia
import Logomaker, PythonCall

color_scheme = PythonCall.pydict(Dict('A' => "blue", 'C' => "gold", 'G' => "green", 'U' => "red", '-' => "gray"))

# weights is a matrix containing scores, e.g. conservation.
logo = Logomaker.Logo(weights, collect("ACGU-"); color_scheme)
logo.ax.set_ylim(0, log2(5))
logo.fig
```

![Example sequence logo](/example.svg)

For a complete example based on an RFAM alignment, see:

- stable docs: <https://cossio.github.io/Logomaker.jl/stable/>
- dev docs: <https://cossio.github.io/Logomaker.jl/dev/>

## Main API

- `Logomaker.Logo`
- `Logomaker.style_spines!`
- `Logomaker.style_xticks!`
- `Logomaker.list_color_schemes`
- `Logomaker.color_scheme`

## Related

* https://github.com/cossio/MakieSequenceLogos.jl
