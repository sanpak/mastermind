class Code
  PEGS = { 0 => "r", 1 => "g", 2 => "b", 3 => "y", 4 => "o", 5 => "p" }
  attr_reader :pegs
  def initialize(pegs)
    puts "_________________"
    p @pegs = pegs
    puts "_________________"
  end

  def [](pegs)
    puts "______[]____________"
    @pegs[pegs]
  end

  def self.random
    first_peg = PEGS[rand(6)]
    second_peg = PEGS[rand(6)]
    third_peg = PEGS[rand(6)]
    fourth_peg = PEGS[rand(6)]
    random_pegs = [first_peg,second_peg,fourth_peg,fourth_peg]
    code = Code.new(random_pegs)
  end

  def self.parse(input)
    # puts "____________________________"
    input = input.downcase.chars
    input.each do |input|
      raise "invalid colors" unless PEGS.has_value?(input)
    end
    code = Code.new(input)
  end

  def exact_matches(other_code)

    # p other_code
    puts "___________other_code__________"
    match_count = 0
    other_code.pegs.each_with_index do |peg,idx|
      match_count += 1 if @pegs[idx] == peg
    end
    # (0...other_code.pegs.length) do |idx|
    #   # return 0 unless @pegs.include?(other_code.pegs[idx])
    #   # match_count += 1 if @pegs[idx] == other_code.pegs[idx]
    # end
    match_count
  end

  def near_matches(other_code)
  end
end

class Game
  attr_reader :secret_code
  def initialize(code = nil)

  end

  def display_matches
  end
end
