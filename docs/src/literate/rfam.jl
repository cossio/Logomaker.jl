#=
# Logomaker example with RFAM
=#

import FASTX
import PythonCall
using Logomaker: Logo
using Logomaker: __example_fasta
using Statistics: mean
using LogExpFunctions: xlogx

# Fetch RNA family alignment RF00162 from RFAM, trimmed by removing insertions.

fasta_path = __example_fasta()
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

color_scheme = PythonCall.pydict(Dict('A' => "blue", 'C' => "orange", 'G' => "green", 'U' => "red", '-' => "black"))
logo = Logo(cons, collect(NTs); color_scheme="classic")
logo.ax.set_ylim(0, log2(5))
logo.fig
