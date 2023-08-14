using Test

# show which testset is currently running
showtestset() = println(" "^(2 * Test.get_testset_depth()), "testing ",
                        Test.get_testset().description)

@testset verbose=true "PCFGs" begin
    showtestset()
    include("grammar.jl")
    include("aqua.jl")
end
