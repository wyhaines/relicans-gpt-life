require "colorize"

# I want to write a Ruby script to play Conway's Game of Life with a random board, in a terminal.

class Life
  attr_reader :board, :size

  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) }
  end

  def randomize
    @board.each_index do |y|
      @board[y].each_index do |x|
        @board[y][x] = rand(2) == 0 ? false : true
      end
    end
  end

  def tick
    new_board = Array.new(@size) { Array.new(@size) }
      @board.each_index do |y|
        @board[y].each_index do |x|
        neighbors = 0
        (-1..1).each do |dy|
          (-1..1).each do |dx|
            if @board[(y + dy) % @size][(x + dx) % @size]
              neighbors += 1
            end
          end
        end
        if @board[y][x] && neighbors < 2
          new_board[y][x] = false
        elsif @board[y][x] && neighbors > 3
          new_board[y][x] = false
        elsif !@board[y][x] && neighbors == 3
          new_board[y][x] = true
        else
          new_board[y][x] = @board[y][x]
        end
      end
    end

    @board = new_board
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def print_block(x, y)
    print @board[y][x] ? " ".black.on_white : " "
  end

  def print_board
    clear_screen
    @board.each_index do |y|
      @board[y].each_index do |x|
        print_block(x, y)
      end
      puts
    end
  end
end

size = gets.to_i
life = Life.new(size)
life.randomize

life.clear_screen
while true
  life.tick
  life.print_board
  sleep 0.1
end
