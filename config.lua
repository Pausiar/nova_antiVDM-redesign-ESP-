Config = {}

Config.Webhook = "https://discord.com/api/webhooks/1431792921912283196/gbZ7aIXMt22U68Tq7EngB4ryGjjRhg9eKaZei7omZ7Lsqq8d0XAaBd3D_NgD6ixVKX8B" -- Webhook para screenshots
Config.CurarePlayer = true -- si curar al jugador cuando es dañado por un vehículo
Config.VdmChance = 3       -- después de cuántos vdm un jugador debe ser expulsado
Config.VdmRemover = 10     -- después de cuánto tiempo se quita un vdm (en minutos)
Config.UseNotificationSound = true
Config.NotificationSound = {
    "TIMER_STOP",
    "HUD_MINI_GAME_SOUNDSET"
}

function Config.revivePlayer(player)
    TriggerEvent('esx_ambulancejob:revive') -- cámbialo si tu script usa otro evento
end

function Config.sendNotification(title, desc)
    lib.notify({
        title = title,
        description = desc,
        position = 'top',
        style = {
            backgroundColor = '#1E3A5F',
            color = '#FFFFFF',
            padding = '15px',
            borderRadius = '8px',
            ['.description'] = {
                color = '#C0D9F0'
            }
        },
        icon = 'exclamation-triangle',
        iconColor = '#5B9BD5'
    })
end

Config.Lang = {
    ["title"] = "ANTI VDM SYSTEM",
    ["desc"] = "AVISO | Has recibido una advertencia por haber chocado con un jugador (Sistema Nova Vdm)",
    ["punish_event"] = "Has sido baneado por activar un evento.",
    ["punish_vdm"] = "Has sido baneado por realizar varios actos de VDM (Vehicle Deathmatch).",
    ["ress"] = "¡Has sido resucitado! | Scripts de Nova"
}
