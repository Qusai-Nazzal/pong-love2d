function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong")

    love.graphics.setBackgroundColor(0.08, 0.08, 0.12)

    local windowWidth, windowHeight = love.graphics.getDimensions()
    leftPaddle = { x = 30, y = windowHeight / 2 - 50, width = 15, height = 100, speed = 300 }
    rightPaddle = { x = windowWidth - 45, y = windowHeight / 2 - 50, width = 15, height = 100, speed = 300 }

    ball = { x = 0, y = 0, width = 20, height = 20, dx = 250, dy = 180 }
    baseBallSpeed = math.sqrt(ball.dx * ball.dx + ball.dy * ball.dy)
    maximumBallSpeed = 600
    leftScore = 0
    rightScore = 0
    resetBall(1)
end

function resetBall(horizontalDirection)
    local windowWidth, windowHeight = love.graphics.getDimensions()
    ball.x = windowWidth / 2 - ball.width / 2
    ball.y = windowHeight / 2 - ball.height / 2
    ball.dx = baseBallSpeed * 0.8 * horizontalDirection
    ball.dy = baseBallSpeed * 0.6
end

-- AABB checks whether two axis-aligned rectangles overlap.
function checkCollision(a, b)
    return a.x < b.x + b.width
        and a.x + a.width > b.x
        and a.y < b.y + b.height
        and a.y + a.height > b.y
end

function increaseBallSpeed()
    local currentSpeed = math.sqrt(ball.dx * ball.dx + ball.dy * ball.dy)
    local newSpeed = math.min(currentSpeed * 1.05, maximumBallSpeed)
    local scale = newSpeed / currentSpeed
    ball.dx = ball.dx * scale
    ball.dy = ball.dy * scale
end

function love.update(dt)
    local windowWidth, windowHeight = love.graphics.getDimensions()

    -- dt is elapsed time in seconds. Multiplying by it makes movement frame-rate independent.
    if love.keyboard.isDown("w") then leftPaddle.y = leftPaddle.y - leftPaddle.speed * dt end
    if love.keyboard.isDown("s") then leftPaddle.y = leftPaddle.y + leftPaddle.speed * dt end
    if love.keyboard.isDown("up") then rightPaddle.y = rightPaddle.y - rightPaddle.speed * dt end
    if love.keyboard.isDown("down") then rightPaddle.y = rightPaddle.y + rightPaddle.speed * dt end

    leftPaddle.y = math.max(0, math.min(windowHeight - leftPaddle.height, leftPaddle.y))
    rightPaddle.y = math.max(0, math.min(windowHeight - rightPaddle.height, rightPaddle.y))

    -- dx and dy are velocities in pixels per second; dt converts them to distance this update.
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    if ball.y < 0 then
        ball.y = 0
        ball.dy = -ball.dy
    elseif ball.y + ball.height > windowHeight then
        ball.y = windowHeight - ball.height
        ball.dy = -ball.dy
    end

    -- Reposition outside the paddle after a hit so overlap cannot trigger twice.
    if ball.dx < 0 and checkCollision(ball, leftPaddle) then
        ball.x = leftPaddle.x + leftPaddle.width
        ball.dx = -ball.dx
        increaseBallSpeed()
    elseif ball.dx > 0 and checkCollision(ball, rightPaddle) then
        ball.x = rightPaddle.x - ball.width
        ball.dx = -ball.dx
        increaseBallSpeed()
    end

    if ball.x + ball.width < 0 then
        rightScore = rightScore + 1
        resetBall(1)
    elseif ball.x > windowWidth then
        leftScore = leftScore + 1
        resetBall(-1)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", leftPaddle.x, leftPaddle.y, leftPaddle.width, leftPaddle.height)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, rightPaddle.width, rightPaddle.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)

    local windowWidth = love.graphics.getWidth()
    love.graphics.printf(tostring(leftScore), windowWidth / 2 - 100, 30, 80, "center")
    love.graphics.printf(tostring(rightScore), windowWidth / 2 + 20, 30, 80, "center")
end
