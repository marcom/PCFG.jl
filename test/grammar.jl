using PCFGs: Grammar

@testset "Grammar" begin
    showtestset()

    #g = Grammar(:S, :ε, [(:S, :ε, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)])
    #@test g isa Grammar

    #g = Grammar(:S, [(:S, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)])
    #@test g isa Grammar

    g = Grammar([(:S, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)])
    @test g isa Grammar
end
