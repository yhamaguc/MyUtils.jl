function isnumeric(x)
    return isa(x, Int) || isa(x, Float64) || isa(x, Bool)
end