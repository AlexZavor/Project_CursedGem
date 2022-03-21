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
class World
  def initialize(win)
    @win = win
    @wMap = []
   (@win.maxx()-2).times do
      x=[]
      (@win.maxy()-2).times do
        x.push(".")
      end
      @wMap.push(x)
    end
  end
  def draw()
    x=1
    @wMap.each do |col|
      y=1
      col.each do |char|
        @win.setpos(y,x)
        @win.addch(char)
        y+=1
      end
      x+=1
    end
    @win.attroff(color_pair(1))
    @win.box("%", "-")
    @win.attron(color_pair(1))
  end
end
def closewin(win)
  sleep 0.1
  win.clear
  win.refresh
  win.close
end


init_screen
start_color
curs_set(0) # invisible Cursor
noecho() #turn off autotype

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
  world = World.new(game)

  game.keypad(true)
  init_pair(1, COLOR_GREEN, COLOR_BLACK)

  #start drawing!
  game.box("*", "*")
  game.attrset(color_pair(1))
  game.setpos(game.maxy()/2,game.maxx()/2-10)
  game.addstr("Press Enter to Start")
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
    end
    game.clear  #refresh screen
    world.draw()
    player.draw()
    game.refresh
  end

  # Clearing windows each in turn
  closewin(win1)
  closewin(game)
rescue => ex
  Curses.close_screen
end
