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

    ball = {
        x = windowWidth / 2 - 10,
        y = windowHeight / 2 - 10,
        width = 20,
        height = 20,
        dx = 250,
        dy = 180
    }
end

-- AABB checks whether two axis-aligned rectangles overlap.
function checkCollision(a, b)
    return a.x < b.x + b.width
        and a.x + a.width > b.x
        and a.y < b.y + b.height
        and a.y + a.height > b.y
end

function love.update(dt)
    local _, windowHeight = love.graphics.getDimensions()

    -- Multiplying speed by dt makes movement depend on elapsed seconds,
    -- rather than on how many update calls the computer can run each second.
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

    leftPaddle.y = math.max(0, math.min(windowHeight - leftPaddle.height, leftPaddle.y))
    rightPaddle.y = math.max(0, math.min(windowHeight - rightPaddle.height, rightPaddle.y))

    -- dx and dy are velocities in pixels per second; dt converts them to
    -- the distance the ball travels during this particular update.
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    -- Bounce off the top and bottom edges, then keep the ball fully inside.
    if ball.y < 0 then
        ball.y = 0
        ball.dy = -ball.dy
    elseif ball.y + ball.height > windowHeight then
        ball.y = windowHeight - ball.height
        ball.dy = -ball.dy
    end

    -- Only bounce when moving toward a paddle. Repositioning the ball outside
    -- the paddle means the overlap cannot trigger again on the next frame.
    if ball.dx < 0 and checkCollision(ball, leftPaddle) then
        ball.x = leftPaddle.x + leftPaddle.width
        ball.dx = -ball.dx
    elseif ball.dx > 0 and checkCollision(ball, rightPaddle) then
        ball.x = rightPaddle.x - ball.width
        ball.dx = -ball.dx
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", leftPaddle.x, leftPaddle.y, leftPaddle.width, leftPaddle.height)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, rightPaddle.width, rightPaddle.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end
