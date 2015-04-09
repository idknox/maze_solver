class MazeChecker
  def initialize(maze)
    @maze = maze
  end

  attr_reader :maze

  def is_valid?
    has_entrance_and_exit && rooms_valid?
  end

  private

  def has_entrance_and_exit
    @maze.flatten.include?('E') && @maze.flatten.include?('X')
  end

  def rooms_valid?
    @maze.each do |row|
      row.each do |room|
        if room.include?('X')
          unless on_perimeter?('X', row, room)
            return false
          end
        elsif room.include?('E')
          unless on_perimeter?('E', row, room)
            return false
          end
        elsif !room_valid?(room) || has_hole?(row, room)
          return false
        end
      end
    end

    true
  end

  def on_perimeter?(entry, row, room)
    on_top(entry, row, room) ||
      on_right(entry, row, room) ||
      on_left(entry, row, room) ||
      on_bottom(entry, row, room)
  end

  def room_valid?(room)
    copy = room.reject { |side| side == 'E' || side=='X' || side=='*' || side=='|' }
    if copy.empty? && room.length == 4 && room.include?('*')
      true
    else
      false
    end
  end

  def has_hole?(row, room)
    (@maze.index(row) == 0 && room.first != '|') ||
      (row.index(room) == row.length-1 && room[1] != '|') ||
      (row.index(room) == 0 && room.last != '|') ||
      (@maze.index(row) == @maze.length-1 && room[2] != '|')
  end

  def on_top(entry, row, room)
    @maze.index(row) == 0 && room.index(entry) == 0
  end

  def on_right(entry, row, room)
    row.index(room) == row.length-1 && room.index(entry) == 1
  end

  def on_left(entry, row, room)
    row.index(room) == 0 && room.index(entry) == room.length-1
  end

  def on_bottom(entry, row, room)
    @maze.index(row) == @maze.length-1 && room.index(entry) == 2
  end
end

