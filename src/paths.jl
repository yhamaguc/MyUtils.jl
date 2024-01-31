function here()
    pwd_ = pwd()

    pwd_ = pwd_
    while true
        project_toml = joinpath(pwd_, "Project.toml")
        if isfile(project_toml)
            return dirname(project_toml)
        end

        parent_ = dirname(pwd_)

        if parent_ == pwd_
            break
        end

        pwd_ = parent_
    end

    return nothing
end


function here(s::AbstractString)
    return joinpath(here(), s)
end


function here(s...)
    return joinpath(here(), joinpath(s))
end


function here(x::Vector{String})
    return [joinpath(here(), i) for i in x]
end
