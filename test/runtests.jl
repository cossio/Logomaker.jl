module aqua_tests include("aqua.jl") end

using Test: @test

# use doc file as test ... just check that it runs in all platforms tested on CI
include("../docs/src/literate/rfam.jl")
