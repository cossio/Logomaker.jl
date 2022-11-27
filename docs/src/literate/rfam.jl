#=
# SequenceLogos examples with RFAM
=#

using Logomaker: Logo
using LazyArtifacts: LazyArtifacts, @artifact_str
using Statistics: mean
using LogExpFunctions: xlogx
import FASTX
using Base: front

# Fetch RNA family alignment RF00162 from RFAM (pre-stored as a Github Gist)
# (Trimmed means insertions have been removed).

fasta_path = joinpath(artifact"RF00162_trimmed", "RF00162-trimmed.afa")
records = collect(FASTX.FASTA.Reader(open(fasta_path)))
seqs = FASTX.sequence.(records)
nothing #hide

# RNA nucleotides

NTs = "ACGU-"
nothing #hide

# One-hot representation

function onehot(s::AbstractString)
    return reshape(collect(s), 1, length(s)) .== collect(NTs)
end
X = reshape(reduce(hcat, onehot.(seqs)), length(NTs), :, length(seqs))
nothing #hide

# Compute conservation scores

p = reshape(mean(X; dims=3), size(X, 1), size(X, 2))
H = sum(-xlogx.(p) / log(2); dims=1)
cons = p .* (log2(5) .- H)
nothing #hide

# Plot sequence logo!

logo = Logo(cons, collect(NTs); color_scheme="classic")
logo.ax.set_ylim(0, log2(5))
logo.fig
