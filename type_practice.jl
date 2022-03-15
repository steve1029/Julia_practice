mutable struct TypeExample
    a::Int64
    b::Float64
    #c = zeros(Float64, 5)
end

x = TypeExample(3,4)
println(x.a)
println(x.b)

function multiplier(xx::TypeExample)
   xx.a *= 2 
   xx.b *= 2
   println(xx.a)
end

multiplier(x)