module Logomaker

import LazyArtifacts
using DataFrames: DataFrame
using LazyArtifacts: @artifact_str
using PythonCall: pycopy!
using PythonCall: pydict
using PythonCall: pyimport
using PythonCall: pylist
using PythonCall: pynew
using PythonCall: pytable

const logomaker = pynew()
#const pandas = pynew()

function __init__()
    pycopy!(logomaker, pyimport("logomaker"))
    #pycopy!(pandas, pyimport("pandas"))
end

"""
    Logo(weights, chars; positions=1:size(weights, 2), kwargs...)

Create a `logomaker.Logo` object from a Julia matrix.

`weights` must have one row per character in `chars`, and one column per
position. The keyword argument `positions` sets the DataFrame index used by
Python Logomaker (x-axis positions). Additional keyword arguments are passed to
`logomaker.Logo`.
"""
function Logo(
    weights::AbstractMatrix{<:Real}, chars::AbstractVector{<:AbstractChar};
    positions::AbstractVector = 1:size(weights, 2), kwargs...
)
    @assert size(weights) == (length(chars), length(positions))
    df = DataFrame(
        Dict(Symbol(c) => w for (c, w) in zip(chars, eachrow(weights)))
    )
    pydf = pytable(df; index=positions)
    return logomaker.Logo(pydf; kwargs...)
end

"""
    style_spines!(logo; spines=["top", "bottom", "left", "right"], visible=true, color="black", linewidth=1.0, bounds=nothing)

Style axis spines on a `logomaker.Logo` object.

This is a Julia wrapper around `logo.style_spines(...)`.
"""
function style_spines!(
    logo;
    spines::AbstractVector{<:AbstractString} = ["top", "bottom", "left", "right"],
    visible::Bool = true,
    color = "black",
    linewidth::Real = 1.0,
    bounds = nothing
)
    logo.style_spines(
        spines = pylist(spines),
        visible = visible,
        color = color,
        linewidth = linewidth,
        bounds = bounds
    )
end

"""
    style_xticks!(logo; anchor=0, spacing=1, fmt="%d", rotation=0.0)

Style x-axis ticks on a `logomaker.Logo` object.

This is a Julia wrapper around `logo.style_xticks(...)`.
"""
function style_xticks!(
    logo;
    anchor::Int = 0,
    spacing::Int = 1,
    fmt = "%d",
    rotation::Real = 0.0
)
    logo.style_xticks(
        anchor = anchor,
        spacing = spacing,
        fmt = fmt,
        rotation = rotation
    )
end

"""
    list_color_schemes()

List color schemes available in the Python `logomaker` package.
"""
function list_color_schemes()
    logomaker.list_color_schemes()
end

"""
    color_scheme(pairs...)

Build a Python dictionary for the `color_scheme` keyword accepted by
[`Logo`](@ref). Pass character-to-color pairs like `'A' => "blue"`.
"""
function color_scheme(pairs::Pair{<:AbstractChar, <:AbstractString}...)
    return pydict(Dict(pairs))
end

"""
    __example_fasta()

Return the bundled path to an example RFAM FASTA alignment used in docs.
"""
function __example_fasta()
    return joinpath(artifact"RF00162_trimmed", "RF00162-trimmed.afa")
end

end # module
