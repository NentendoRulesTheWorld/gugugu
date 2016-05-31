local socket = require("socket")
 
local host = "0.0.0.0"
local port = "12345"
local server = assert(socket.bind(host, port, 1024))
server:settimeout(0)
local client_tab = {}
local conn_count = 0

--get local IP address
-- function GetAdd(hostname)
--     local ip, resolved = socket.dns.toip(hostname)
--     local ListTab = {}
--     for k, v in ipairs(resolved.ip) do
--         table.insert(ListTab, v)
--     end
--     return ListTab
-- end
-- print(unpack(GetAdd(socket.dns.gethostname())))
-- print(unpack(GetAdd('localhost')))

channel = love.thread.getChannel("server")
print("Server Start " .. host .. ":" .. port) 
while 1 do
    local conn = server:accept()
    if conn then
        conn_count = conn_count + 1
        client_tab[conn_count] = conn
        print(conn:getpeername())
        print("A client successfully connect!") 
    end
    for conn_count, client in pairs(client_tab) do
        local recvt, sendt, status = socket.select({client}, nil, 1)
        if #recvt > 0 then
            local receive, receive_status = client:receive()
            if receive_status ~= "closed" then
                if receive then
                    print("server get"..receive)
                    channel:push(receive)
                    for conn_count_, client_ in pairs(client_tab) do
                        assert(client_:send("Client " .. conn_count_ .. " Send : "))
                        assert(client_:send(receive .. "\n"))
                    end
                    print("Receive Client " .. conn_count .. " : ", receive)   
                end
            else
                table.remove(client_tab, conn_count) 
                client:close() 
                print("Client " .. conn_count .. " disconnect!") 
            end
        end
         
    end
end