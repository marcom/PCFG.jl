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
        @test g.prod == [
            (:S, [:S, :S]),
            (:S, [1, :S, 2]),
        ]
        @test g.weights == [0.4, 0.6]
    end
end
