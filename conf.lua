function love.conf(t)
	t.identity = nil                    -- директория с сохранениями
    t.version = "11.2"                  -- версия движка
    t.accelerometerjoystick = true      -- включить акселерометр в качестве джойстика
    t.gammacorrect = false              -- включить гамма-коррекцию

    t.audio.mixwithsystem = true        -- оставить фоновую музыку, если запущено приложение
 
    t.window.title = "Flirt"            -- заголовок окна
    t.window.icon = nil                 -- путь до иконки
    t.window.width = 800                -- ширина окна
    t.window.height = 600               -- высота окна
    t.window.borderless = true          -- убрать границы окна
    t.window.resizable = false          -- оставить возможность ресайза
    t.window.fullscreen = false         -- включить фулскрин
    t.window.fullscreentype = "desktop" -- desktop | exclusive - режимы фулскрина
    t.window.vsync = 1                  -- включить вертикальную синхронизацию
    t.window.msaa = 0                   -- кол-во кадров для мультикадрового сглаживания
    t.window.depth = nil                -- битность кадров в глубину буффера
    t.window.stencil = nil              -- битность кадров в шаблон буффера
    t.window.display = 1                -- номер монитора
    t.window.highdpi = false            -- включить поддержку Retina
    t.window.x = nil                    -- смещение окна по x
    t.window.y = nil                    -- смещение окна по y

    -- подсистемы
    t.modules.audio = true
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.video = true
    t.modules.window = true
end