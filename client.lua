

ESX = nil


mision = false



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
    end)
  end
end)

function modelRequest(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
 Wait(1)
 end
end


local cordenadas = {
    {1200.58,-3114.56,4.56,"",294.1,0xE497BBEF,"s_m_y_dealer_01"},
}

Citizen.CreateThread(function()

    for _,v in pairs(cordenadas) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end

  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(cordenadas) do
            x = v[1]
            y = v[2]
            z = v[3]
        end
    end
end)

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
        while true do
            Citizen.Wait(0)
            if GetDistanceBetweenCoords(vector3(1200.58, -3114.56, 4.5), GetEntityCoords(PlayerPedId(), true)) < 4 and mision == false then
              ESX.ShowFloatingHelpNotification(msg1, vector3(1200.58, -3114.56, 4.5+2))
              if IsControlJustPressed(1, 38) then
                TriggerEvent('esx:showAdvancedNotification', msg2, '', msg3, 'CHAR_ARTHUR', 3)
                TriggerEvent("spawncar")
                CreateBlips()
                mision = true
              end
            end
          end
        end)



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
        while true do
            Citizen.Wait(0)
            if mision == true then 
              ESX.ShowHelpNotification(msg4)
              DrawMarker(1, vector3(1189.46, -3108.26, 4.24), 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.6001, 0, 0, 255, 200, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(vector3(1189.46, -3108.26, 4.24), GetEntityCoords(PlayerPedId(), true)) < 4 then
                 ESX.ShowFloatingHelpNotification(msg5, vector3(1189.46, -3108.26, 4.24+2))
                 if IsControlJustPressed(1, 38) then
                  local coordsauto = GetEntityCoords(Veh)
                  if GetDistanceBetweenCoords(vector3(1189.46, -3108.26, 4.24), coordsauto, true) < 4 then
                    ESX.Game.DeleteVehicle(Veh)
                    mision = false
                    TriggerServerEvent("tevi_carthief:setMoney")
                    RemoveBlip(blip2)
                  else
                    ESX.ShowNotification(msg8)
                  end
                end
              end
            end
          end
        end)


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
        while true do
            Citizen.Wait(0)
            if config.blip then
            	CreateBlips2()
            end
        end
    end)



RegisterNetEvent("spawncar")
AddEventHandler("spawncar", function()
  pos = config.spawnponts[math.random(1, #config.spawnponts)]
  modelo = config.vehicles[math.random(1, #config.vehicles)]
  print(modelo.m)
  modelRequest(0x54DBEE1F)
  pedenauto = CreatePed(4, 0x54DBEE1F,pos.x,pos.y,pos.z,pos.h, true, true)
  coordspedenauto = GetEntityCoords(pedenauto)
  Veh = CreateVehicle(modelo.m,pos.x,pos.y,pos.z,pos.h, true, true)
  TaskWarpPedIntoVehicle(pedenauto, Veh, -1)
  TaskVehicleDriveWander(pedenauto,Veh,20.0,786603)
end)



CreateBlips = function()
    blip = AddBlipForEntity(Veh)
    SetBlipSprite(blip, 523)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 60)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(msg6)
    EndTextCommandSetBlipName(blip)



    blip2 = AddBlipForCoord(1189.46, -3108.26, 4.24)
    SetBlipSprite(blip2, 229)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 1.0)
    SetBlipColour(blip2, 0)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(msg7)
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
    AddTextComponentString(msg10)
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

