local hwid;
_G.timeTowait = 30
task.spawn(function()
    local http_request = (syn and syn.request) or request;
    local body, decoded;
    body = http_request({Url = "https://httpbin.org/get", Method = "GET"})
    decoded = game:GetService("HttpService"):JSONDecode(body)
    
    for i, v in pairs(decoded.headers) do
        if string.find(i, "Fingerprint") then
            hwid = v;
            break
        end
    end
end)

local time = _G.timeTowait
local waited = 0;
while not hwid do
    if (waited > time) then
        warn("Can\'t get HWID. Try executing again.")
    end

    waited += 1
    task.wait(1)
end

print(hwid)
