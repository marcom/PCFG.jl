using PCFGs: Grammar

@testset "Grammar" begin
    showtestset()

    for g in [
        Grammar(                      [(:S, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)]),
        Grammar{Char,Float64}(:S,     [(:S, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)]),
        Grammar{Char,Float64}(:S, :ε, [(:S, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)]),
        ]
        @test g isa Grammar
        @test g isa Grammar{Char,Float64}
        @test g.start == :S
        @test Set(g.nonterminals) == Set([:S])
        @test Set(g.alphabet) == Set(['(', ')'])
        @test length(g.weights) == 2
    end
end
