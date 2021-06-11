local LivraisonStart = false 

function spawncar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

	if ESX.Game.IsSpawnPointClear(vector3(762.51458740234,-1866.2678222656,28.667362213135), 1.0) then
		local vehicle = CreateVehicle(car,  762.51458740234,-1866.2678222656,28.667362213135, 263.71, true, false)
		SetEntityAsNoLongerNeeded(vehicle)
		SetModelAsNoLongerNeeded(vehicle)	
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleNumberPlateText(vehicle, "GO FAST")
	end
end

function ShowHelp(text, n)
    BeginTextCommandDisplayHelp(text)
    EndTextCommandDisplayHelp(n or 0, false, true, -1)
end

function ShowFloatingHelp(text, pos)
    SetFloatingHelpTextWorldPosition(1, pos)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    ShowHelp(text, 2)
end


GofastPos1 = {
    {pos = vector3(1764.2255859375, -1655.9798583984, 111.70049621582)},
}


GofastPos2 = {
    {pos = vector3(147.23368835449, 320.84851074219, 111.15874816895)},
}

GofastPos3 = {
    {pos = vector3(48.053672790527,6657.3837890625,31.734762191772)},
}


function SendDistressSignal()	
    TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'D\'après mes infos un  Gofast a commencer')
end

trajet = {

	court = function()

		LivraisonStart = true 
		spawncar("huntley")   
		ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 1 minutes 30 maximum")       
		Citizen.CreateThread(function()
			while true do
				Wait(1)
				if LivraisonStart == true then
					local pCoords = GetEntityCoords(PlayerPedId())
					local spam = false
					local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
					for _,v in pairs(GofastPos1) do
						if #(pCoords - v.pos) < 2.5 then
							spam = true
							ShowFloatingHelp("drawshadowNotif", v.pos)
							AddTextEntry("drawshadowNotif", "Appuyez sur ~b~[E]~s~ pour livrer votre ~b~butin")
							if IsControlJustReleased(0, 38) then
								if plate == "GO FAST " then
									SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('Reward:Gofast', 2000)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast1)
								else
									ESX.ShowNotification('Il est où le véhicule que je t\'ai donné ? Dégage man !')
								end
							end                
						end
					end
				end
			end
		end)
		if LivraisonStart == true then
			SendDistressSignal()
			BlipsGofast1 = AddBlipForCoord(1764.2255859375,-1655.9798583984,112.68049621582)
			SetBlipSprite(BlipsGofast1, 1)
			SetBlipScale(BlipsGofast1, 0.85)
			SetBlipColour(BlipsGofast1, 1)
			PulseBlip(BlipsGofast1)
			SetBlipRoute(BlipsGofast1,  true)
			AddTimerBar("Temps restants", {endTime=GetGameTimer()+90000})
			Wait(90000)
			RemoveTimerBar()
			RemoveBlip(BlipsGofast1)
			LivraisonStart = false
		end
	end,
	moyen = function()
		LivraisonStart = true 
		spawncar("tailgater")
		ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 2 minutes 30 maximum") 
		Citizen.CreateThread(function()
			while true do
				Wait(1)
				if LivraisonStart == true then
					local pCoords = GetEntityCoords(PlayerPedId())
					local spam = false
					local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
					for _,v in pairs(GofastPos2) do
						if #(pCoords - v.pos) < 2.5 then
							spam = true
							ShowFloatingHelp("drawshadowNotif", v.pos)
							AddTextEntry("drawshadowNotif", "Appuyez sur ~b~[E]~s~ pour livrer votre ~b~butin")
							if IsControlJustReleased(0, 38) then
								if plate == "GO FAST " then
									SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('Reward:Gofast', 4000)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast2)
								else
									ESX.ShowNotification('Il est où le véhicule que je t\'ai donné ? Dégage man !')
								end
							end                
						end
					end
				end
			end
		end)
		if LivraisonStart == true then
			SendDistressSignal()
			BlipsGofast2 = AddBlipForCoord(147.23368835449, 320.84851074219, 111.15874816895)
			SetBlipSprite(BlipsGofast2, 1)
			SetBlipScale(BlipsGofast2, 0.85)
			SetBlipColour(BlipsGofast2, 1)
			PulseBlip(BlipsGofast2)
			SetBlipRoute(BlipsGofast2,  true)
			AddTimerBar("Temps restants", {endTime=GetGameTimer()+150000})
			Wait(150000)
			RemoveTimerBar()
			RemoveBlip(BlipsGofast2)
			LivraisonStart = false
		end
    end,

	long = function ()
		LivraisonStart = true 
		spawncar("schafter2") 
		ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 8 minutes")
		Citizen.CreateThread(function()
			while true do
				Wait(1)
				if LivraisonStart == true then
					local pCoords = GetEntityCoords(PlayerPedId())
					local spam = false
					local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
					for _,v in pairs(GofastPos3) do
						if #(pCoords - v.pos) < 2.5 then
							spam = true
							ShowFloatingHelp("drawshadowNotif", v.pos)
							AddTextEntry("drawshadowNotif", "Appuyez sur ~b~[E]~s~ pour livrer votre ~b~butin")
							if IsControlJustReleased(0, 38) then
								if plate == "GO FAST " then
									SetVehicleDoorOpen(GetVehiclePedIsIn(plyPed, false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('Reward:Gofast', 7000)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast3)
								else
									ESX.ShowNotification('Il est où le véhicule que je t\'ai donné ? Dégage man !')
								end
							end                
						end
					end
				end
			end
		end)
		if LivraisonStart == true then
			SendDistressSignal()
			BlipsGofast3 = AddBlipForCoord(48.053672790527,6657.3837890625,31.734762191772)
			SetBlipSprite(BlipsGofast3, 1)
			SetBlipScale(BlipsGofast3, 0.85)
			SetBlipColour(BlipsGofast3, 1)
			PulseBlip(BlipsGofast3)
			SetBlipRoute(BlipsGofast3,  true)
			AddTimerBar("Temps restants", {endTime=GetGameTimer()+480000})
			Wait(480000)
			RemoveTimerBar()
			RemoveBlip(BlipsGofast3)
			LivraisonStart = false
		end
    end
}