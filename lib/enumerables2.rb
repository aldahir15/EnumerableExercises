require 'byebug'

# EASY

# Define a method that returns the sum of all the elements in its argument (an
# array of numbers).
def array_sum(arr)
  return 0 if arr.empty?
  arr.inject(:+)
end

# Define a method that returns a boolean indicating whether substring is a
# substring of each string in the long_strings array.
# Hint: you may want a sub_tring? helper method
def sub_tring?(substring, long_string)
  return true if long_string.include?(substring)
  return false
end

def in_all_strings?(long_strings, substring)
  long_strings.each{|x| return false if sub_tring?(substring, x) == false}
  return true
end

# Define a method that accepts a string of lower case words (no punctuation) and
# returns an array of letters that occur more than once, sorted alphabetically.
def non_unique_letters(string)
  new_arr = string.delete(" ").split("")
  new_hash = Hash[new_arr.collect { |x| [x, new_arr.count(x)] }]
  final_arr = []
  new_hash.keys.each{|y| final_arr << y if new_hash[y] > 1 }
  final_arr
end


# Define a method that returns an array of the longest two words (in order) in
# the method's argument. Ignore punctuation!
def longest_two_words(string)
  new_arr = string.split(" ")
  sorted_arr = new_arr.sort_by{|word| word.length}
  [sorted_arr[-1],sorted_arr[-2]]
end

# MEDIUM

# Define a method that takes a string of lower-case letters and returns an array
# of all the letters that do not occur in the method's argument.
def missing_letters(string)
  alphabet = ("a".."z").to_a
  new_arr = string.delete(" ").split("").uniq
  alphabet - new_arr
end

# Define a method that accepts two years and returns an array of the years
# within that range (inclusive) that have no repeated digits. Hint: helper
# method?
def no_repeat_years(first_yr, last_yr)
  first_arr = (first_yr..last_yr).to_a
  first_arr.map{|x| x if not_repeat_year?(x)}.compact
end

def not_repeat_year?(year)
  new_arr = year.to_s.split("")
  true if new_arr == new_arr.uniq
end

# HARD

# Define a method that, given an array of songs at the top of the charts,
# returns the songs that only stayed on the chart for a week at a time. Each
# element corresponds to a song at the top of the charts for one particular
# week. Songs CAN reappear on the chart, but if they don't appear in consecutive
# weeks, they're "one-week wonders." Suggested strategy: find the songs that
# appear multiple times in a row and remove them. You may wish to write a helper
# method no_repeats?
def no_repeats?(song_name, songs)
  songs.each_with_index do |x,y|
    if x == song_name
      return false if songs[y-1] == x
    end
  end
  return true
end

def one_week_wonders(songs)
  songs.map{|w| w if no_repeats?(w, songs)}.compact.uniq
end


# Define a method that, given a string of words, returns the word that has the
# letter "c" closest to the end of it. If there's a tie, return the earlier
# word. Ignore punctuation. If there's no "c", return an empty string. You may
# wish to write the helper methods c_distance and remove_punctuation.

def for_cs_sake(string)
  string_arr = string.split(" ")
  distance_arr = string_arr.map{|x| c_distance(x)}
  no_symbols(string_arr[distance_arr.index(distance_arr.min)])
end

def c_distance(word)
  actual_word = no_symbols(word).reverse
  return actual_word.index("c") unless actual_word.index("c") == nil
  100000
end

def no_symbols(word)
  alpha = ("a".."z").to_a
  word_arr = word.split("")
  new_word = ""
  word_arr.each{|x| new_word << x if alpha.include?(x)}
  new_word
end

# Define a method that, given an array of numbers, returns a nested array of
# two-element arrays that each contain the start and end indices of whenever a
# number appears multiple times in a row. repeated_number_ranges([1, 1, 2]) =>
# [[0, 1]] repeated_number_ranges([1, 2, 3, 3, 4, 4, 4]) => [[2, 3], [4, 6]]

def repeated_number_ranges(arr)
  return [] if arr == arr.uniq
  final_arr = []
  arr.each_with_index{|x,y|
    count_start = y
    count_end = y
    while arr[count_end] == x
      count_end += 1
    end
    next if final_arr.flatten.include?(count_end-1)
    final_arr << [count_start,count_end-1] unless count_start+1 == count_end
  }
  final_arr
end
