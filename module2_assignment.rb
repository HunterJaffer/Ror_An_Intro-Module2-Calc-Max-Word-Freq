#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  attr_reader :highest_wf_count,:highest_wf_words,:content,:line_number

  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize (content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = Array.new()
    self.calculate_word_frequency
  end
  def calculate_word_frequency
    line_freq = Hash.new(0)
    @content.split.each do |word|
      line_freq[word.downcase] += 1
    end
    @highest_wf_count = line_freq.values.max
    line_freq = line_freq.select { |k, v| v == @highest_wf_count}
    line_freq.each_pair do |k,v|
      @highest_wf_words.push(k)
    end
  end
  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end

#  Implement a class called Solution.
class Solution

  # Implement the following read-only attributes in the Solution class.
  attr_reader :analyzers,:highest_count_across_lines,:highest_count_words_across_lines
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.

  # Implement the following methods in the Solution class.
  def initialize
    @analyzers = Array.new()
  end
  def analyze_file
    x = 1
    if File.exist? 'test.txt'
      File.foreach( 'test.txt' ) do |line|
        @analyzers << LineAnalyzer.new(line,x)
        x += 1
      end
    end
  end
  def calculate_line_with_highest_frequency
    x = 0
    @highest_count_across_lines = 0
    while x<@analyzers.length
      @highest_count_across_lines = @analyzers[x].highest_wf_count if @analyzers[x].highest_wf_count > @highest_count_across_lines

      x += 1
    end
    x = 0
    @highest_count_words_across_lines = Array.new()
    while x<@analyzers.length
      @highest_count_words_across_lines << @analyzers[x] if @analyzers[x].highest_wf_count ==@highest_count_across_lines
      x += 1
    end
  end
  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    x = 0
    while x<@highest_count_words_across_lines.length
      puts "#{@highest_count_words_across_lines[x].highest_wf_words} (appears in line #{@highest_count_words_across_lines[x].line_number})"
      x += 1
    end
  end
end
