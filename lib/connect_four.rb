require_relative "./cell.rb"
require_relative "./board.rb"
require_relative "./core_extensions.rb"
require_relative "./game.rb"
require_relative "./player.rb"

include ConnectFour

puts "Welcome to Connect Four!"
puts ""
puts "Enter player 1:"
p1 = Player.new({color: "X", name: gets.chomp})
puts "Enter player 2:"
p2 = Player.new({color: "O", name: gets.chomp})
Game.new([p1, p2]).play
