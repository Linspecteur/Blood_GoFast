ESX  = nil
local open = false


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local GofastMenu = RageUI.CreateMenu("Go Fast", "Illegal")
GofastMenu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = 255, G = 0, B = 0, A = 1 } } 

GofastMenu.Closed = function()   
    RageUI.Visible(GofastMenu, false)
    open = false
end 



function OpenGofastMenu()
    if open then 
        open = false 
        RageUI.Visible(GofastMenu,false)
        return
    else
        open = true 
        RageUI.Visible(GofastMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(GofastMenu, function()
                    RageUI.Button('Petit Trajet', "Trajet d'environ ~g~1,5 km~w~ livre le contenu de ta caisse à l'endroit indiquer et tout ira ~n~bien." , {RightLabel = "→"}, true , {
                        onSelected = function ()
                            GofastMenu.Closed()               
                            trajet.court()
                        end
                    })
                    RageUI.Button('Trajet Moyen ', "Plus long que le premier celui-ci est à ~g~3 km~w~ livre ce cargot le plus rapidement ~n~possible !" , {RightLabel = "→"}, true , {

                        onSelected = function ()
                            GofastMenu.Closed()               
                            trajet.moyen()
                        end 
                    })
                    RageUI.Button('Long Périple', "Le trajet ultime pour les affranchis celui-ci est à ~g~11 km~w~ fait au plus vite !" , {RightLabel = "→"}, true , {
                        onSelected = function ()
                            GofastMenu.Closed()               
                            trajet.long()
                        end 
                    })


                end)

                Wait(0)
            end
        end)


    end
end 

GofastPosition = {
    {pos = vector3(755.02111816406, -1865.4534912109, 28.293727874756), heading = 263.71}
}

CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local spam = false
        for _,v in pairs(GofastPosition) do
            if #(pCoords - v.pos) < 1.2 then
                spam = true
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec le boss")
                if IsControlJustReleased(0, 38) then
                    OpenGofastMenu()
                end                
            elseif #(pCoords - v.pos) < 1.3 then
                spam = false 
                GofastMenu.Closed()
            end
        end
        if spam then
            Wait(1)
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_m_bouncer_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_bouncer_01")) do
        Wait(1)
    end
    for _,v in pairs(GofastPosition) do
        local npc2 = CreatePed("PED_TYPE_CIVMALE", "s_m_m_bouncer_01", v.pos, v.heading, false, true)
        FreezeEntityPosition(npc2, true)
        SetEntityInvincible(npc2, true) 
        SetBlockingOfNonTemporaryEvents(npc2, true)
        Citizen.Wait(200)
        TaskStartScenarioInPlace(npc2, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    end

end)

