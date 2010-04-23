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
    trap('SIGINT') do
      print_statistics
      exit
    end
    
    index_source = args[0]
    @index = Index.new( index_source )
    @index.shuffle
    
    cards = @index.cards
    
    @correct = []
    @incorrect = []
    
    cards.each do |card|
      puts "#{card.front}?"
      answer = $stdin.gets().strip!
      
      if card.try( answer )
        @correct << card
      else
        @incorrect << card
      end
      
      puts
    end
    
    print_statistics
  end

private

  def print_statistics
    puts 
    puts "You answered #{@correct.length} out of #{@index.cards.length} questions correctly"
    puts "That's #{((@correct.length / @index.cards.length.to_f) * 100).round}%!"

    return if @incorrect.length == 0
    
    puts 
    puts "You need to practice:"
    @incorrect.each do |card|
      puts "  #{card.front}"
      puts "    You answered:   #{card.supplied_answer.inspect}"
      puts "    Correct answer: #{card.back.inspect}"
    end
  end
  
end

end # END MODULE

