#!/usr/bin/env ruby
require_relative '../lib/maze_checker'
require_relative '../lib/maze_navigator'

file = File.open('maze.txt', 'r')
parsed_maze = file.map do |row|
  row.split(' ').map { |room| room.delete('[]').split('') }
end

checker = MazeChecker.new(parsed_maze)

if checker.is_valid?
  puts 'Valid input has been received and is as follows:'
  puts '--------------------------------------------------'
  File.open('maze.txt', 'r').each {|line| puts line}
  puts '--------------------------------------------------'
  nav = MazeNavigator.new(parsed_maze)
  nav.find_routes
  puts nav.valid_route
else
  puts 'Maze is not valid'
end