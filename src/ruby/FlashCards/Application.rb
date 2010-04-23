################################################################################
# Application.rb 
# 
# William Madden, w.a.madden@gmail.com
# 23/04/2010
################################################################################

require "FlashCards/Index"
require "FlashCards/Card"

module FlashCards

# 
# The Flashcards application.
# 
class Application

  #-----------------------------------------------------------------------------
  #  
  #  Constructor
  #  
  #-----------------------------------------------------------------------------
  
  def initialize()
    @index = nil
  end

  #-----------------------------------------------------------------------------
  #  
  #  Properties
  #  
  #-----------------------------------------------------------------------------
  
  attr_accessor :index

  #-----------------------------------------------------------------------------
  #  
  #  Methods
  #  
  #-----------------------------------------------------------------------------
  
  def run( args )
    index_source = args[0]
    @index = Index.new( index_source )
    
    cards = Array.new( @index.cards )
    
    srand
    shuffle( cards )
    
    correct = []
    incorrect = []
    
    cards.each do |card|
      puts "#{card.front}?"
      card.supplied_answer = $stdin.gets().strip!
      
      if card.supplied_answer == card.back
        correct << card
      else
        incorrect << card
      end

      puts
    end

    puts "\nYou answered #{correct.length} questions correctly"
    puts "That's #{(correct.length / cards.length * 100).round}%!"
    puts 
    puts "You need to practice:"
    incorrect.each do |card|
      puts "  #{card.front}"
      puts "    You answered:   #{card.supplied_answer.inspect}"
      puts "    Correct answer: #{card.back.inspect}"
    end
  end

private

  def shuffle( cards )
    for i in 0 .. cards.length-1
      swap_with = rand( cards.length )
      cards[i], cards[swap_with] = cards[swap_with], cards[i]
    end
    cards
  end
  
end

end # END MODULE

