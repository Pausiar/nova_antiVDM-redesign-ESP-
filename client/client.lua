local adding = false
local previousHealth = 100

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        previousHealth = GetEntityHealth(playerPed)
        Wait(10 * 1000)
    end
end)

AddEventHandler("entityDamaged", function(entity, attacker, weapon, damage)
    if IsEntityAPed(entity) and entity == PlayerPedId() then
        local targetPed = entity
        local attackerPed = attacker

        if weapon == 0 or weapon == -1553120962 then -- atropello
            if IsPedInAnyVehicle(attackerPed, false) and GetPedInVehicleSeat(attackerPed, -1) then
                if not adding then
                    adding = true
                    local attackerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attackerPed))
                    SetEntityInvincible(targetPed, true)

                    TriggerServerEvent("nova_antivdm:warn", "CODICEANTITRIGGERANTIVDM121683GDSAàòèPLàDS",
                        attackerServerId)
                    SetTimeout(1500, function()
                        adding = false
                    end)

                    if Config.CurarePlayer then
                        local currHealth = GetEntityHealth(targetPed)
                        if currHealth <= 0 or IsEntityDead(targetPed) then
                            -- En ESX: revivir directamente
                            SetEntityHealth(targetPed, 0)
                            TriggerEvent('esx_ambulancejob:revive')
                            Config.sendNotification(Config.Lang["title"], Config.Lang["ress"])
                        end

                        while HasEntityCollidedWithAnything(targetPed) do
                            SetEntityHealth(targetPed, previousHealth < 10 and 200 or previousHealth)
                            Wait(1)
                        end

                        SetEntityHealth(targetPed, previousHealth < 10 and 200 or previousHealth)
                    end
                    Wait(2000)
                    SetEntityInvincible(targetPed, false)
                end
            end
        end
    end
end)

RegisterNetEvent("nova_antivdm:warn", function(target)
    if target ~= "CODICEANTITRIGGERANTIVDM121683GDSAàòèPLàDS" then
        TriggerServerEvent("nova_antivdm:banPlayer", "event")
        return
    end
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        if Config.UseNotificationSound then
            PlaySoundFrontend(-1, Config.NotificationSound[1], Config.NotificationSound[2], 1)
        end

        SetTimeout(200, function()
            if GetResourceState('screenshot-basic') == 'started' then
                exports['screenshot-basic']:requestScreenshotUpload(Config.Webhook or '', 'files[]', function(data)
                    if data then
                        local success, resp = pcall(json.decode, data)
                        if success and resp and resp.attachments then
                            -- Screenshot subida exitosamente
                        end
                    end
                end)
            end
        end)

        SetTimeout(Config.VdmRemover * 60000, function()
            if LocalPlayer.state.vdmCounter > 0 then
                LocalPlayer.state:set("vdmCounter", (LocalPlayer.state.vdmCounter - 1), true)
            end
        end)

        LocalPlayer.state:set("vdmCounter", ((LocalPlayer.state.vdmCounter or 0) + 1), true)
        Config.sendNotification(Config.Lang["title"], ("%s %s"):format(LocalPlayer.state.vdmCounter, Config.Lang["desc"]))
    end
end)

AddStateBagChangeHandler('vdmCounter', nil, function(bagName, key, value)
    local isStatePlayer = bagName:gsub('player:', '')
    if not value then return end

    if isStatePlayer then
        if key == "vdmCounter" then
            if value >= Config.VdmChance then
                TriggerServerEvent("nova_antivdm:banPlayer")
            end
        end
    end
end)
