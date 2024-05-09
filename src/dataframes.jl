function unite(X::AbstractDataFrame, column_to, columns_from, sep="-"; drop=true)
    _value = (x) -> String.(X[!, x])
    _values = [_value(c) for c in columns_from]

    _concat = (x, y) -> x .* sep .* y

    _united = reduce(_concat, _values)

    X[!, column_to] = _united

    if drop
        X = select(X, Not(columns_from))
    end

    return X
end


function nest(X::GroupedDataFrame{DataFrame}, column=:data)
    _nested = DataFrame(keys(X))
    _nested[!, column] = map(X -> select(DataFrame(X), Not(names(_nested))), collect(X))

    return _nested
end


function unnest(X::AbstractDataFrame, column=:data)
    _f = typeof(first(X[:, column])) == DataFrame ? nrow : length

    _nvalues = _f.(X[:, column])
    _keys_grouped = select(X, Not(column))
    _unnested = reduce(
        vcat,
        [repeat(DataFrame(k), n) for (k, n) in zip(eachrow(_keys_grouped), _nvalues)]
    )
    _data = reduce(vcat, (X[!, column]))

    _unnested = hcat(_unnested, _data)

    return _unnested
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


function deframe(X::AbstractDataFrame)
    NamedArray(X[!, 2], X[!, 1])
end


function enframe(x)
    DataFrame(name = names(x)[1], value = values(x))
end
