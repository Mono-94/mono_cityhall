--─▄▄▀▀█▀▀▄▄       |
--▐▄▌─▀─▀─▐▄▌      |
--──█─▄▄▄─█──▄▄    |
--──▄█▄▄▄█▄─▐──▌   |
--▄█▀█████▐▌─▀─▐   |
--▀─▄██▀██▀█▀▄▄▀   | ─────────────────────────────────────|
-- Symbiote#3027 - Discord: https://discord.gg/Vk7eY8xYV2 |
--────────────────────────────────────────────────────────
lib.locale()

CityHall = {}

CityHall.Debug = false

CityHall.Type = 'ox_target'   -- ox_target/ox_textui

CityHall.TextUiKey = 38       -- Default E (38)

CityHall.Icon = 'briefcase'   -- Icon for interaction 

CityHall.MarkGPSOnSetJob = true   -- Cuando el jugador obtiene el trabajo seleccionado se marca en el mapa la posision donde se inicia el trabajo, PARA ESTO TIENE QUE CONFIGURAR CityHall.JobPosStart 

CityHall.UnemployedNameDB = 'unemployed'    -- Default ESX unemployed 

CityHall.ProgressBar = {
    enable = true,  
    time = 2000,

}


CityHall.Zones = {
    ['City Hall'] = { -- Name Blip
        -- Position 
        Pos = vec4(-261.5454, -965.2300, 30.2241, 117.1752),--vec4(-550.8719, -190.2443, 36.7226, 178.2979),
        -- NPC Options
        NPC = true,                    -- Activar/desactivar NPC
        Hash = 'cs_debra',             -- Hash NPC 
        Scenario = false,              -- Scenario NPC
        -- Blip
        Blip = true,           -- Activar/desactivar blip
        Sprite = 407,          -- Blip sprite
        Display = 4,           -- Blip Display
        Scale = 0.6,           -- Blip size
        Colour = 0,            -- Blip colour
        ShortRange = true,     -- Blip Short Range
        -- Um-idcard
        -- Fivem post = https://forum.cfx.re/t/free-um-idcard-mugshot-card-maker/5067690 // GitHub = https://github.com/alp1x/um-idcard
        Um_idcard = false, 
        documents = {
            ['id_card'] = { --- Item name
                title = 'Recover ID Card',
                description = 'Recover your lost document.',
            },
        }

    },
    --[[['Example'] = {           --- Blip Name
        Type = 'target',
        Pos = vec4(-543.8060, -203.1001, 37.2148, 212.3065),
        -- NPC Options
        NPC = true,
        Hash = 'cs_debra',
        Scenario = 'WORLD_CROW_STANDING', --"PROP_HUMAN_SEAT_COMPUTER", This animation makes the npc sit and type on a pc
        -- Blip
        Blip = true,
        Sprite = 407,
        Display = 4,
        Scale = 0.6,
        Colour = 0,
        ShortRange = true,
        -- Um-idcard
        -- Fivem post = https://forum.cfx.re/t/free-um-idcard-mugshot-card-maker/5067690 // GitHub = https://github.com/alp1x/um-idcard
        Um_idcard = true, -- Dependecia Fivem post = https://forum.cfx.re/t/free-um-idcard-mugshot-card-maker/5067690 // GitHub = https://github.com/alp1x/um-idcard
        documents = {
           ['id_card'] = {
                title = 'recover ID Card',
                description = 'Recover your lost document.',
            },
            ['driver_license'] = {
                title = 'driver_license',
                description = 'Recupera tu documento extraviados.',
            },
            ['weaponlicense'] = {
                title = 'weaponlicense',
                description = 'Recupera tu documento extraviados.',
            },
            ['lawyerpass'] = {
                title = 'lawyerpass',
                description = 'Recupera tu documento extraviados.',
            },
        }

    }]]
}

CityHall.JobPosStart = {
    ['fisherman'] = {                             -- Job DB name
        PosStart = vec3(868.39, -1639.75, 30.33), -- Job start position
    },

    ['fueler'] = {                               -- Job DB name
        PosStart = vec3(557.93, -2327.90, 5.82), -- Job start position
    },

    ['lumberjack'] = {                             -- Job DB name
        PosStart = vec3(1200.63, -1276.87, 34.38), -- Job start position
    },

    ['miner'] = {                                       -- Job DB name
        PosStart = vec3(892.0762, -2173.6021, 32.2863), -- Job start position
    },

    ['slaughterer'] = {                             -- Job DB name
        PosStart = vec3(-1071.13, -2003.78, 15.78), -- Job start position
    },

    ['tailor'] = {                               -- Job DB name
        PosStart = vec3(706.73, -960.90, 30.39), -- Job start position
    },
}



RegisterNetEvent('mono_citiyhall:Notification', function(msg, icon)
    lib.notify({
        title = locale('lang4'),
        description = msg,
        icon = icon,
    })
end)
