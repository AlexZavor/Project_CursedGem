#Cursed Gem game, made for me to practice so lay off.

require 'curses'
include Curses

class Character
  def initialize(x,y, win)
     @x, @y = x, y
     @win = win
  end
  def draw()
    @win.setpos(2*@y+1,2*@x+1)
    @win.addstr("xx")
    @win.setpos(2*@y+2,2*@x+1)
    @win.addstr("##")
  end
  def movex(x)
    if(@x+x <= cols/2-2 && @x+x >= 0)then
      @x += x
    end
  end
  def movey(y)
    if(@y+y <= lines/2-4 && @y+y >= 0)then
      @y += y
    end
  end
end

init_screen
start_color
curs_set(0) # invisible Cursor

begin
  # Building a static for UI
  win1 = Curses::Window.new(5, cols, lines-5, 0)
  win1.box("|", "-")
  win1.setpos(2, 2)
  win1.addstr("Hello World!")
  win1.refresh

  # Game window
  game = Curses::Window.new(lines-5, cols,
                            0, 0)
  player = Character.new(4,4,game)

  game.keypad(true)
  noecho()
  init_pair(1, COLOR_GREEN, COLOR_BLACK)
  game.box("*", "*")
  game.attrset(color_pair(1))
  player.draw()
  while true
  input = game.get_char()
    if input == KEY_DC then #exit with delete
      break
    elsif input == KEY_UP then
      player.movey(-1)
    elsif input == KEY_DOWN then
      player.movey(1)
    elsif input == KEY_LEFT then
      player.movex(-1)
    elsif input == KEY_RIGHT then
      player.movex(1)
    elsif input != nil
      #wintext.insch(input)
    end
    game.clear
    game.attroff(color_pair(1))
    game.box("*", "*")
    game.attron(color_pair(1))
    player.draw()
    game.refresh
  end

  # Clearing windows each in turn
  sleep 0.2
  win1.clear
  win1.refresh
  win1.close
  sleep 0.2
  game.clear
  game.refresh
  game.close
  sleep 0.2
rescue => ex
  Curses.close_screen
end
