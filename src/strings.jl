function cameltosnake(s::AbstractString)
    matches = [m.match for m in eachmatch(r"([A-Z][a-z]+)", s)]
    for m in matches
        s = replace(s, m => "_" * m)
    end
    s = replace(s, r"([^A-Z])([A-Z])" => s"\1_\2")
    s = replace(s, r"(_)+" => "_")
    s = replace(s, r"^_" => "")

    return lowercase(s)
end


function tomissing(s::AbstractString, from="")
    return (strip(s) == from ? missing : s)
end


function tonan(s::AbstractString, from="")
    return (strip(s) == from ? NaN : s)
end


function frommissing(x::Any, to="")
    if !ismissing(x)
        return x
    end

    return to
end