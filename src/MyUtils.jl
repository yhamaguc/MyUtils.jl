module MyUtils
    using DataFrames
    using DataFramesMeta
    using Statistics
    using Counters

    include("dataframes.jl")
    include("paths.jl")
    include("strings.jl")
    include("base.jl")

    export unite, nest, enframe, deframe, unnest, groupconcat, representative, here, fromhere, cameltosnake, tomissing, frommissing, isnumeric, renametolower!, skipoutlier
end
