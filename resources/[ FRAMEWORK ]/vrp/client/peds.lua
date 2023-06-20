local localPeds = {}
----------------------------------------------------------------------
local pedList = {
	{ -- Spawn Aeroporto
		distance = 30,
		coords = { -1038.25, -2733.14, 20.17, 190.06 },
		model = { 0xFBF98469,"ig_mp_agent14" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Emprego Caminhoneiro
		distance = 30,
		coords = { 1202.04, -3267.5, 5.51, 226.09 },
		model = { 0xB3B3F5E6,"a_m_y_business_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
}
----------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if not IsPedInAnyVehicle(ped) then
					if localPeds[k] == nil then
						local mHash = GetHashKey(v["model"][2])

						RequestModel(mHash)
						while not HasModelLoaded(mHash) do
							Citizen.Wait(1)
						end

						localPeds[k] = CreatePed(4,v["model"][1],v["coords"][1],v["coords"][2],v["coords"][3] - 1,v["coords"][4],false,false)
						SetEntityInvincible(localPeds[k],true)
						FreezeEntityPosition(localPeds[k],true)
						SetBlockingOfNonTemporaryEvents(localPeds[k],true)

						if v["anim"][1] ~= nil then
							RequestAnimDict(v["anim"][1])
							while not HasAnimDictLoaded(v["anim"][1]) do
								Citizen.Wait(1)
							end

							TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,0.0,-1,1,0,0,0,0)
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)