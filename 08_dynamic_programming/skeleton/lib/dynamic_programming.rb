# Dynamic Programming practice
# NB: you can, if you want, define helper functions to create the necessary caches as instance variables in the constructor.
# You may find it helpful to delegate the dynamic programming work itself to a helper method so that you can
# then clean out the caches you use.  You can also change the inputs to include a cache that you pass from call to call.

class DPProblems
  def initialize
    # Use this to create any instance variables you may need
  end

  # Takes in a positive integer n and returns the nth Fibonacci number
  # Should run in O(n) time
  def fibonacci(n, fibs = {1 => 1, 2 => 1})
    return nil if n <= 0
    return fibs[n] if fibs[n]

    fib = fibonacci(n - 1, fibs) + fibonacci(n - 2, fibs)
    fibs[n] = fib

    fib
  end

  # Make Change: write a function that takes in an amount and a set of coins.  Return the minimum number of coins
  # needed to make change for the given amount.  You may assume you have an unlimited supply of each type of coin.
  # If it's not possible to make change for a given amount, return nil.  You may assume that the coin array is sorted
  # and in ascending order.
  def make_change(amt, coins, coin_cache = {0 => 0})
    return coin_cache[amt] if coin_cache[amt]
    return 0.0/0.0 if amt < coins[0]

    min = amt
    change_possible = false
    coins.each do |coin|
      next if coin > amt

      test_change = make_change(amt - coin, coins, coin_cache) + 1
      if test_change.integer? && test_change < min
        change_possible = true
        min = test_change
      end
    end

    min = 0.0/0.0 unless change_possible
    coin_cache[amt] = min

    min
  end

  # Knapsack Problem: write a function that takes in an array of weights, an array of values, and a weight capacity
  # and returns the maximum value possible given the weight constraint.  For example: if weights = [1, 2, 3],
  # values = [10, 4, 8], and capacity = 3, your function should return 10 + 4 = 14, as the best possible set of items
  # to include are items 0 and 1, whose values are 10 and 4 respectively.  Duplicates are not allowed -- that is, you
  # can only include a particular item once.
  def knapsack(weights, values, capacity)
    values_table = []

    for i in (0..capacity) do
      values_table[i] = []
      for j in (0...weights.count) do
        if i == 0
          values_table[i][j] = 0
        else
          current_weight = weights[j]
          current_capacity = i

          current_best = values_table[current_capacity][j - 1]

          if current_weight > current_capacity
            test_diff = j.zero? ? 0 : values_table[current_capacity - current_weight][j - 1]
            test_best = test_diff + current_weight
            current_best = test_best if test_best > current_best
          end

          values_table[i][j] = current_best
        end
      end
    end

    values_table.last.last
  end

  # Stair Climber: a frog climbs a set of stairs.  It can jump 1 step, 2 steps, or 3 steps at a time.
  # Write a function that returns all the possible ways the frog can get from the bottom step to step n.
  # For example, with 3 steps, your function should return [[1, 1, 1], [1, 2], [2, 1], [3]].
  # NB: this is similar to, but not the same as, make_change.  Try implementing this using the opposite
  # DP technique that you used in make_change -- bottom up if you used top down and vice versa.
  def stair_climb(n, step_sizes = [1, 2, 3], poss_steps = { 0 => [[]] })
    (1..n).each do |current_step|
      poss_steps[current_step] = []

      step_sizes.each do |next_step|
        last_counts = current_step - next_step
        next if last_counts < 0

        poss_steps[last_counts].each do |count|
          poss_steps[current_step] += [count + [next_step]]
        end
      end
    end

    poss_steps[n]
  end

  # String Distance: given two strings, str1 and str2, calculate the minimum number of operations to change str1 into
  # str2.  Allowed operations are deleting a character ("abc" -> "ac", e.g.), inserting a character ("abc" -> "abac", e.g.),
  # and changing a single character into another ("abc" -> "abz", e.g.).
  def str_distance(str1, str2)

  end

  # Maze Traversal: write a function that takes in a maze (represented as a 2D matrix) and a starting
  # position (represented as a 2-dimensional array) and returns the minimum number of steps needed to reach the edge of the maze (including the start).
  # Empty spots in the maze are represented with ' ', walls with 'x'. For example, if the maze input is:
  #            [['x', 'x', 'x', 'x'],
  #             ['x', ' ', ' ', 'x'],
  #             ['x', 'x', ' ', 'x']]
  # and the start is [1, 1], then the shortest escape route is [[1, 1], [1, 2], [2, 2]] and thus your function should return 3.
  def maze_escape(maze, start)

  end
end
