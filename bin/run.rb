#!usr/bin/env ruby
require_relative '../config/environment.rb'

require 'pry'


def user_logic(current_player)
  turn_over = false
  until turn_over
    CurrentPlayerMessage.new.render
    user_input = get_user_input
    if user_input == "Score"
      ViewScore.new.render
    elsif user_input == "Pairs"
      CLIMessages.play_pairs
      CardController.show_played
    elsif user_input == "Help"
      CLIHelpMenu.new.render
    elsif user_input == "Exit"
      puts "Thanks for playing! Have a nice day."
      exit
    elsif Card.number_array.include?(user_input)
      current_player.ask_and_take(user_input)
      Game.current_game.other_player.check_for_empty
      PlayerController.show_hand(current_player)
      turn_over = true
    else
      GameInvalidCommand.new.render
    end
  end
end

def create_game
  Game.new
end

def get_user_input
  user_input = gets.chomp.downcase.capitalize.strip
end

def turn(current_player)
  InsertFish.new.render
  PlayerController.show_hand(current_player)
  user_logic(current_player)
  # 2.times {current_player.find_matching}
  PlayerController.play_matching(current_player)
  current_player.check_for_empty
  ViewScore.new.render
  InsertFish.new.render
end

CLIGreeting.new.render
PlayerController.create_users
CLIHelpMenu.new.render
game = create_game

## THIS IS THE MAIN LOOP OF THE GAME!! ##
until game.game_over?
  turn(game.current_player)
  game.switch_player
end
