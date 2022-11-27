module Logomaker

using PythonCall: pynew, pycopy!, pyimport, pylist

const logomaker = pynew()
const pandas = pynew()

function __init__()
    pycopy!(logomaker, pyimport("logomaker"))
    pycopy!(pandas, pyimport("pandas"))
end

function logo(
    weights::AbstractMatrix{<:Real}, chars::AbstractVector{<:AbstractChar};
    positions = 1:size(weights, 2), kwargs...
)
    @assert size(weights, 1) == length(chars)
    @assert size(weights, 2) == length(positions)
    df = pandas.DataFrame(data=weights', columns=chars, index=positions)
    return logomaker.Logo(df; kwargs...)
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

end # module
