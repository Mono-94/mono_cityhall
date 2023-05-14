Config = {}


-- Hud Settings
Config.Minimap = true -- Minimap only see in car 

Config.Hud = true -- Toggle Car Hud

Config.HudWait = 100  -- 0 = 0.13ms in use Hud 

Config.HudSpeed = 'kmh' -- kmh / mph

-- Notifications

Config.Notis = 'ox'  -- esx or ox, you can edit 

RegisterNetEvent('Notification')
AddEventHandler('Notification', function(type, text)
    if Config.Notis == 'ox' then
        if type == 'success' then
            lib.notify({
                title = 'Llaves',
                description = text,
                position = 'bottom',
                style = {
                    backgroundColor = 'rgba(28, 28, 28, 0.8)',
                    color = '#909296',
                    borderRadius = '5px',
                },
                icon = 'car',
                iconColor = '#249e2c'
            })
        elseif type == 'error' then
            lib.notify({
                title = 'Llaves',
                description = text,
                position = 'bottom',
                style = {
                    backgroundColor = 'rgba(28, 28, 28, 0.8)',
                    color = '#909296',
                    borderRadius = '5px',
                },
                icon = 'car',
                iconColor = '#C53030'
            })
        elseif type == 'info' then
            lib.notify({
                title = 'Llaves',
                description = text,
                position = 'bottom',
                style = {
                    backgroundColor = 'rgba(28, 28, 28, 0.8)',
                    color = '#909296',
                    borderRadius = '5px',
                },
                icon = 'car',
                iconColor = '#fcba03'
            })
        end
    elseif Config.Notis == 'esx' then
        ESX.ShowNotification(text, type)
    end
end)
