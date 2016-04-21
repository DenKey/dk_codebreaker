module DkCodebreaker
  class Game
    attr_reader :hint_status
    attr_reader :attempt
    attr_accessor :player

    def initialize player = nil, attempts = 10
      @submit_code = nil
      @secret_code = ""
      @player = player
      @attempt = 1
      @hint_status = false
      @limit = attempts
      @last_result = nil
    end

    def start
      1.upto(4) { @secret_code << "#{rand(1..6)}" }
    end

    def restart
      @attempt = 1
      @submit_code = nil
      @secret_code = ""
      @hint_status = false
      start
    end

    def guess submit_code
      if @attempt < @limit
        if submit_code.is_a? String
          return :less_then_four   if submit_code.size < 4
          submit_code = submit_code[0,4] if submit_code.size > 4
          submit_code.each_char { |x| return :guess_has_symbol if numeric?(x) != 0 }
          @submit_code = submit_code
          @attempt += 1
          @last_result = numbers_eq(position_eq) 
        else
          :code_not_string
        end
      else
        :you_lose
      end    
    end

    def hint
      unless @hint
        send = "****"
        num = rand(0..3)
        send[num] = @secret_code[num]
        @hint_status = true
        send
      end
    end

    def user_data
      [@last_result, @player, @attempt, @limit, Time.new.strftime("%m/%d/%Y/%H/%M")]
    end

    private

    def position_eq
      submits = @submit_code.split("")
      secrets = @secret_code.split("")
      answer  = ""

      submits.each_with_index do |submit,index|
        if submit == secrets[index]
          answer  << "+"
          submits[index] = nil
          secrets[index] = nil 
        end        
      end

      [answer, submits, secrets]
    end

    def numbers_eq array
      array[1].each do |submit| #submits
        next if submit == nil
        array[0] << "-" if array[2].include?(submit)
      end
      array[0]
    end

    def numeric?(lookAhead)
      lookAhead =~ /[[:digit:]]/
    end
  end
end