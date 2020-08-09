
#Type annotations
#https://techytok.com/code-optimisation-in-julia/

function test1(x::Int)
    println("$x is an Int")
end

function test1(x::Float64)
    println("$x is a Float64")
end

function test1(x)
    println("$x is a default")
end

test2(x) = println("$x is a ", typeof(x))


"""
This is a bad function because of type instability.
The zero will always be of type Int64
"""
function BAD_GreaterThanZero(x)
    if x>0
        return x
    else
        return 0
    end
end


function GreaterThanZero(x)
    if x>0
        return x
    else
        return zero(x)
    end
end


myInt = 234
myFloat = .123
myString = "My String"

println("\n")
test1(myInt)
test1(myFloat)
test1(myString)

test2(myInt)

#Use macro to warn of type instability
#@code_warntype BAD_GreaterThanZero(myFloat)

#%%
a = 2
println(typeof(a))
b = convert(Float64, a)
println(typeof(b))
