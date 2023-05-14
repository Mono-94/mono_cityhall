local tablet = false

local playerState = LocalPlayer.state
ESX = exports["es_extended"]:getSharedObject()

local tabletOffset = vector3(0.0, -0.03, 0.)
local tabletRot = vector3(20.0, -90.0, 0.0)
function Sy_Tab()
    tablet = true
    local flags = 49
    RequestModel(`prop_cs_tablet`)

    while not HasModelLoaded(`prop_cs_tablet`) do
        Wait(150)
    end

    tabletObj = CreateObject(`prop_cs_tablet`, 0.0, 0.0, 0.0, true, true, false)
    local tabletBoneIndex = GetPedBoneIndex(PlayerPedId(), 28422)
    TaskPlayAnim(PlayerPedId(), 'amb@world_human_tourist_map@male@base', 'base', 8.0, -8.0, -1, flags, 0, false, false, false)

    AttachEntityToEntity(tabletObj, PlayerPedId(), tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z,
        tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)


    SetNuiFocus(true, true)
    Trabajos()
    SendNUIMessage({
        action = 'show',
    })
   
end



exports('Sy_Tab', Sy_Tab)




RegisterCommand('noti', function()
    SendNUIMessage({
        action = 'noti',
        title = 'Nema es Gay.',
        msg = 'Nombre: '.. playerState.name,
        tiempo = 3000,
        icon = 'user'
    })
end, false)


RegisterNetEvent('sy_tab:Notifiacion')
AddEventHandler('sy_tab:Notifiacion', function(titulo, msg, tiempo, icono)
    SendNUIMessage({
        action = 'noti',
        title = titulo,
        msg = msg,
        tiempo = tiempo,
        icon = icono
    })
end)

function TabNoti(titulo, msg, tiempo, icono)
    local tab = exports.ox_inventory:Search('slots', 'tab')
    local cantidad = 0
    for _, v in pairs(tab) do
        cantidad = cantidad + v.count
    end
    if cantidad >= 1 then
        SendNUIMessage({
            action = 'noti',
            title = titulo,
            msg = msg,
            tiempo = tiempo,
            icon = icono
        })
    else
        print('No tienes Tablet')
    end
end

RegisterNUICallback('SendAction', function(data, cb)
    if data.action == 'actualizar' then
        Trabajos()
    elseif data.action == 'cerrar' then
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(tabletObj, true, false)
        DeleteEntity(tabletObj)
        SetNuiFocus(false, false)
    end
end)

exports('TabNoti', TabNoti)



function Trabajos()

    local vehicles = lib.callback.await('sy_society:GetUsers')
    local jobName = json.encode(playerState.job.name)
    jobName = string.sub(jobName, 2, -2)

    for i = 1, #vehicles do
        local user = vehicles[i]
        if user.identifier == playerState.identifier then
            SendNUIMessage({action = "UpdateData", key = "job", value = user.job, horas = disp_time(user.time), rango = user.grade})
        end
        
        Wait(0)
    end
end
function disp_time(time)
    local days = math.floor(time / 86400)
    local hours = math.floor((time % 86400) / 3600)
    local minutes = math.floor((time % 3600) / 60)
    local seconds = math.floor((time % 60))
    return string.format("%d:%02d:%02d:%02d", days, hours, minutes, seconds)
end
