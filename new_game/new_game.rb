root = File.expand_path("../", File.dirname(__FILE__))
require "#{root}/lib/tic_tac_toe.rb"

puts "Welcome to Tic Tac Toe"
puts "Player 1, please enter your name"
player1 = gets.chomp
puts "Player 2, please enter your name"
player2 = gets.chomp
p1 = TicTacToe::Player.new({color: "X", name: "#{player1}"})
p2 = TicTacToe::Player.new({color: "0", name: "#{player2}"})
players = [p1, p2]
TicTacToe::Game.new(players).play
