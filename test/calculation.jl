@testset "calculation.jl" begin
    IM = BasicProgrammingNCUES1121.InterMemberScore()
    vs = [5, 3, 1, 4]
    @test mean(vs, IM) == mean([5, 3, 1, 4])

    vs = [5, 3, 1]
    @test mean(vs, IM) == mean([5, 3, 1, 5])
end
