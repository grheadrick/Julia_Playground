function take_a_breath()
    sleep(22*1e-3)
    return
end

function test8()
    r = zeros(100, 100)
    take_a_breath()
    for i in 1:100
        A=rand(100,100)
        r+=A
    end
    return r
end

test8()
@profiler test8()

"""
using Profile
test8()
Profile.clear()
@profile test8()
Profile.print()
"""
