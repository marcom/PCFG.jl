using PCFGs: Grammar

@testset "Grammar" begin
    g = Grammar([(:S, [:S, :S], 0.4), (:S, ['(', :S, ')'], 0.6)])
    @test g isa Grammar
end
