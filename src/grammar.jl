export Grammar

# Context-Free Grammar
struct Grammar{Tchar,Tweight}
    start :: Symbol
    empty :: Symbol
    nonterminals :: Vector{Symbol}
    alphabet :: Vector{Tchar}
    prod :: Vector{Tuple{Symbol, Vector{Union{Symbol,Int}}}}
    weights :: Vector{Tweight}
end

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
    for (nt, rhs, weight) in prod
        newrhs = Union{Symbol,Int}[]
        for s in rhs
            if s isa Symbol
                if s ∉ nonterminals
                    push!(nonterminals, s)
                end
                push!(newrhs, s)
            elseif s isa Tchar
                if s ∉ alphabet
                    push!(alphabet, s)
                end
                # TODO: just use length(alphabet) ?
                push!(newrhs, findfirst(c -> c == s, alphabet))
            else
                error("illegal entry $s of type $(typeof(s)) in production")
            end
        end
        push!(weights, weight)
        push!(newprod, (nt, newrhs))
    end
    return Grammar{Tchar,Tweight}(start, empty, nonterminals, alphabet, newprod, weights)
end

Grammar{Tchar,Tweight}(start, prod) where {Tchar,Tweight} = Grammar{Tchar,Tweight}(start, :ε, prod)

Grammar(prod) = Grammar{Char, Float64}(:S, :ε, prod)

function Base.show(io::IO, mime::MIME"text/plain", g::Grammar)
    println(io, "Start symbol: $(g.start)")
    println(io, "Empty symbol: $(g.empty)")
    println(io, "Nonterminals: $(g.nonterminals)")
    println(io, "Alphabet    : $(g.alphabet)")
    println(io, "Productions")
    for (i, (nt, rhs)) in enumerate(g.prod)
        rhs_str = join(map(x -> x isa Int ? g.alphabet[x] : ":" * String(x), rhs), " ")
        println(io, "    :$nt -> $rhs_str    [$(g.weights[i])]")
    end
end
