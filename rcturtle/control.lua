local sid = tonumber(...)
local dkeys = {}
dkeys[keys.w]="fd"
dkeys[keys.a]="lt"
dkeys[keys.s]="bk"
dkeys[keys.d]="rt"
dkeys[keys.q]="up"
dkeys[keys.e]="dn"
dkeys[keys.r]="dd"
dkeys[keys.t]="d"
dkeys[keys.y]="du"
dkeys[keys.f]="pd"
dkeys[keys.g]="p"
dkeys[keys.h]="pu"
dkeys[keys.v]="end"
local doit = false
local keykeys={keys.w,keys.a,keys.s,keys.d,keys.q,keys.e,keys.r,keys.t,keys.y,keys.f,keys.g,keys.h,keys.v}
function check_key(k)
    for i=1,#keykeys do
        if k==keykeys[i] then
            return true
        end
    end
    return false
end
rednet.open("back")
function send()
    while true do
        term.clear()
        term.setCursorPos(1,1)
        print("RC Go")
        print("-----")
        print("WASD - same as Minecraft")
        print("Q - Up")
        print("E - Down")
        print("R,T,Y - Dig up,straight and down")
        print("F,G,H - Place up,straight and down")
        print("P - pick slot")
        print("V - end control")
        local _,key = os.pullEvent("key")
        if check_key(key) then
            rednet.send(sid,dkeys[key],"remote")
            if dkeys[key]=="end" then os.pullEvent("char") return end
        else
            if key==keys.p then
                os.pullEvent("char")
                doit = true
                write("Slot: ")
                local slotnum = tonumber(read())
                while slotnum<1 or slotnum>16 do
                    write("Try again: ")
                    slotnum = tonumber(read())
                end
                rednet.send(sid,"slot "..tostring(slotnum),"remote")
                doit = false
            end
        end
    end
end
function wait()
    while true do
        local _,k = os.pullEvent("key")
        if not doit then
            if k==keys.backspace then return end
        end
    end
end
parallel.waitForAny(send,wait)
rednet.close("back")
