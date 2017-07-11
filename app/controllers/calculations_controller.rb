class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @occurrences = @text.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@principal*((@apr/100/12)*(((1+(@apr/12/100))**(@years*12))))/(((1+(@apr/12/100))**(@years*12))-1))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/3600
    @days = (@ending - @starting)/86400
    @weeks = (@ending - @starting)/604800
    @years = (@ending - @starting)/31557600

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    if @numbers.count.odd?
      @median = @numbers.sort[@numbers.count/2]
    else 
      @median = (@numbers.sort[@numbers.count/2] + @numbers.sort.reverse[@numbers.count/2])/2
    end
              # while @numbers.count > 2
              #   @numbers.first.chomp
              #   @numbers.last.chomp
              # end  
    
              # @numbers.first

    @sum = @numbers.sum

    @mean = @numbers.sum/@numbers.count
      
      @var = []
      @numbers.each do |vars|
        square = ((vars - (@numbers.sum/@numbers.count)) ** 2)
        @var.push(square)
      end  
    @variance = @var.sum/@numbers.count

    @standard_deviation = Math.sqrt(@var.sum/@numbers.count)

      @possibles = 0
      @possibles_count = 0
      @numbers.each do |num|
        if @numbers.count(num) > @possibles_count
          @possibles = num
          @possibles_count = @numbers.count(num)
        end   
      end
    @mode = @possibles

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
