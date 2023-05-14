
lib.locale()

-- esx_joblisting function 
function IsJobAvailable(job)
    local jobs = ESX.GetJobs()
    local JobToCheck = jobs[job]
    return not JobToCheck.whitelisted
end

RegisterServerEvent('mono_cityhall:SetJob')
AddEventHandler('mono_cityhall:SetJob', function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)


    if xPlayer and IsJobAvailable(job) then
        if ESX.DoesJobExist(job, 0) then
            xPlayer.setJob(job, 0)
            if CityHall.MarkGPSOnSetJob then
            TriggerClientEvent('mono_citiyhall:Notification', source, locale('lang0'), 'id-card')
            else
                TriggerClientEvent('mono_citiyhall:Notification', source, locale('lang1'), 'id-card')
            end
        else
            print("[^1ERROR^7] Tried Setting User ^5" .. source .. "^7 To Invalid Job - ^5" .. job .. "^7!")
        end
    else
        print("[^3WARNING^7] User ^5" .. source .. "^7 Attempted to Exploit ^5`mono_citiyhall:setJob`^7!")
    end

end)


-- um-idcard 
RegisterNetEvent('mono_citiyhall:Documentos', function(args)
    local source = source

    local item = exports.ox_inventory:GetItem(source, args.itemName, nil, 1)

    if item == 1 then
        TriggerClientEvent('mono_citiyhall:Notification', source, locale('lang2'), 'id-card')
    else
        exports['um-idcard']:CreateMetaLicense(source, args.itemName)
        TriggerClientEvent('mono_citiyhall:Notification', source,locale('lang3', args.itemName), 'id-card')
    end
end)

lib.callback.register('mono_cityhall:GetJobs', function()
    local GetESXJobs = ESX.GetJobs()
    local Jobs = {}
    for k, v in pairs(GetESXJobs) do
        if v.whitelisted == false then
            Jobs[#Jobs + 1] = { 
                label = v.label,
                name = k 
            }
        end
    end
    return Jobs
end)
