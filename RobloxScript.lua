-- ===== AUTO BACKSTAB SYSTEM =====

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- SETTINGS
local BACKSTAB_DAMAGE = 150
local CHECK_DISTANCE = 5
local BACKSTAB_ANGLE = 60 -- smaller = stricter

local function isBehind(attackerRoot, targetRoot)
	local direction = (attackerRoot.Position - targetRoot.Position).Unit
	local targetLook = targetRoot.CFrame.LookVector
	
	local dot = direction:Dot(targetLook)
	return dot > math.cos(math.rad(BACKSTAB_ANGLE))
end

RunService.Heartbeat:Connect(function()
	for _, attacker in ipairs(Players:GetPlayers()) do
		local attackerChar = attacker.Character
		local attackerRoot = attackerChar and attackerChar:FindFirstChild("HumanoidRootPart")
		local attackerHum = attackerChar and attackerChar:FindFirstChildOfClass("Humanoid")
		
		if attackerRoot and attackerHum and attackerHum.Health > 0 then
			
			for _, target in ipairs(Players:GetPlayers()) do
				if target ~= attacker then
					
					local targetChar = target.Character
					local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
					local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")
					
					if targetRoot and targetHum and targetHum.Health > 0 then
						
						local distance = (attackerRoot.Position - targetRoot.Position).Magnitude
						
						if distance <= CHECK_DISTANCE then
							if isBehind(attackerRoot, targetRoot) then
								targetHum:TakeDamage(BACKSTAB_DAMAGE)
							end
						end
					end
				end
			end
		end
	end
end)
