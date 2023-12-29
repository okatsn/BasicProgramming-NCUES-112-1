"""
Calculate the mean of inter-member score. If
"""
function Statistics.mean(vs, ::InterMemberScore)
    nmax = 4
    lenv = length(vs)
    if lenv < 1
        error("No scores for this member. This should not happen.")
    end
    @assert lenv <= nmax "One student cannot be evaluated by more than $nmax member."
    @assert all(in.(vs, Ref(1:5))) "InterMemberScore should be 1:5"
    # total number of members are nmax
    V = fill(5, nmax) # default score is 5
    V[1:lenv] = vs
    return mean(V)
end
