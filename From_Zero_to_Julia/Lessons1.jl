
"""
Functions
"""

function plus_two(x)
    return x+2
end

plus_three(x) = x+3
plus_four = x -> x+4

#%%
"""
More on anonymous functions
"""

using QuadGK
f(x,y,z) = (x^2 + 2y)*z
arg(x) = f(x,42,4)

quadgk(arg, 3, 4)



#%%
@doc raw"""
    func_square(x)

Computes the square of x

#Example
```julia-repl
blah
```
"""
function func_square(arr)
    arr2 = zeros(length(arr))
    @inbounds for (ind, element) in enumerate(arr)
        arr2[ind] = element^2
    end
    return arr2
end

data = rand(Float64, 10^6)
@btime func_square($data)

#%%
"""
Matrix multiplication
"""

a = [1, 2, 3]   #column
b = [4, 5, 6]   #column
c = [7  8  9]   #row

println("a*c = ", a*c)  #3x3 matrix
println("c*a = ", c*a)  # = 50

println("\n\n")

g = reshape([1,2,3,4,5,6,7,8,9],3,3)
println("g*a = ", g*a)

print("\n\n")

println("a.*c= ", a.*c) #3x3
println("c.*a= ", c.*a) #3x3

"""
 _     _    _ _
| 1 4 7 |  | 1 |
| 2 5 8 | *| 2 |
| 3 6 9 |  | 3 |
 -     -    - -
number of columns of first matrix needs to equal number of rows of second
"""


#%%
"""
Scope / Module
"""

module ScopeTestModule
    export a1
    a1 = 25
    b1 = 45
end

using .ScopeTestModule

module MyModule

    @doc raw"""
        Mysquare(x)

    Computes the sqaure of 'x'

    # Examples
    ```julia-reple
    julia> using.MyModule
    julia> Mysqaure(2)
    4
    ```
    """
    function Mysquare(x)
        return x^2
    end

    function factorial(x)
        return x!
    end
end

module MyBigModule
    include("test_module_1.jl")

    export fun1big
end


print(MyModule.Mysquare(2))

#%%
"""
Types
"""

abstract type Person

end

abstract type Musician <: Person
end

mutable struct Physicist <: Person
    name::String
    sleepHours::Float64
    favoriteLanguage::String
end

mutable struct Rockstar <: Musician     #conrete struct whos value can be modified
    name::String
    instrument::String
    bandname::String
    headbandColor::String
    instrumentsPlayed::Int
end

struct ClassicalMusician <: Musician      #will never change
    name::String
    instrument::String
end


Grant = Physicist("Grant", 7, "Julia")
Grant_musician = ClassicalMusician("Grant", "Piano")

Ricky = Rockstar("Ricky", "Voice", "Black Lotus", "red", 2)

function introduceMe(person::Person)
    println("Hello, my name is $(person.name)")
end

function introduceMe(person::Musician)
    println("Hello, my name is $(person.name) and I play $(person.instrument)")
end

introduceMe(Ricky)
introduceMe(Grant_musician)


mutable struct MyData
    x::Float64
    x2::Float64
    y::Float64
    z::Float64
    function MyData(x::Float64, y::Float64)
        x2=x^2
        z = sin(x2+y)
        new(x, x2, y, z)
    end
end

mutable struct MyData2{T<:Real}
    x:: T
    x2::T
    y:: T
    z:: T
    function MyData2{T}(x::T, y::T)
        x2=x^2
        z = sin(x2+y)
        new(x, x2, y, z)
    end
end

#MyData(2.0, 3.0)


#%%

module TestModuleTypes

export Circle, computePerimeter, computeArea, printCircleEquation

mutable struct Circle{T<:Real}
	radius::T
	perimeter::Float64
	area::Float64

	function Circle{T}(radius::T) where T<:Real
		# we initialize perimeter and area to -1.0, which is not a possible value
		new(radius, -1.0, -1.0)
	end
end

@doc raw"""
	computePerimeter(circle::Circle)

Compute the perimeter of `circle` and store the value.
"""
function computePerimeter(circle::Circle)
	circle.perimeter = 2*π*circle.radius
	return circle.perimeter
end

@doc raw"""
	computeArea(circle::Circle)

Compute the area of `circle` and store the value.
"""
function computeArea(circle::Circle)
	circle.area = π*circle.radius^2
	return circle.area
end

@doc raw"""
	printCircleEquation(xc::Real, yc::Real, circle::Circle )

Print the equation of a cricle with center at (xc, yc) and radius given by circle.
"""
function printCircleEquation(xc::Real, yc::Real, circle::Circle )
	println("(x - $xc)^2 + (y - $yc)^2 = $(circle.radius^2)")
	return
end
end # end module

#%%

using .TestModuleTypes

circle1 = Circle{Float64}(5.0)

computePerimeter(circle1)
#println("Perimeter = $(circle1.perimeter)")

computeArea(circle1)
#println("Area = $(circle1.area)")

printCircleEquation(2, 3, circle1)
