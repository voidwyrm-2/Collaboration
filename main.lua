function love.load()
    --init important stuff
    love.window.setTitle('Collaboration Music Player')
    local imageData = love.image.newImageData('Ligma.png')
    Success1 = love.window.setIcon(imageData)


    Paths1 = {'Level1/disc_cyberwave.ogg', 'Level1/Final Destination SSBB Remix.mp3', 'Level1/Murder Drones - Click(CaliberKat Remix).mp3', 'Level1/disc_cyberwave.ogg', 'Level1/disc_cyberwave.ogg'}

    Musics1 = {love.audio.newSource(Paths1[1], 'stream'), love.audio.newSource(Paths1[2], 'stream'), love.audio.newSource(Paths1[3], 'stream'), love.audio.newSource(Paths1[4], 'stream'), love.audio.newSource(Paths1[5], 'stream')}

    --TheSource 
    Level1 = true
    Level2 = false
    Level3 = false
    Level4 = false
end



function love.draw()
    love.graphics.print('Made by Nuclear Pasta', 320, 10)
    if not Success1 then
        love.graphics.print('Icon error', 20, 10)
    end

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
    for i = 1, 5 do
        love.graphics.print(i .. ': ' .. Paths1[i], 320, 70 + i * 20)
    end

    --list volumes
    for i = 1, 5 do
        local vol = Musics1[i]:getVolume()
        love.graphics.print(Paths1[i] .. ' volume: ' .. vol, 20, 300 + i * 20)
    end
    --love.graphics.print('1: disc_cyberwave.ogg', 320, 40)

    local touches = love.touch.getTouches()

    for i, id in ipairs(touches) do
        local x, y = love.touch.getPosition(id)
        love.graphics.circle("fill", x, y, 20)
    end
end



function love.keypressed(k)
    local canQuit = true
    if k == 'escape' and not canQuit then
        canQuit = true
        --love.graphics.print('Are you sure you want to quit?', 290, 30)
    elseif k == 'escape' and canQuit then
       love.event.quit()
    end

    if Level1 and not Level2 and not Level3 and not Level4 then
        if k == '1' and not Musics1[1]:isPlaying() then
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
        end
    end


    if k == 't' and not Level1 then
        Level1 = true

        Level2 = false
        Level3 = false
        Level4 = false
    elseif k == 't' and Level1 then
        Level1 = false

        Level2 = false
        Level3 = false
        Level4 = false
    end

    if k == 'y' and not Level2 then
        Level2 = true

        Level1 = false
        Level3 = false
        Level4 = false
    elseif k == 'y' and Level2 then
        Level2 = false

        Level1 = false
        Level3 = false
        Level4 = false
    end

    if k == 'u' and not Level3 then
        Level3 = true

        Level2 = false
        Level1 = false
        Level4 = false
    elseif k == 'u' and Level3 then
        Level3 = false

        Level2 = false
        Level1 = false
        Level4 = false
    end

    if k == 'i' and not Level4 then
        Level4 = true

        Level2 = false
        Level3 = false
        Level1 = false
    elseif k == 'o' and Level4 then
        Level4 = false

        Level2 = false
        Level3 = false
        Level1 = false
    elseif k == 'n' and (Level1 or Level2 or Level3 or Level4) then
        Level1 = false
        Level2 = false
        Level3 = false
        Level4 = false
    end

    if k == 'z' --[[and Level1 and not Level2 and not Level3 and not Level4]] then
        for i = 1, 5 do
            local vol = Musics1[i]:getVolume()
            Musics1[i]:setVolume(vol + 0.1)
        end
    elseif k == 'x' --[[and Level1 and not Level2 and not Level3 and not Level4]] then
        for i = 1, 5 do
            local vol = Musics1[i]:getVolume()
            Musics1[i]:setVolume(vol - 0.1)
        end
    elseif k == 'c' then
        for i = 1, 5 do
            Musics1[i]:setVolume(1)
        end
    end

    if k == 'p' then
        for i = 1, 5 do
            Musics1[i]:pause()
        end
    end
    if k == 's' then
        for i = 1, 5 do
            Musics1[i]:stop()
        end
    end
end