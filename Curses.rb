require 'curses'
include Curses

init_screen
start_color
curs_set(1) # Invisible Cursor

#	hello world with curses
#begin
#  x = cols / 2  # We will center our text
#  y = lines / 2
#  setpos(y, x)  # Move the cursor to the center of the screen
#  attrset(color_pair(1))
#  addstr("Hello World#{rdm}")  # Display the text
#  refresh  # Refresh the screen
#  getch  # Waiting for a pressed key to exit
#ensure
#  close_screen
#end


begin
  # Building a static window
  win1 = Curses::Window.new(5, cols, 0, 0)
  win1.box(" ", "-")
  win1.setpos(2, 2)
  win1.addstr("Hello World!")
  win1.refresh

  # Text writer
  win2 = Curses::Window.new(Curses.lines / 2 - 1, Curses.cols, 
                            Curses.lines / 2, 0)
  init_pair(1, COLOR_GREEN, COLOR_BLACK)
  win2.box("|", "-")
  win2.refresh
  # Text box
  wintext = Curses::Window.new(Curses.lines/2-3, Curses.cols-2,
			    Curses.lines/2+1,1)

  # Main loop for text
  wintext.setpos(0,0)
  wintext.attrset(Curses.color_pair(1))
  wintext.keypad(true)
  while true
  input = wintext.get_char()
    if input == KEY_DC then #exit with delete
      break
    elsif input == KEY_BACKSPACE then
      wintext.move(0,-1)
    elsif input == KEY_LEFT then
      wintext.move(0,-1)
    elsif input != nil
      #wintext.insch(input)
    end
    wintext.refresh
  end

  # Clearing windows each in turn
  sleep 0.2
  win1.clear
  win1.refresh
  win1.close
  sleep 0.2
  wintext.clear
  wintext.refresh
  wintext.close
  sleep 0.2
  win2.clear
  win2.refresh
  win2.close
  sleep 0.2
rescue => ex
  Curses.close_screen
end
