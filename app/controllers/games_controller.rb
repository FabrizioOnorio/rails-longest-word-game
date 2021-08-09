require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @guessed_world = params[:world].downcase
    @letters = params[:letters].downcase
    world_check = @guessed_world.chars.all? { |letter| @guessed_world.count(letter) <= @letters.count(letter) }
    if world_check == true
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@guessed_world}")
      json = JSON.parse(response.read)
      if json['found'] == true
        @print = ' is an english world, Congrats! :)'
      else
        @print = ' is not an english world. Try again :)'
      end
    else
      @print = ' is not validated. Please, try again :)'
    end
  end
end
