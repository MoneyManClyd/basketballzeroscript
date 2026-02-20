-- [[ ZEN GUIDANCE REMASTERED ]] --
-- Check for script updates and authenticate...

local Success, Error = pcall(function()
    -- This downloads and runs the script directly from your GitHub
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YourName/Zen-Scripts/main/main.lua"))()
end)

if not Success then
    warn("Failed to load Zen Guidance: " .. tostring(Error))
    print("Please check your internet connection or join the Discord.")
end

-- If a "skid" tries to decompile this, they just get the task.wait spam below
-- to frustrate them and hide the link in a wall of junk.

for i = 1, 50 do
    task.wait() -- Junk Code Injection
end
