class Code
  PEGS = { 0 => "r", 1 => "g", 2 => "b", 3 => "y", 4 => "o", 5 => "p" }
  attr_reader :pegs
  def initialize(pegs)
    @pegs = pegs
  end

  def [](pegs)
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

  def ==(other_code)
      other_code == @pegs
  end

  def near_matches(other_code)
    match_count_near = 0
    other_code.pegs.each_with_index do |peg,idx|
      # p peg
      # p idx
      next if other_code.pegs[idx] == other_code.pegs[idx + 1]
      match_count_near += 1 if @pegs.include?(peg) && other_code.pegs[idx] != @pegs[idx]
      # p @pegs.index(peg)
      # p @pegs.include?(peg)
    end
    match_count_near
  end
end

class Game
  attr_reader :secret_code, :input, :output
  def initialize(code = nil)
    @secret_code = code
    @secret_code = Code.random if code == nil
  end

  def get_guess
    puts "give me a guess"
    input = gets.chomp
    get_guess = Code.parse(input)
  end

  def display_matches(code)
    # puts "exact" if code.pegs == @secret_code.pegs
    near_matches = @secret_code.near_matches(code)
    exact_matches = @secret_code.exact_matches(code)
    puts "#{near_matches} near matches, #{exact_matches} exact matches"
    # puts "_________________"
    # puts "[\"#{code.pegs[0]}\", \"#{code.pegs[1]}\", \"#{code.pegs[2]}\", \"#{code.pegs[3]}\"]"
    # puts "_________________"
    # if @secret_code.pegs == code.pegs
    #   puts "[\"#{@secret_code.pegs[0]}\", \"#{@secret_code.pegs[1]}\", \"#{@secret_code.pegs[2]}\", \"#{@secret_code.pegs[3]}\"]"
    # end
    # p @secret_code
  end

  def over?
    @guess == @secret_code
  end

  def play
    p @secret_code 
    until over?
      @guess = get_guess
      display_matches(@guess)
      # display_matches(get_guess)
    end
  end
end
if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
