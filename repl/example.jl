#=
# Logomaker example with RFAM
=#

import FASTX
import PythonPlot
using LogExpFunctions: xlogx
using Logomaker: __example_fasta
using Logomaker: Logo
using Statistics: mean

# Fetch RNA family alignment RF00162 from RFAM, trimmed by removing insertions.
fasta_path = __example_fasta()
records = collect(FASTX.FASTA.Reader(open(fasta_path)))
seqs = FASTX.sequence.(records)

# RNA nucleotides
NTs = "ACGU-"
#NTs = "ACGU⊟"
#NTs = "ACGUX"

# One-hot representation
function onehot(s::AbstractString)
    return reshape(collect(s), 1, length(s)) .== collect("ACGU-")
end
X = reshape(reduce(hcat, onehot.(seqs)), 5, :, length(seqs))

# Compute conservation scores
p = dropdims(mean(X; dims=3); dims=3)
H = sum(-xlogx.(p) / log(2); dims=1)
cons = p .* (log2(5) .- H)

# Plot sequence logo!
fig, ax = PythonPlot.subplots(1, 1, figsize=[8, 3])
logo = Logo(-cons, collect("ACGU⊟"); color_scheme="classic", ax)
logo.ax.set_ylim(-log2(5), log2(5))
logo.fig
