@testset "convertnothing" begin
    using DataFrames
    df = DataFrame(
        :a => [missing, nothing, 1, 2],
        :b => [missing, "nothing", 1, 2],
        :c => [3, nothing, 1, 2],
    )
    df2 = BasicProgrammingNCUES1121.convertnothing(df)
    @test isequal(df2.a, df.a)
    @test isequal(df2.b, [missing, nothing, 1, 2])
    @test isequal(df2.c, df.c)
end
