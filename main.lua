function Toggle(keyinput, key, bool) --keyinput: the key that's actually getting pressed, key: the key that's checked for, bool: the bool that's toggled; example: TheBool = Toggle(k, 'q', TheBool)
    if keyinput == key and not bool then
        return true
    elseif keyinput == key and bool then
        return false
    end
end


function PausePlay(keyinput, key, sourceTable)  --keyinput: the key that's actually getting pressed, key: the number that's checked for, sourceTable: the table of sources that gets pulled from to pause/play; example: PausePlay(k, 1, MusicTable)
    local keynum = tonumber(key)
    if keyinput == key and not sourceTable[keynum]:isPlaying() then
        love.audio.play(sourceTable[keynum])
    elseif keyinput == key and sourceTable[keynum]:isPlaying() then
        sourceTable[keynum]:pause()
    end
end

function PauseStop(keyinput, pause, stop, sourceTable)
    if keyinput == pause then
        for i = 1, #sourceTable do
            sourceTable[i]:pause()
        end
    end
    if keyinput == stop then
        for i = 1, #sourceTable do
            sourceTable[i]:stop()
        end
    end
end


function Default(val, def)
    if val == nil then
        return def
    else
        return val
    end
end

function Clamp(val, min, max)
    min = Default(min, 0)
    max = Default(max, 1)
    if val < min then
        return min
    elseif val > max then
        return max
    else
        return val
    end
end









function love.load()
    --HEY LOOK AT THIS
    --the command to launch this from the terminal is
    -- cd Repos/Lua/LOVE\ projects
    -- open -n -a love "Collaboration"


    --init important stuff
    love.window.setTitle('Collaboration Music Player')
    local imageData = love.image.newImageData('Ligma.png')
    Success1 = love.window.setIcon(imageData)
    SystemOS = love.system.getOS()


    Paths1 = {'Level1/disc_cyberwave.ogg', 'Level1/Final Destination SSBB Remix.mp3', 'Level1/Murder Drones - Click(CaliberKat Remix).mp3', 'Level1/disc_cyberwave.ogg', 'Level1/disc_cyberwave.ogg'}

    Paths2 = {'Level2/Lamps.ogg', 'Level2/rain.ogg', 'Level2/TRANSMISSION_ERROR.ogg', 'Level2/Scav_Manufacturing_co.mp3'}


    Musics1 = {love.audio.newSource(Paths1[1], 'stream'), love.audio.newSource(Paths1[2], 'stream'), love.audio.newSource(Paths1[3], 'stream'), love.audio.newSource(Paths1[4], 'stream'), love.audio.newSource(Paths1[5], 'stream')}

    Musics2 = {love.audio.newSource(Paths2[1], 'stream'), love.audio.newSource(Paths2[2], 'stream'), love.audio.newSource(Paths2[3], 'stream'), love.audio.newSource(Paths2[4], 'stream')}



    Controls = {'escape', 'numbers(1-9)', 'P', 'S', 'T, Y, U, I', 'N', 'Z', 'X', 'C'}
    ControlsDesc = {': quit', ': play/pause song', ': pause all music', ': stop all music', ': music levels 1-4', ': set music level to none', ': increase volume', ': decrease volume', ': reset volume'}



    Level1 = true
    Level2 = false
    Level3 = false
    Level4 = false
    --NilLevel = not (Level1 and Level2 and Level3 and Level4)

    SelectedSongL1 = 1
    SelectedSongL2 = 1


    ListControls = false

    TestBool = false

    DebugMode = false
    DeCheck1 = false
    DeCheck2 = false
end



function love.draw()
    --draw credits
    love.graphics.print('Made by Nuclear Pasta', 320, 10)
    --app icon check
    if not Success1 then
        love.graphics.print('Icon error', 20, 10)
    end

    print(SystemOS, 620, 20)

    if DebugMode then
        if TestBool then
            love.graphics.print('TestBool: true', 620, 10)
        elseif not TestBool then
            love.graphics.print('TestBool: false', 620, 10)
        end
    end


    --draw show controls keybind
    if not ListControls then
        love.graphics.print('Press H to show controls', 320, 30)
    elseif ListControls then
        love.graphics.print('Press H to hide controls', 320, 30)
    end

    --music folder levels
    if Level1 and not Level2 and not Level3 and not Level4 then
        love.graphics.print('Currently on Level: 1', 20, 50)
    end

    if not Level1 and Level2 and not Level3 and not Level4 then
        love.graphics.print('Currently on Level: 2', 20, 50)
    end

    if not Level1 and not Level2 and Level3 and not Level4 then
        love.graphics.print('Currently on Level: 3', 20, 50)
    end

    if not Level1 and not Level2 and not Level3 and Level4 then
        love.graphics.print('Currently on Level: 4', 20, 50)
    end

    if not Level1 and not Level2 and not Level3 and not Level4 then
        love.graphics.print('Currently on Level: None', 20, 50)
    end

    --list songs
    if Level1 then
        for i = 1, #Paths1 do
            love.graphics.print(i .. ': ' .. Paths1[i], 320, 70 + i * 20)
        end
    elseif Level2 then
        for i = 1, #Paths2 do
            love.graphics.print(i .. ': ' .. Paths2[i], 320, 70 + i * 20)
        end
    end


    --draw song volume selection
    local selectedSong = 0
    if Level1 then
        selectedSong = SelectedSongL1
    elseif Level2 then
        selectedSong = SelectedSongL2
    end
    love.graphics.print('>', 8, 300 + selectedSong * 20)



    --list volumes
    if not Level1 and not Level2 and not Level3 and not Level4 then
        love.graphics.print('NO_SONG_LEVEL_SELECTED', 320, 90)
        love.graphics.print('NO_SONG_LEVEL_SELECTED', 20, 320)
    end

    if Level1 then
        for i = 1, #Musics1 do
            local vol = Musics1[i]:getVolume()
            love.graphics.print(Paths1[i] .. ' volume: ' .. vol, 20, 300 + i * 20)
        end
    elseif Level2 then
        for i = 1, #Musics2 do
            local vol = Musics2[i]:getVolume()
            love.graphics.print(Paths2[i] .. ' volume: ' .. vol, 20, 300 + i * 20)
        end
    end
    --love.graphics.print('1: disc_cyberwave.ogg', 320, 40)

    --list controls
    if ListControls then
        for i = 1, #Controls do
            love.graphics.print(Controls[i] .. ControlsDesc[i], 550, 300 + i * 20)
        end
    end

    local touches = love.touch.getTouches()

    for i, id in ipairs(touches) do
        local x, y = love.touch.getPosition(id)
        love.graphics.circle("fill", x, y, 20)
    end
end


function love.update(dt)
    SelectedSongL1 = Clamp(SelectedSongL1, 1, #Musics1)
    SelectedSongL2 = Clamp(SelectedSongL2, 1, #Musics2)
end


function love.keypressed(k)
    local canQuit = true
    if k == 'escape' and not canQuit then
        canQuit = true
        --love.graphics.print('Are you sure you want to quit?', 290, 30)
    elseif k == 'escape' and canQuit then
       love.event.quit()
    end


    TestBool = Toggle(k, 'm', TestBool)

    --[[if k == 'h' and not ListControls then
        ListControls = true
    elseif k == 'h' and ListControls then
        ListControls = false
    end]]

    ListControls = Toggle(k, 'h', ListControls)
    

    --DeCheck1 = Toggle(k, ',', DeCheck1)
    --DeCheck2 = Toggle(k, '.', DeCheck2)
    --DebugMode = Toggle(k, ';', DebugMode)


    if Level1 and not Level2 and not Level3 and not Level4 then
        PausePlay(k, '1', Musics1)
        PausePlay(k, '2', Musics1)
        PausePlay(k, '3', Musics1)
        PausePlay(k, '4', Musics1)
        PausePlay(k, '5', Musics1)
        --[[if k == '1' and not Musics1[1]:isPlaying() then
            love.audio.play(Musics1[1])
        elseif k == '1' and Musics1[1]:isPlaying() then
            Musics1[1]:pause()
        end

        if k == '2' and not Musics1[2]:isPlaying() then
            love.audio.play(Musics1[2])
        elseif k == '2' and Musics1[2]:isPlaying() then
            Musics1[2]:pause()
        end

        if k == '3' and not Musics1[3]:isPlaying() then
            love.audio.play(Musics1[3])
        elseif k == '3' and Musics1[3]:isPlaying() then
            Musics1[3]:pause()
        end

        if k == '4' and not Musics1[4]:isPlaying() then
            love.audio.play(Musics1[4])
        elseif k == '4' and Musics1[4]:isPlaying() then
            Musics1[4]:pause()
        end

        if k == '5' and not Musics1[5]:isPlaying() then
            love.audio.play(Musics1[5])
        elseif k == '5' and Musics1[5]:isPlaying() then
            Musics1[5]:pause()
        end]]
        
        --[[local table = {'1', '2', '3', '4', '5'}
        for i = 1, 5 do
            if k == table[i] and not Musics1[i]:isPlaying() then
                love.audio.play(Musics1[i])
            elseif k == table[i] and Musics1[i]:isPlaying() then
                Musics1[i]:pause()
            end
        end]]
    elseif not Level1 and Level2 and not Level3 and not Level4 then
        PausePlay(k, '1', Musics2)
        PausePlay(k, '2', Musics2)
        PausePlay(k, '3', Musics2)
        PausePlay(k, '4', Musics2)

        --[[if k == '4' and not Musics2[4]:isPlaying() then
            love.audio.play(Musics2[4])
        elseif k == '4' and Musics2[4]:isPlaying() then
            Musics2[4]:pause()
        end]]
    end


    if k == 't' and not Level1 then
        Level1 = true

        Level2 = false
        Level3 = false
        Level4 = false
    elseif k == 't' and Level1 then
        Level1 = false

        --[[Level2 = false
        Level3 = false
        Level4 = false]]
    end

    if k == 'y' and not Level2 then
        Level2 = true

        Level1 = false
        Level3 = false
        Level4 = false
    elseif k == 'y' and Level2 then
        Level2 = false

        --[[Level1 = false
        Level3 = false
        Level4 = false]]
    end

    if k == 'u' and not Level3 then
        Level3 = true

        Level2 = false
        Level1 = false
        Level4 = false
    elseif k == 'u' and Level3 then
        Level3 = false

        --[[Level2 = false
        Level1 = false
        Level4 = false]]
    end

    if k == 'i' and not Level4 then
        Level4 = true

        Level2 = false
        Level3 = false
        Level1 = false
    elseif k == 'i' and Level4 then
        Level4 = false

        --[[Level2 = false
        Level3 = false
        Level1 = false]]
    end

    if k == 'n' and (Level1 or Level2 or Level3 or Level4) then
        Level1 = false
        Level2 = false
        Level3 = false
        Level4 = false
    end

    if Level1 then
        if k == 'z' then
            for i = 1, #Musics1 do
                local vol = Musics1[i]:getVolume()
                Musics1[i]:setVolume(vol + 0.1)
            end
        elseif k == 'x' then
            for i = 1, 5 do
                local vol = Musics1[i]:getVolume()
                Musics1[i]:setVolume(vol - 0.1)
            end
        elseif k == 'c' then
            for i = 1, 5 do
                Musics1[i]:setVolume(1)
            end
        end
    elseif Level2 then
        if k == 'z' then
            for i = 1, #Musics2 do
                local vol = Musics2[i]:getVolume()
                Musics2[i]:setVolume(vol + 0.1)
            end
        elseif k == 'x' then
            for i = 1, 5 do
                local vol = Musics2[i]:getVolume()
                Musics2[i]:setVolume(vol - 0.1)
            end
        elseif k == 'c' then
            for i = 1, 5 do
                Musics2[i]:setVolume(1)
            end
        end
    end

    local SongSelectCon = true
    if SongSelectCon then
        local up = ']'
        local down = '['
        if Level1 then
            if k == up then
                SelectedSongL1 = SelectedSongL1 + 1
            elseif k == down then
                SelectedSongL1 = SelectedSongL1 - 1
            end
        elseif Level2 then
            if k == up then
                SelectedSongL2 = SelectedSongL2 + 1
            elseif k == down then
                SelectedSongL2 = SelectedSongL2 - 1
            end
        end
    end


    --individiual volume changing
    if Level1 then
        local selectedSong = SelectedSongL1
        if k == ',' then
                local vol = Musics1[selectedSong]:getVolume()
                Musics1[selectedSong]:setVolume(vol + 0.1)
        elseif k == '.' then
                local vol = Musics1[selectedSong]:getVolume()
                Musics1[selectedSong]:setVolume(vol - 0.1)
        elseif k == '/' then
                Musics1[selectedSong]:setVolume(1)
        end
    elseif Level2 then
        local selectedSong = SelectedSongL2
        if k == ',' then
                local vol = Musics2[selectedSong]:getVolume()
                Musics2[selectedSong]:setVolume(vol + 0.1)
        elseif k == '.' then
                local vol = Musics2[selectedSong]:getVolume()
                Musics2[selectedSong]:setVolume(vol - 0.1)
        elseif k == '/' then
                Musics2[selectedSong]:setVolume(1)
        end
    end





    PauseStop(k, 'p', 's', Musics1)
    PauseStop(k, 'p', 's', Musics2)
    --[[if k == 'p' then
        for i = 1, 5 do
            Musics1[i]:pause()
        end
    end
    if k == 's' then
        for i = 1, 5 do
            Musics1[i]:stop()
        end
    end]]
    
end