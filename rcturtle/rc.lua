local rid = tonumber(...)
rednet.open("right")
function recv()
    while true do
        local id,msg = rednet.receive("remote")
        if id==rid then
--          print(msg)
            if msg=="end" then return else
            shell.run("rcgo "..msg)
--          print(msg)
            end
        end
    end
end

parallel.waitForAny(recv,function() os.pullEvent("char") end)
