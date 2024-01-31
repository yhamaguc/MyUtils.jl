function nest(x::GroupedDataFrame{DataFrame})
    _df = DataFrame(keys(x))
    @transform(
        _df,
        :data = map(x -> select(DataFrame(x), Not(names(_df))), collect(x))
    )
end


function unnest(x::AbstractDataFrame, column=:data)
    _f = typeof(first(x[:, column])) == DataFrame ? nrow : length

    _nvalues = _f.(x[:, column])
    _keys_grouped = select(x, Not(column))
    _keys_ungrouped = reduce(
        vcat,
        [repeat(DataFrame(k), n) for (k, n) in zip(eachrow(_keys_grouped), _nvalues)]
    )
    _data = reduce(vcat, (x[!, column]))

    hcat(_keys_ungrouped, _data)
end


function groupconcat(x, delimiter=";"; makesorted=false, makeunique=false)
    if (all(ismissing(x)))
        return missing
    end
    x = collect(skipmissing(x))
    if (makesorted)
        sort!(x)
    end
    if (makeunique)
        unique!(x)
    end
    return join(x, delimiter)
end
