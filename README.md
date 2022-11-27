# Logomaker Julia package

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://cossio.github.io/Logomaker.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://cossio.github.io/Logomaker.jl/dev)
![](https://github.com/cossio/Logomaker.jl/workflows/CI/badge.svg)
[![codecov](https://codecov.io/gh/cossio/Logomaker.jl/branch/master/graph/badge.svg?token=8MNRQ5INWP)](https://codecov.io/gh/cossio/Logomaker.jl)
![GitHub repo size](https://img.shields.io/github/repo-size/cossio/Logomaker.jl)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/cossio/Logomaker.jl)

A Julia wrapper of the [Logomaker](https://logomaker.readthedocs.io/en/latest/index.html) Python package to plot sequence logos.

```julia
import Logomaker

# weights is a matrix containing scores, e.g. conservation.

logo = Logomaker.Logo(weights, collect("ACGU-"); color_scheme="classic")
logo.ax.set_ylim(0, log2(5))
logo.fig
```

![Example sequence logo](/example.svg)

See the docs for a full example.