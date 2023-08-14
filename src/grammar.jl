export Grammar

# Context-Free Grammar
struct Grammar{Tchar,Tweight}
    start :: Symbol
    empty :: Symbol
    nonterminals :: Vector{Symbol}
    alphabet :: Vector{Tchar}
    prod :: Vector{Tuple{Symbol, Vector{Union{Symbol,Int}}}}
    weights :: Vector{Tweight}

    function Grammar{Tchar,Tweight}(
        start::Symbol,
        empty::Symbol,
        prod::Vector{Tuple{Symbol, Vector, Tweight}}
        ) where {Tchar, Tweight}
        if Tchar isa Symbol
            error("Tchar can't be Symbol")
        end
        # collect all nonterminals and the alphabet, convert
        # productions to internal format
        nonterminals = Symbol[]
        alphabet = Tchar[]
        newprod = Tuple{Symbol, Vector{Union{Symbol,Int}}}[]
        weights = Tweight[]
        for (nt, res, weight) in prod
            newres = Union{Symbol,Int}[]
            for s in res
                if s isa Symbol
                    push!(nonterminals, s)
                    push!(newres, s)
                elseif s isa Tchar
                    push!(alphabet, s)
                    # TODO: just use length(alphabet) ?
                    push!(newres, findfirst(c -> c == s, alphabet))
                else
                    error("illegal entry $s of type $(typeof(s)) in production")
                end
            end
            push!(weights, weight)
            push!(newprod, (nt, newres))
        end
        return new{Tchar,Tweight}(start, empty, nonterminals, alphabet, newprod, weights)
    end

    Grammar{Tchar,Tweight}(start, prod) where {Tchar,Tweight} = Grammar{Tchar,Tweight}(start, :ε, prod)
    Grammar(prod) = Grammar{Char, Float64}(:S, :ε, prod)
end
