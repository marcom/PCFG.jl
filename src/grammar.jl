export Grammar

# Context-Free Grammar
struct Grammar{Tchar,Tweight}
    start :: Symbol
    empty :: Symbol
    nonterminals :: Vector{Symbol}
    alphabet :: Vector{Tchar}
    prod :: Vector{Tuple{Symbol, Vector{Union{Symbol,Int}}, Tweight}}

    function Grammar{Tchar,Tweight}(
        start::Symbol,
        empty::Symbol,
        prod::Vector{Tuple{Symbol, Vector, Tweight}}
        ) where {Tchar, Tweight}
        if Tchar isa Symbol
            error("Tchar can't be Symbol")
        end
        # find all nonterminals and the alphabet
        nonterminals = Symbol[]
        alphabet = Tchar[]
        newprod = Tuple{Symbol, Vector{Union{Symbol,Int}}, Tweight}[]
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
            push!(newprod, (nt, newres, weight))
        end
        return new{Tchar,Tweight}(start, empty, nonterminals, alphabet, newprod)
    end

    Grammar{Tchar,Tweight}(start, prod) where {Tchar,Tweight} = Grammar{Tchar,Tweight}(start, :ε, prod)
    Grammar(prod) = Grammar{Char, Float64}(:S, :ε, prod)
end
