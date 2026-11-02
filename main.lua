function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong")

    -- Keep the background dark so the paddles and ball are easy to see.
    love.graphics.setBackgroundColor(0.08, 0.08, 0.12)

    local windowWidth, windowHeight = love.graphics.getDimensions()

    leftPaddle = {
        x = 30,
        y = windowHeight / 2 - 50,
        width = 15,
        height = 100,
        speed = 300
    }

    rightPaddle = {
        x = windowWidth - 45,
        y = windowHeight / 2 - 50,
        width = 15,
        height = 100,
        speed = 300
    }
end

function love.update(dt)
    local _, windowHeight = love.graphics.getDimensions()

    -- dt is elapsed time in seconds since the previous update.
    if love.keyboard.isDown("w") then
        leftPaddle.y = leftPaddle.y - leftPaddle.speed * dt
    end
    if love.keyboard.isDown("s") then
        leftPaddle.y = leftPaddle.y + leftPaddle.speed * dt
    end
    if love.keyboard.isDown("up") then
        rightPaddle.y = rightPaddle.y - rightPaddle.speed * dt
    end
    if love.keyboard.isDown("down") then
        rightPaddle.y = rightPaddle.y + rightPaddle.speed * dt
    end

    -- Clamp each paddle so it stays within the top and bottom of the window.
    leftPaddle.y = math.max(0, math.min(windowHeight - leftPaddle.height, leftPaddle.y))
    rightPaddle.y = math.max(0, math.min(windowHeight - rightPaddle.height, rightPaddle.y))
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", leftPaddle.x, leftPaddle.y, leftPaddle.width, leftPaddle.height)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, rightPaddle.width, rightPaddle.height)
end
