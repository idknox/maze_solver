class MazeNavigator
  def initialize(maze)
    @maze = maze
    @routes = []
    @entrances = locate_entrances
    @current_location = @entrances.first
    @visited_locations = [@current_location]
    @instructions = ['Start in room: ']
    @moves = 0
  end

  def find_routes
    until exit_reached? do
      move_to_next
    end
  end

  def valid_routes
    @routes
  end

  private

  def locate_entrances
    entrances = []
    @maze.each_with_index do |row, row_i|
      row.each_with_index do |room, room_i|
        if room.include?('E')
          entrances << {row_i: row_i, room_i: room_i, room: room, entered_from: room.index('E'), room_number: calc_room_number}
        end
      end
    end
  end

  def exit_reached?
    @maze[@current_location[:row_i]][@current_location[:room_i]].include?('X')
  end

  def calc_room_number
  end

  def move_to_next
    @visited_locations << @current_location
    if door_north?
      move_north
    elsif door_east?
      move_east
    elsif door_south?
      move_south
    elsif door_west?
      move_west
    end
    @moves += 1
  end

  def door_north?
    @current_location[:room][0] == '*'
  end

  def door_east?
    @current_location[:room][1] == '*'
  end

  def door_south?
    @current_location[:room][2] == '*'
  end

  def door_west?
    @current_location[:room][3] == '*'
  end

  def move_north
    @current_location = {
      row_i: @current_location[:row_i]-1,
      room_i: @current_location[:room_i],
      room: @maze[@current_location[:row_i]-1][@current_location[:room_i]],
      entered_from: 2,
    }
    @instructions << 'Move north'
  end

  def move_east
    @current_location = {
      row_i: @current_location[:row_i],
      room_i: @current_location[:room_i]+1,
      room: @maze[@current_location[:row_i]][@current_location[:room_i]+1],
      entered_from: 3,
    }
  end

  def move_south
    @current_location = {
      row_i: @current_location[:row_i]+1,
      room_i: @current_location[:room_i],
      room: @maze[@current_location[:row_i]+1][@current_location[:room_i]],
      entered_from: 0,
    }
  end

  def move_west
    @current_location = {
      row_i: @current_location[:row_i],
      room_i: @current_location[:room_i]-1,
      room: @maze[@current_location[:row_i]][@current_location[:room_i]-1],
      entered_from: 1,
    }
  end


end