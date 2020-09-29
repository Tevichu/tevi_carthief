ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
    end)
  end
end)

--
--End of ESX
--

mision = false


function modelRequest(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
 Wait(500)
 end
end

Citizen.CreateThread(function()

	  modelRequest(0xE497BBEF)

  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped = CreatePed(4, 0xE497BBEF,1200.58,-3114.56,4.5, false, true)
      SetEntityHeading(ped, 294.1)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end)




--
-- Main NPC
--

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(800)
      if GetDistanceBetweenCoords(vector3(1200.58, -3114.56, 4.5), GetEntityCoords(PlayerPedId(), true)) < 4 then
      	inzone1 = true
      end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(800)
      if GetDistanceBetweenCoords(vector3(1200.58, -3114.56, 4.5), GetEntityCoords(PlayerPedId(), true)) > 4 then
      	inzone1 = false
      end
  end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if inzone1 and mision == false then
			ESX.ShowFloatingHelpNotification(flomsg1, vector3(1200.58, -3114.56, 4.5+2))
		end
	end
end)



Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
      if inzone1 and mision == false then
      	if IsControlJustPressed(1, Config.InteractKey) then
      		TriggerEvent('esx:showAdvancedNotification', _U('msg2'), '', _U('msg3'), 'CHAR_ARTHUR', 3)
      		TriggerEvent("spawncar")
      		mision = true
      	end
      end
  end
end)



--
-- End Main NPC
--

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if mision == true then 
      ESX.ShowHelpNotification(_U('msg4'))
      DrawMarker(1, vector3(1189.46, -3108.26, 4.24), 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.6001, 0, 0, 255, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(vector3(1189.46, -3108.26, 4.24), GetEntityCoords(PlayerPedId(), true)) < 4 then
          ESX.ShowFloatingHelpNotification(flomsg2, vector3(1189.46, -3108.26, 4.24+2))
          if IsControlJustPressed(1, Config.InteractKey) then
            local coordsauto = GetEntityCoords(Veh)
            if GetDistanceBetweenCoords(vector3(1189.46, -3108.26, 4.24), coordsauto, true) < 4 then
              ESX.Game.DeleteVehicle(Veh)
              mision = false
              TriggerServerEvent("tevi_carthief:setMoney")
              RemoveBlip(blip2)
            else
              ESX.ShowNotification(_U('msg8'))
            end
          end
        end
    end
  end
end)



RegisterNetEvent("spawncar")
AddEventHandler("spawncar", function()
  pos = Config.spawnpoints[math.random(1, #Config.spawnpoints)]
  modelo = Config.vehicles[math.random(1, #Config.vehicles)]
  modelo2 = GetHashKey(modelo.m)
  print(modelo.m)
  modelRequest(0x54DBEE1F)
  modelRequest(modelo2)
  pedenauto = CreatePed(4, 0x54DBEE1F,pos.x,pos.y,pos.z,pos.h, true, true)
  coordspedenauto = GetEntityCoords(pedenauto)
  Veh = CreateVehicle(modelo2,pos.x,pos.y,pos.z,pos.h, true, true)
  SpawnCar(pedenauto,Veh,-1)
  TaskWarpPedIntoVehicle(pedenauto, Veh, -1)
  TaskVehicleDriveWander(pedenauto,Veh,20.0,786603)
  print(coordspedenauto)
  CreateBlips()
end)



CreateBlips = function()
    blip = AddBlipForEntity(Veh)
    SetBlipSprite(blip, 523)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 60)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('msg6'))
    EndTextCommandSetBlipName(blip)



    blip2 = AddBlipForCoord(1189.46, -3108.26, 4.24)
    SetBlipSprite(blip2, 229)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 1.0)
    SetBlipColour(blip2, 0)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('msg7'))
    EndTextCommandSetBlipName(blip2)
end


CreateBlips2 = function()
    blip3 = AddBlipForEntity(ped)
    SetBlipSprite(blip3, 303)
    SetBlipDisplay(blip3, 4)
    SetBlipScale(blip3, 1.0)
    SetBlipColour(blip3, 4)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('msg10'))
    EndTextCommandSetBlipName(blip3)
end


function SpawnCar(ped,veh,seat)
SetPedIntoVehicle(ped,veh,seat)
SetPedRelationshipGroupHash(ped)
SetDriverAbility(ped, 1.0)
SetPedFleeAttributes(ped, 0, 1)
SetPedCombatAttributes(ped, 2,1)
SetPedCombatAttributes(ped, 3,1)
end

AddEventHandler('onResourceStart', function()
  mision = true
  Wait(5000)
  flomsg1 = _U('msg1')
  flomsg2 = _U('msg5')
  print("Script Loaded")
  mision = false
  if Config.blip then
  	CreateBlips2()
  end
end)
