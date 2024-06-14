function isnumeric(x)
    return isa(x, Int) || isa(x, Float64) || isa(x, Bool)
end


function skipoutlier(x)
    q1 = quantile(x, 0.25)
    q3 = quantile(x, 0.75)
    iqr = q3 - q1

    lower_bound = q1 - 1.5 * iqr
    upper_bound = q3 + 1.5 * iqr

    return filter(x -> (x >= lower_bound && x <= upper_bound), x)
end
