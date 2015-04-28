
nobs(o::OnlineStat) = o.n


update!{T<:Real}(o::ScalarStat, y::Vector{T}) = (for yi in y; update!(o, yi); end)

function Base.merge(o1::OnlineStat, o2::OnlineStat)
    o1copy = copy(o1)
    merge!(o1copy, o2)
    o1copy
end


#------------------------------------------------------------# ScalarOnlineStat
function Base.show(io::IO, o::ScalarStat)
    snames = statenames(o)
    svals = state(o)

    # @printf(io, "Online %s\n", string(typeof(o)))
    println(io, "Online ", string(typeof(o)))
    # for i in 1:length(snames)
    for (i, sname) in enumerate(snames)
        @printf(io, " * %s:  %f\n", sname, svals[i])
    end
    # @printf(io, " * nobs:  %d\n", nobs(o))
end


# Why doesn't this work in 0.3.7?
# DataFrame(o::ScalarStat) = DataFrame(state(o), statenames(o))

function DataFrame(o::ScalarStat)
    df = convert(DataFrame, state(o)')
    names!(df, statenames(o))
end

Base.push!(df::DataFrame, o::ScalarStat) = push!(df, state(o))