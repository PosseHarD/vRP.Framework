function vRP.save_idle_custom(player,custom)
	local r_idle = {}
	local user_id = vRP.getUserId(player)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.cloakroom_idle == nil then
				data.cloakroom_idle = custom
			end

			for k,v in pairs(data.cloakroom_idle) do
				r_idle[k] = v
			end
		end
	end
	return r_idle
end

function vRP.removeCloak(player)
	local user_id = vRP.getUserId(player)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.cloakroom_idle ~= nil then
				vRPclient._setCustomization(player,data.cloakroom_idle)
				data.cloakroom_idle = nil
			end
		end
	end
end

function vRP.itemNameList(item)
	if items.list[item] ~= nil then
		return items.list[item].name
	end
end

function vRP.itemIndexList(item)
	if items.list[item] ~= nil then
		return items.list[item].index
	end
end

function vRP.itemTypeList(item)
	if items.list[item] ~= nil then
		return items.list[item].type
	end
end

function vRP.itemBodyList(item)
	if items.list[item] ~= nil then
		return items.list[item]
	end
end

vRP.items = {}

function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

RegisterServerEvent("clearInventoryTwo")
AddEventHandler("clearInventoryTwo",function(id)
    if id then
		local data = vRP.getUserDataTable(id)
		if data then
			data.inventory = {}
		end

		vRPclient._clearWeapons(id)
	end
end)

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
	local user_id = vRP.getUserId(source)
	
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

		vRP.upgradeThirst(user_id,100)
		vRP.upgradeHunger(user_id,100)
		vRP.upgradeStress(user_id,-100)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        vRP.setExp(user_id,"physical","strength",20)
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

local Proxy = module("vrp","lib/Proxy")
local garage = Proxy.getInterface("nation_garages")

--[ VEHICLEGLOBAL ]-------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleGlobal()
	return garage.getVehList()
end

--[ VEHICLENAME ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleName(vname)
	return garage.getVehicleModel(vname)
end

--[ VEHICLECHEST ]--------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleChest(vname)
	return garage.getVehicleTrunk(vname)
end

--[ VEHICLEPRICE ]--------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehiclePrice(vname)
	return garage.getVehiclePrice(vname)
end

--[ VEHICLETYPE ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleType(vname)
	return garage.getVehicleType(vname)
end

--[ ACTIVED ]-------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1
				if actived[k] <= 0 then
					actived[k] = nil
					activedAmount[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)

--[ SLOT INVENTORY ]------------------------------------------------------------------------------------------------------------------------------------

function vRP.verifySlots(user_id)
	if vRP.getExp(user_id,"physical","strength") == 1900 then -- 90Kg
		return 24
	elseif vRP.getExp(user_id,"physical","strength") == 1320 then -- 75Kg
		return 18
	elseif vRP.getExp(user_id,"physical","strength") == 670 then -- 51Kg
		return 12
	elseif vRP.getExp(user_id,"physical","strength") == 20 then -- 6Kg
		return 6
	end
end

function vRP.getRemaingSlots(user_id)
	local tSlot = vRP.verifySlots(user_id)

	if tSlot ~= nil then
		tSlot = tSlot
	else
		tSlot = 11
	end

	for k,v in pairs(vRP.getInventory(user_id)) do
		tSlot = tSlot - 1
	end

	return tSlot
end

function vRP.haveMoreSlots(user_id)
	if vRP.getRemaingSlots(user_id) > 0 then
		return true
	else
		return false
	end
end

--[ SLOT CHEST ]----------------------------------------------------------------------------------------------------------------------------------------

function vRP.getRemaingChestSlots(chestData,chestSlots)
	local tcSlot = chestSlots

	if tcSlot ~= nil then
		tcSlot = tcSlot
	else
		tcSlot = 11
	end

	local data = vRP.getSData(chestData)
	local result = json.decode(data) or {}

	for k,v in pairs(result) do
		tcSlot = tcSlot - 1
	end

	return tcSlot
end

--[ STORE CHEST ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight,chestSlots)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then

			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				return false
			end

			local new_weight = vRP.computeItemsWeight(items) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])

			if new_weight <= parseInt(chestWeight) and vRP.getRemaingChestSlots(chestData,chestSlots) >= 1 then
				if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(activedAmount[user_id])) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end

--[ TAKE CHEST ]----------------------------------------------------------------------------------------------------------------------------------------

function vRP.tryChestItem(user_id,chestData,itemName,amount)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then

				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					return false
				end

				local new_weight = vRP.getInventoryWeight(parseInt(user_id)) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getInventoryMaxWeight(parseInt(user_id)) and vRP.getRemaingSlots(parseInt(user_id)) >= 1 then
					vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(activedAmount[user_id]))

					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])

					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end





--------INVENTÁRIO DA DOPENUIS
function returnList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

function vRP.giveInventoryItem(user_id,idname,amount,slot)
	local amount = parseInt(amount)
	local inventory = vRP.getUserDataTable(user_id)
	local data = inventory.inventory
	local stop = false
	local newSlotPlayer = 0

	if data and amount > 0 then
		if tostring(slot) == tostring('true') or  tostring(slot) == tostring('false') then
			slot = nil
		end
		if idname then
			if slot then
				if data[tostring(slot)] == nil then
					data[tostring(slot)] = { item = idname, amount = parseInt(amount) }
				else
					if idname == data[tostring(slot)].item then
						data[tostring(slot)].amount = parseInt(data[slot].amount) + parseInt(amount)
					end
				end
			else
				for k,v in pairs(inventory.inventory) do
					if v.item == idname then
						local slot = k
						data[tostring(slot)].amount = parseInt(data[slot].amount) + parseInt(amount)
						stop = true
						break
					end
				end
	
				if stop == false then
					repeat
						newSlotPlayer = newSlotPlayer + 1
					until data[tostring(newSlotPlayer)] == nil or (data[tostring(newSlotPlayer)] and data[tostring(newSlotPlayer)].item == idname)
					newSlotPlayer = tostring(newSlotPlayer)
					data[tostring(newSlotPlayer)] = { item = idname, amount = parseInt(amount) }
				end
			end
		end
	end
end

function vRP.tryGetInventoryItem(user_id,idname,amount,slot)
	local table = vRP.getUserDataTable(user_id)
	local data = table.inventory
	local paraTry = false
	if tostring(slot) == tostring('true') or  tostring(slot) == tostring('false') then
		slot = nil
	end
	if slot then
		local slot = tostring(slot)
		if data[slot] then
			if data[slot].amount >= parseInt(amount) then
				data[slot].amount = parseInt(data[slot].amount) - parseInt(amount) -- Tira o amount tendo o slot
				if parseInt(data[tostring(slot)].amount) <= 0 then
					data[tostring(slot)] = nil
				end -- Verifica se é nulo
				return true
			else
				return false
			end
		end
	
	elseif not slot then
		for k,v in pairs(data) do
		
			if tostring(v.item) == tostring(idname) then
				local slotRemove = tostring(k)
			
				if parseInt(data[slotRemove].amount) >=  parseInt(amount) then
					print(slotRemove)
					data[slotRemove].amount = parseInt(data[slotRemove].amount) - parseInt(amount) -- Tira o amount

					if parseInt(data[tostring(slotRemove)].amount) <= 0 then
						data[tostring(slotRemove)] = nil
					end -- Verifica se é nulo
					paraTry = true
					return true

				else
					return false
				end
				if paraTry == true then
					break
				end
			end
		end
	end
end

function vRP.delteItem(user_id,idname)
	local table = vRP.getUserDataTable(user_id)
	local data = table.inventory
	for k,v in pairs(data) do
		if tostring(v.item) == tostring(idname) then
			data[tostring(k)] = nil
		end
	end
end

function vRP.updateItens(user_id,idname)
	local table = vRP.getUserDataTable(user_id)
	local data = table.inventory
	for k,v in pairs(data) do
		if tostring(k) == tostring(idname) then
			data[tostring(idname)] = nil
			return true
		end
	end
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	local quantidade = 0
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if v.item == idname then
				quantidade = parseInt(quantidade) + parseInt(v.amount)
			end
		end
		return quantidade
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(v.item)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.updateSlot(user_id,item,oldSlot,newSlot,amount)
	local inventory = vRP.getUserDataTable(user_id)
	local data = inventory.inventory
	if data and parseInt(amount) > -1 then
		local amountTotal = vRP.getInventoryItemAmountSlot(user_id,tostring(newSlot))
		local amountTotalAntiga = vRP.getInventoryItemAmountSlot(user_id,tostring(oldSlot))

		if data[tostring(newSlot)] then
			local entrada = data[tostring(newSlot)]
			if entrada.item == item then
				local fixo = vRP.getInventoryItemAmountSlot(user_id,tostring(newSlot))
				if parseInt(amount) <= parseInt(amountTotalAntiga) then
					data[tostring(oldSlot)].amount = parseInt(amountTotalAntiga) - parseInt(amount)
					data[tostring(newSlot)].amount = parseInt(amount) + parseInt(fixo)
				end
				if parseInt(data[tostring(oldSlot)].amount) <= 0 then
					data[tostring(oldSlot)] = nil
				end
			end
		else
			if parseInt(amountTotalAntiga) == parseInt(amount) then
				local temp = data[tostring(oldSlot)]
				data[tostring(oldSlot)] = data[tostring(newSlot)]
				data[tostring(newSlot)] = temp
			elseif parseInt(amountTotalAntiga) ~= parseInt(amount) then
				if parseInt(amount) <= parseInt(amountTotalAntiga) then
					data[tostring(oldSlot)].amount = parseInt(amountTotalAntiga) - parseInt(amount)
					data[tostring(newSlot)] = { item = item, amount = parseInt(amount) }
				end
			end
		end

	end
end

function vRP.getInventoryItemAmountSlot(user_id,slot)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local item = data.inventory[slot]
		if item then
			return item.amount
		end
	end
	return 0
end
