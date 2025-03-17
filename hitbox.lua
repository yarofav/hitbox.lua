local HITBOX_INCREASE_FACTOR = 25.0

-- Функция для увеличения хитбоксов и их визуализации
local function increaseAndShowHitbox(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            -- Увеличиваем размер части
            part.Size = part.Size * HITBOX_INCREASE_FACTOR

            -- Создаём BoxHandleAdornment для визуализации хитбокса
            local adornment = Instance.new("BoxHandleAdornment")
            adornment.Size = part.Size
            adornment.Adornee = part
            adornment.AlwaysOnTop = true
            adornment.ZIndex = 10
            adornment.Transparency = 0.97 -- Увеличиваем прозрачность до 70%
            adornment.Color3 = Color3.new(1, 0, 0) -- Красный цвет для видимости
            adornment.Parent = part
        end
    end
end

-- Функция для обработки персонажей игроков
local function handlePlayer(player)
    if player ~= game.Players.LocalPlayer then
        player.CharacterAdded:Connect(function(character)
            increaseAndShowHitbox(character)
        end)

        if player.Character then
            increaseAndShowHitbox(player.Character)
        end
    end
end

-- Обрабатываем всех игроков на сервере
for _, player in pairs(game.Players:GetPlayers()) do
    handlePlayer(player)
end

-- Обрабатываем новых игроков, которые присоединяются к игре
game.Players.PlayerAdded:Connect(handlePlayer)
