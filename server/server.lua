ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tevi_carthief:setMoney')
AddEventHandler('tevi_carthief:setMoney', function()
    local user = ESX.GetPlayerFromId(source)

    user.addAccountMoney('black_money', Config.paid)
    TriggerClientEvent('esx:showNotification', source, "" .. _U('msg9') .. "" .. Config.paid)
end)