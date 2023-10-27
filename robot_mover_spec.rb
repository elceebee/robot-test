require 'minitest/autorun'
require './robot_mover'

describe RobotMover do
  before do
    @robot_mover = RobotMover.new
    @unplaced_robot = @robot_mover.unplaced_new_robot
  end

  describe "#place" do
    it "does not put the robot off the table" do
      @robot_mover.place(x: RobotMover::TABLE_MAX + 2, y: 0, facing: "NORTH").values.must_equal [nil, nil, nil]
    end

    it "places the robot on the table" do
      @robot_mover.place(x: 0, y: 0, facing: "NORTH").values.must_equal [0, 0, 0]
    end
  end

  describe "left" do
    it "does not turn if not placed" do
      @robot_mover.left(@unplaced_robot).must_equal @unplaced_robot
    end

    it "turns counter-clockwise" do
      north_facing_robot = @robot_mover.place(x: 0, y: 0, facing: "NORTH")
      west_facing_robot = @robot_mover.left(north_facing_robot)
      west_facing_robot.facing.must_equal "WEST"

      south_facing_robot = @robot_mover.left(west_facing_robot)
      south_facing_robot.facing.must_equal "SOUTH"

      east_facing_robot = @robot_mover.left(south_facing_robot)
      east_facing_robot.facing.must_equal "EAST"

      @robot_mover.left(east_facing_robot).facing.must_equal "NORTH"
    end
  end

  describe "#right" do
    it "does not turn if not placed" do
      @robot_mover.right(@unplaced_robot).must_equal @unplaced_robot
    end

    it "turns the robot clockwise" do
      north_facing_robot = @robot_mover.place(x: 0, y: 0, facing: "NORTH")
      east_facing_robot = @robot_mover.right(north_facing_robot)
      east_facing_robot.facing.must_equal "EAST"

      south_facing_robot = @robot_mover.right(east_facing_robot)
      south_facing_robot.facing.must_equal "SOUTH"

      west_facing_robot = @robot_mover.right(south_facing_robot)
      west_facing_robot.facing.must_equal "WEST"

      @robot_mover.right(west_facing_robot).facing.must_equal "NORTH"
    end
  end

  describe "#move" do
    it "does not move anywhere if not placed" do
      @robot_mover.move(@unplaced_robot).must_equal @unplaced_robot
    end

    it "does not fall off the table" do
      placed_robot = @robot_mover.place(x: 0, y: 0, facing: "SOUTH")
      @robot_mover.move(placed_robot).must_equal placed_robot
    end

    it "moves in the direction the robot is facing" do
      north_facing_robot = @robot_mover.place(x: 1, y: 1, facing: "NORTH")
      @robot_mover.move(north_facing_robot).values.must_equal [1, 2, 0]

      east_facing_robot = @robot_mover.place(x: 1, y: 1, facing: "EAST")
      @robot_mover.move(east_facing_robot).values.must_equal [2, 1, 1]

      south_facing_robot = @robot_mover.place(x: 1, y: 1, facing: "SOUTH")
      @robot_mover.move(south_facing_robot).values.must_equal [1, 0, 2]

      west_facing_robot = @robot_mover.place(x: 1, y: 1, facing: "WEST")
      @robot_mover.move(west_facing_robot).values.must_equal [0, 1, 3]
    end
  end
end
