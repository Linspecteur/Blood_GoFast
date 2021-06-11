ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('Reward:Gofast')
AddEventHandler('Reward:Gofast', function(reward)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addMoney(reward)
    TriggerClientEvent('esx:showNotification', source, "~g~Vous avez gagnez "..reward.."$")
end)