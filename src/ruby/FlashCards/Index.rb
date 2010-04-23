################################################################################
# Index.rb 
# 
# William Madden, w.a.madden@gmail.com
# 23/04/2010
################################################################################

require "FlashCards/Card"

module FlashCards

# 
# A collection of cards loaded from file.
# 
class Index

  #-----------------------------------------------------------------------------
  #  
  #  Constructor
  #  
  #-----------------------------------------------------------------------------
  
  def initialize( file )
    @cards = []
    load_from_file( file )
  end

  #-----------------------------------------------------------------------------
  #  
  #  Properties
  #  
  #-----------------------------------------------------------------------------

  attr_accessor :cards

  #-----------------------------------------------------------------------------
  #  
  #  Methods
  #  
  #-----------------------------------------------------------------------------

  def shuffle
    for i in 0 .. @cards.length-1
      swap_with = rand( @cards.length )
      @cards[i], @cards[swap_with] = @cards[swap_with], @cards[i]

      if rand(2) >= 1
        @cards[i].front, @cards[i].back = @cards[i].back, @cards[i].front
      end
    end
  end
  
private

  def load_from_file( file )
    File.open(file).lines.each do |line|
      next if line.strip!.empty? || line.split('-').length != 2
      front, back = line.split('-')
      front.strip!
      back.strip!
      
      @cards << Card.new( front, back )
    end
  end
  
end

end # END MODULE

