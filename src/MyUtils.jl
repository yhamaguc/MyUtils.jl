module MyUtils
    using DataFrames
    using DataFramesMeta

    include("dataframes.jl")
    include("paths.jl")
    include("strings.jl")

    export nest, unnest, group_concat, here, camel_to_snake, na2missing
end
