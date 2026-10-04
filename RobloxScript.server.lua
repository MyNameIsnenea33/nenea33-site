-- Pune acest Script (nu LocalScript) în ServerScriptService.
-- Vehiculele stau direct în Workspace. Scriptul le recunoaște după un StringValue
-- numit "MapLabel", pus în interiorul vehiculului. Textul din el apare pe hartă.

local HttpService = game:GetService("HttpService")

local URL = "http://localhost:3000/update" -- după deploy: "https://numele-tau.onrender.com/update"
local KEY = "schimba-ma"                   -- aceeași valoare ca SECRET din server.js
local VALUE_NAME = "MapLabel"

local counter = 0

-- Copiile aceluiași model au același text, deci dăm fiecărui vehicul un id unic.
local function getId(car, label)
	local id = car:GetAttribute("MapId")
	if not id then
		counter += 1
		id = label .. "_" .. counter
		car:SetAttribute("MapId", id)
	end
	return id
end

local function round(n)
	return math.floor(n * 10 + 0.5) / 10
end

while true do
	local list = {}

	-- Verifică doar copiii direcți ai Workspace (ușor pentru server).
	for _, car in ipairs(workspace:GetChildren()) do
		local labelValue = car:FindFirstChild(VALUE_NAME)

		if labelValue and labelValue:IsA("StringValue") then
			local part = nil
			if car:IsA("Model") then
				part = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart", true)
			elseif car:IsA("BasePart") then
				part = car
			end

			if part then
				local vel = part.AssemblyLinearVelocity
				table.insert(list, {
					id = getId(car, labelValue.Value),
					label = labelValue.Value,
					x = round(part.Position.X),
					z = round(part.Position.Z),
					vx = round(vel.X),
					vz = round(vel.Z),
				})
			end
		end
	end

	local ok, err = pcall(function()
		return HttpService:RequestAsync({
			Url = URL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				["x-key"] = KEY,
			},
			Body = HttpService:JSONEncode({
				jobId = game.JobId ~= "" and game.JobId or "studio",
				vehicles = list,
			}),
		})
	end)

	if not ok then
		warn("Nu am putut trimite pozițiile: " .. tostring(err))
	end

	task.wait(1)
end
