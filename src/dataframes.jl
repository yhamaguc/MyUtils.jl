function unite(X::AbstractDataFrame, column_to, columns_from, sep="-"; drop=true)
    _value = (x) -> string.(X[!, x])
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


function unnest(X::AbstractDataFrame, columns=[:data])
    if !isa(columns, AbstractVector)
        columns = [columns]
    end

    _n = (x) -> size(x)[1]
    _ntimes = _n.(X[:, columns[1]])

    # TODO:
    # Check target columns content length
    # _nisnotequal = nrow(@rsubset(transform(_nvalues, columns => ByRow(==) => :isequal), !:isequal))

    # if _nisnotequal > 0
    #     @info "Unnesting data lengths are not equal"
    #     return missing
    # end

    _keys = select(X, Not(columns))
    _unnested = reduce(
        vcat,
        [repeat(DataFrame(k), n) for (k, n) in zip(eachrow(_keys), _ntimes)]
    )

    if length(columns) > 1
        _data =  @chain X[!, columns] begin
            transform(columns => ByRow(hcat) => :data)
            select(:data)
        end

        _data = reduce(vcat, _data.data)
    else
        _data = reduce(vcat, X[!, columns...])
    end

    _unnested = hcat(_unnested, _data)

    return _unnested
end


# NOTE: Used in combine clause
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


# NOTE: Used in combine clause
representative = x -> x[begin]


function deframe(X::AbstractDataFrame)
    Dict(k => v for (k, v) in zip(X[!, 1], X[!, 2]))
end


function enframe(d::Union{AbstractDict, Counter})
    DataFrame(:name => collect(keys(d)), :value => collect(values(d)))
end


function renametolower!(X::AbstractDataFrame)
    rename!(X, lowercase.(names(X)))
end
