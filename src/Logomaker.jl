module Logomaker

using PythonCall: pynew, pycopy!, pyimport, pylist, pytable
using DataFrames: DataFrame
using LazyArtifacts: LazyArtifacts, @artifact_str

const logomaker = pynew()
#const pandas = pynew()

function __init__()
    pycopy!(logomaker, pyimport("logomaker"))
    #pycopy!(pandas, pyimport("pandas"))
end

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

function __example_fasta()
    return joinpath(artifact"RF00162_trimmed", "RF00162-trimmed.afa")
end

end # module
