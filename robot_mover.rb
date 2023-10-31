
class RobotMover
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  TABLE_MAX = 4
  F_MAX = DIRECTIONS.length - 1
  CLOCKWISE = FORWARD = 1
  COUNTER_CLOCKWISE = BACK = -1

  RobotPosition = Struct.new(:x, :y, :f) do
    def valid?
      values.all? { |value| value.is_a? Integer } &&
        x.between?(0, TABLE_MAX) &&
        y.between?(0, TABLE_MAX) &&
        f.between?(0, F_MAX)
    end

    def horizontal_facing?
      %w[NORTH SOUTH].include? DIRECTIONS[f]
    end

    def positive_facing?
      %w[NORTH EAST].include? DIRECTIONS[f]
    end

    def facing
      DIRECTIONS[f]
    end
  end

  def unplaced_new_robot
    RobotPosition.new
  end

  def report(position)
    return position unless position.valid?

    printf <<~HEREDOC
      #{position.x},#{position.y},#{position.facing}
      #{position_map(position)}
    HEREDOC

    position
  end

  def place(initial_position = unplaced_new_robot, x:, y:, facing:)
    new_position = RobotPosition.new(x: x, y: y, f: DIRECTIONS.index(facing))
    new_position.valid? ? new_position : initial_position
  end

  def move(initial_position)
    return initial_position unless initial_position.valid?

    new_position = initial_position.dup
    axis = initial_position.horizontal_facing? ? :y : :x
    direction = initial_position.positive_facing? ? FORWARD : BACK

    new_position[axis] = initial_position[axis] + direction
    new_position.valid? ? new_position : initial_position
  end

  def left(initial_position)
    return initial_position unless initial_position.valid?

    turn(initial_position, COUNTER_CLOCKWISE)
  end

  def right(initial_position)
    return initial_position unless initial_position.valid?

    turn(initial_position, CLOCKWISE)
  end

  private

  def position_map(position)
    table = ''
    [*0..TABLE_MAX].reverse.each do |row|
      if position.y == row
        [*0..TABLE_MAX].each do |col|
          table << if col == position.x
                     'R '
                   else
                     '■ '
                   end
        end
      else
        table << '■ ' * 5 unless position.y == row
      end
      table << "\n"
    end
    table
  end

  def turn(position, direction)
    position.f = (position.f + direction) % DIRECTIONS.length
    position
  end
end
