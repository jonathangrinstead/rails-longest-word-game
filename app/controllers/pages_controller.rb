require "json"
require "open-uri"

class PagesController < ApplicationController

  def home
  end

  def game
    @letters = ""
    array = ('a'..'z').to_a.sample(10)
    array.each do |letter|
      @letters += "   #{letter}    "
    end
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].downcase
    @check_included = check_included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def check_included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_parsed = URI.open(url).read
    words = JSON.parse(word_parsed)
    words['found']
  end
end
