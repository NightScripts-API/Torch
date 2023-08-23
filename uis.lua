local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/cerberus.lua"))()

local window = Library.new("Torch | Private") -- Args(<string> Name, <boolean?> ConstrainToScreen, <number?> Width, <number?> Height, <string?> VisibilityToggleKey)

window:LockScreenBoundaries(true) -- Args(<boolean> ConstrainToScreen)

local main = window:Tab("Main") -- Args(<string> Name, <string?> TabImage)
local misc = window:Tab("Misc") -- Args(<string> Name, <string?> TabImage)
local credits = window:Tab("Credits") -- Args(<string> Name, <string?> TabImage)

local section = main:Section("Silent Aimlock") -- Args(<string> Name)

local title = section:Title("Title") -- Args(<string> Name)
title:ChangeText("Silent Prediction") -- Args(<String> NewText)





section:Button("Enable Torch", function()
    local Settings = {
    AimLock = {
        Enabled = true,
        Aimlockkey = "c",
        Prediction = 0.130340,
        Aimpart = "HumanoidRootPart",
        Notifications = true
    },
    Settings = {
		Thickness = 4.0, 
		Transparency = 0.7, 
		Color = Color3.fromRGB(255, 86, 23),
		 FOV = true
		}
}
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local Inset = game:GetService("GuiService"):GetGuiInset().Y
local RunService = game:GetService("RunService")
local Mouse = game.Players.LocalPlayer:GetMouse()
local LocalPlayer = game.Players.LocalPlayer
local Line = Drawing.new("Line")
local Circle = Drawing.new("Circle")
local Plr = game.Players.LocalPlayer
Mouse.KeyDown:Connect(
    function(KeyPressed)
        if KeyPressed == (Settings.AimLock.Aimlockkey) then
            if Settings.AimLock.Enabled == true then
                Settings.AimLock.Enabled = false
                if Settings.AimLock.Notifications == true then
                    Plr = FindClosestPlayer()
                    game.StarterGui:SetCore("SendNotification", {Title = "Torch (Pixi)", Text = "Unlocked"})
                end
            else
                Plr = FindClosestPlayer()
                Settings.AimLock.Enabled = true
                if Settings.AimLock.Notifications == true then
                    game.StarterGui:SetCore(
                        "SendNotification",
                        {Title = "Torch (Pixi)", Text = "Locked On : " .. tostring(Plr.Character.Humanoid.DisplayName)}
                    )
                end
            end
        end
    end
)
function FindClosestPlayer()
    local ClosestDistance, ClosestPlayer = math.huge, nil
    for _, Player in next, game:GetService("Players"):GetPlayers() do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            if Character and Character.Humanoid.Health > 1 then
                local Position, IsVisibleOnViewPort =
                    CurrentCamera:WorldToViewportPoint(Character.HumanoidRootPart.Position)
                if IsVisibleOnViewPort then
                    local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestPlayer = Player
                        ClosestDistance = Distance
                    end
                end
            end
        end
    end
    return ClosestPlayer, ClosestDistance
end
RunService.Heartbeat:connect(
    function()
        if Settings.AimLock.Enabled == true then
            local Vector =
                CurrentCamera:WorldToViewportPoint(
                Plr.Character[Settings.AimLock.Aimpart].Position +
                    (Plr.Character[Settings.AimLock.Aimpart].Velocity * Settings.AimLock.Prediction)
            )
            Line.Color = Settings.Settings.Color
            Line.Transparency = Settings.Settings.Transparency
            Line.Thickness = Settings.Settings.Thickness
            Line.From = Vector2.new(Mouse.X, Mouse.Y + Inset)
            Line.To = Vector2.new(Vector.X, Vector.Y)
            Line.Visible = true
            Circle.Position = Vector2.new(Mouse.X, Mouse.Y + Inset)
            Circle.Visible = Settings.Settings.FOV
            Circle.Thickness = 1.5
            Circle.Thickness = 2
            Circle.Radius = 60
            Circle.Color = Settings.Settings.Color
        elseif Settings.AimLock.FOV == true then
            Circle.Visible = true
        else
            Circle.Visible = false
            Line.Visible = false
        end
    end
)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall =
    newcclosure(
    function(...)
        local args = {...}
        if Settings.AimLock.Enabled and getnamecallmethod() == "FireServer" and args[2] == "MousePos" then
            args[3] =
                Plr.Character[Settings.AimLock.Aimpart].Position +
                (Plr.Character[Settings.AimLock.Aimpart].Velocity * Settings.AimLock.Prediction)
            return old(unpack(args))
        end
        return old(...)
    end
)

end) -- Args(<String> Name, <Function> Callback)



local label = section:Label("Label") -- Args(<String> LabelText, <Number?> TextSize, <Color3?> TextColor)
label:ChangeText("Silent Settings") -- Args(<String> NewText, <Boolean?> PlayAnimation)



local section = tab:Section("Movement") -- Args(<string> Name)

local title = section:Title("Title") -- Args(<string> Name)
title:ChangeText("Movement") -- Args(<String> NewText)




