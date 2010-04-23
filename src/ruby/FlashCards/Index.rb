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

private

  def load_from_file( file )
    File.open(file).lines.each do |line|
      return if line.strip!.empty?
      front, back = line.split('-')
      front.strip!
      back.strip!
      
      @cards << Card.new( front, back )
    end
  end
  
end

end # END MODULE

