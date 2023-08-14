import Aqua
using PCFGs

@testset "Aqua.test_all" begin
    showtestset()
    Aqua.test_all(PCFGs)
end
