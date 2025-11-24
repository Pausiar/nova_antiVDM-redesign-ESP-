WEBHOOK = "https://discord.com/api/webhooks/1431792921912283196/gbZ7aIXMt22U68Tq7EngB4ryGjjRhg9eKaZei7omZ7Lsqq8d0XAaBd3D_NgD6ixVKX8B"

function punishPlayer(target, case)
    local message = ""

    if case == "event" then
        message = string.format("Has sido expulsado/baneado por activar un evento (ANTI-TRIGGER GRATUITO by https://discord.gg/XxtCBxwB)")
        createLog(true, target)
    elseif case == "vdm" then
        message = string.format("Has sido expulsado/baneado por realizar varios VDM dentro de este servidor!")
    end

    if message == "" then return end

    local header = "SISTEMA ANTI VDM"
    local footer = "Si crees que esto fue un error, ¡contacta con el soporte! \nSISTEMA ANTI VDM"

    local fullMessage = string.format("%s\n\n%s\n\n%s", header, message, footer)

    DropPlayer(target, fullMessage)
end
