module MyUtils
    using DataFrames
    using DataFramesMeta

    include("dataframes.jl")
    include("paths.jl")
    include("strings.jl")

    export nest, unnest, groupconcat, here, cameltosnake, natomissing
end
