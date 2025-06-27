WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_H = 20
PADDLE_W = 5

PADDLE_X_MARGIN = 10
PADDLE_Y_MARGIN = 10

PADDLE_VERTICAL_SPEED = 200

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    largeFont = love.graphics.newFont('VCR_OSD_MONO.ttf', 32)
    smallFont = love.graphics.newFont('VCR_OSD_MONO.ttf', 8)

    player1Score = 0
    player2Score = 0

    player1x = PADDLE_X_MARGIN
    player1y = PADDLE_Y_MARGIN
    player2x = VIRTUAL_WIDTH - PADDLE_X_MARGIN - PADDLE_W
    player2y = VIRTUAL_HEIGHT - PADDLE_Y_MARGIN - PADDLE_H


    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false
    })
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, { upscale = 'normal' })
end

function love.update(dt)

    -- These don't curently need to be called every frame - keeping here in case paddle margins or paddle size might change
    paddle_min_y = PADDLE_Y_MARGIN
    paddle_max_y = VIRTUAL_HEIGHT - PADDLE_H - PADDLE_Y_MARGIN
    
    if love.keyboard.isDown('w') then
        player1y = math.max(paddle_min_y, player1y + -PADDLE_VERTICAL_SPEED * dt)
    end
    if love.keyboard.isDown('s') then
        player1y = math.min(paddle_max_y, player1y + PADDLE_VERTICAL_SPEED * dt)
    end
    if love.keyboard.isDown('up') then
        player2y = math.max(paddle_min_y, player2y + -PADDLE_VERTICAL_SPEED * dt)
    end
    if love.keyboard.isDown('down') then
        player2y = math.min(paddle_max_y, player2y + PADDLE_VERTICAL_SPEED * dt)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:start()
    love.graphics.clear(25/255, 40/255, 50/255, 1)
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 80)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 80)
    
    -- paddle 1
    love.graphics.rectangle('fill', player1x, player1y, PADDLE_W, PADDLE_H)

    -- paddle 2
    love.graphics.rectangle('fill', player2x, player2y, PADDLE_W, PADDLE_H)

    -- ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:finish()
end