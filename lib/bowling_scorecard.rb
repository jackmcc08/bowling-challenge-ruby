class BowlingScorecard
  attr_reader :current_score, :frame

  def initialize
    @frame = 1
    @first_roll = nil
    @second_roll = nil
    @roll_score = nil
    @strike = false
    @spare = false
    @bonus_points = nil
    @frame_score = 0
    @current_score = 0
    @score_log = []
  end

  def enter_roll(score)
    return "Invalid score entered, entered_score must be between 0 and 10." unless valid?(score)

    update_current_and_frame(score)
    assign(score)
    update_score_log
    increment_frame_if_end_frame

    score
  end

  def display_scorecard
    @score_log
  end

private
  def valid?(score)
    return false if (score > 10 || score.negative?)

    true
  end

  def assign(score)
    if @first_roll.nil?
      @strike = true if score == 10
      @first_roll = score
    else
      @second_roll = score
    end
  end

  def increment_frame_if_end_frame
    if @first_roll != nil and @second_roll != nil
      @frame += 1
      reset_frame_stats
    elsif @first_roll != nil and @strike == true
      @frame += 1
      reset_frame_stats
    end
  end

  def reset_frame_stats
    @first_roll = nil
    @second_roll = nil
    @strike = false
    @frame_score = 0
  end

  def update_current_and_frame(score)
    @frame_score += score
    @current_score += score
  end

  def calculate(score)
    score
  end

  def update_score_log
    if @score_log.length < @frame
      @score_log << current_frame_information
    else
      @score_log[@frame - 1] = current_frame_information
    end
  end

  def current_frame_information
    {
      frame: @frame,
      first_roll: @first_roll,
      second_roll: @second_roll,
      strike: @strike,
      spare: @spare,
      bonus_points: @bonus_points,
      frame_score: @frame_score,
      total_score: @current_score
    }
  end
end
