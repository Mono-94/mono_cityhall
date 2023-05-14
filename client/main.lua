lib.locale()

function CreateBlip(Position, Sprite, Display, Scale, Colour, ShortRange, Name)
  local blip = AddBlipForCoord(Position.x, Position.y, Position.z)
  SetBlipSprite(blip, Sprite)
  SetBlipDisplay(blip, Display)
  SetBlipScale(blip, Scale)
  SetBlipColour(blip, Colour)
  SetBlipAsShortRange(blip, ShortRange)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(Name)
  EndTextCommandSetBlipName(blip)
end


function SetPedPos(Hash, Pos, Scenario)
  RequestModel(Hash)
  while not HasModelLoaded(Hash) do Wait(0) end
  NPC = CreatePed(2, Hash, Pos.x, Pos.y, Pos.z, Pos.w, false, false)
  SetPedFleeAttributes(NPC, 0, 0)
  SetPedDiesWhenInjured(NPC, false)
  if Scenario == false then else
    TaskStartScenarioInPlace(NPC, Scenario, 0, true)
  end
  SetPedKeepTask(NPC, true)
  SetBlockingOfNonTemporaryEvents(NPC, true)
  SetEntityInvincible(NPC, true)
  FreezeEntityPosition(NPC, true)
end


CreateThread(function()
  for k, v in pairs(CityHall.Zones) do
    if v.Blip then
      CreateBlip(v.Pos.xyz, v.Sprite, v.Display, v.Scale, v.Colour, v.ShortRange, k)
    end
    if v.NPC then
      SetPedPos(v.Hash, v.Pos, v.Scenario)
    end
    if CityHall.Type == 'ox_target' then
      exports.ox_target:addBoxZone({
        coords = vec3(v.Pos.x, v.Pos.y, v.Pos.z),
        size = vec3(2, 3, 4),
        rotation = v.Pos.w,
        debug = CityHall.Debug,
        options = {
          {
            name = 'box',
            onSelect = function()
              CityHallMenu(k)
            end,
            icon = 'fa-solid fa-'..CityHall.Icon,
            label = k,
          }
        }
      })
    elseif CityHall.Type == 'ox_textui' then
      local point = lib.points.new({
        coords = vec3(v.Pos.x, v.Pos.y, v.Pos.z),
        distance = 3,
      })

      function point:onEnter()
        lib.showTextUI(locale('lang5',k))
      end

      function point:onExit()
        lib.hideTextUI()
      end

      function point:nearby()
        if IsControlJustReleased(0, CityHall.TextUiKey) then
          CityHallMenu(k)
        end
      end
    end
  end
end)


function CityHallMenu(hall)
  local trabajos = lib.callback.await('mono_cityhall:GetJobs')
  local jobslits = {}
  local menuPrint = {}
  local IdCards = {}

  if CityHall.MarkGPSOnSetJob then
    gps = locale('lang6')
  else
    gps = locale('lang7')
  end

  for i = 1, #trabajos do
    local multi = trabajos[i]
    table.insert(jobslits, {
      title = multi.label,
      icon = CityHall.Icon,
      arrow = true,
      description = gps,
      onSelect = function()
        if CityHall.ProgressBar.enable then
          if lib.progressBar({
                duration = CityHall.ProgressBar.time,
                label = locale('lang8'),
                useWhileDead = false,
                canCancel = false,
                disable = {
                  car = true,
                  move = true,
                },
                anim = {
                  dict = 'missheistdockssetup1clipboard@base',
                  clip = 'base'
                },
                prop = {
                  model = `prop_notepad_01`,
                  bone = 18905,
                  pos = vec3(0.1, 0.02, 0.05),
                  rot = vec3(10.0, 0.0, 0.0)
                },

              }) then
            TriggerServerEvent('esx_joblisting:setJob', multi.name)
            if CityHall.MarkGPSOnSetJob then
              if multi.name == CityHall.UnemployedNameDB  then
                return
              end
              SetNewWaypoint(CityHall.JobPosStart[multi.name].PosStart.x, CityHall.JobPosStart[multi.name].PosStart.y)
            end
          else
            print('cancel')
          end
        else
          TriggerServerEvent('esx_joblisting:setJob', multi.name)
          if CityHall.MarkGPSOnSetJob then
            if multi.name == CityHall.UnemployedNameDB  then
              return
            end
            SetNewWaypoint(CityHall.JobPosStart[multi.name].PosStart.x, CityHall.JobPosStart[multi.name].PosStart.y)
          end
        end
      end,

    })
  end

  lib.registerContext({
    id = 'menu_lista_trabajos',
    title = locale('lang13'),
    menu = 'menu_ayunta_prin',
    options = jobslits
  })


  table.insert(menuPrint, {
    title = locale('lang9'),
    description = locale('lang12'),
    menu = 'menu_lista_trabajos',
    icon = CityHall.Icon,
  })

  if CityHall.Zones[hall].Um_idcard then
    table.insert(menuPrint, {
      title = locale('lang10'),
      description = locale('lang11'),
      menu = 'Documentos_menu',
      icon = 'id-card',
    })

    for docs, tip in pairs(CityHall.Zones[hall].documents) do
      table.insert(IdCards, {
        title = tip.title,
        description = tip.description,
        serverEvent = 'mono_citiyhall:Documentos',
        args = {
          itemName = docs
        }
      })
    end
  end


  lib.registerContext({
    id = 'Documentos_menu',
    title = locale('lang10'),
    menu = 'menu_ayunta_prin',
    options = IdCards
  })

  lib.registerContext({
    id = 'menu_ayunta_prin',
    title = hall,
    options = menuPrint,
  })

  lib.showContext('menu_ayunta_prin')
end
