import Aqua
import Logomaker

using Test: @testset

@testset verbose = true "aqua" begin
    Aqua.test_all(Logomaker; ambiguities = false)
end
