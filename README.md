# FLIRT Game Toolkit

FLIRT - это набор скриптов для удобной разработки игр в LÖVE.

FLIRT не позиционируется как игровой движок, а лишь
предоставляет дружественный интерфейс для упрощения написания небольших 2D игр c использованием анимаций,
игровых уровней, ИИ врагов, игрового меню и прочих типичных элементов почти любой игры.

Многие возможности "из коробки" могут показаться ограничениями, но это не так!
FLIRT имеет модульную структуру и любой компонент может быть легко кастомизирован под ваши нужды.

# Install

В данный момент я поддерживаю только версию  >=11.2 (Mysterious Mysteries) под linux,
и компиляцию игр под linux / android.

1) Установка LÖVE

    sudo add-apt-repository ppa:bartbes/love-stable && sudo apt-get update
    sudo apt-get install love

2) Создание .love файла

    zip -9 -r SuperGame.love .

3) Запустить

    love SuperGame.love

4) Сбилдить apk - TODO: https://love2d.org/wiki/Game_Distribution#Android