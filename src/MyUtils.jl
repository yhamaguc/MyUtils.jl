module MyUtils
    using DataFrames
    using DataFramesMeta

    include("dataframes.jl")
    include("paths.jl")
    include("strings.jl")
    include("base.jl")

    export unite, nest, unnest, groupconcat, here, fromhere, cameltosnake, tomissing, frommissing, isnumeric
end
