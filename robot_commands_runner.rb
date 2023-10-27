#!/usr/bin/env ruby

require './robot_mover'

class RobotCommandsRunner

  def initialize(commands)
    @commands = Array(commands)
    @robot_mover = RobotMover.new
  end

  def call
    position = robot_mover.unplaced_new_robot

    commands.each do |command|
      command_name = command.split(' ').first
      position = case command_name
                 when 'LEFT'
                   robot_mover.left(position)
                 when 'RIGHT'
                   robot_mover.right(position)
                 when 'MOVE'
                   robot_mover.move(position)
                 when 'REPORT'
                   robot_mover.report(position)
                 when 'PLACE'
                   values = command.delete('PLACE').split(',').map(&:strip)
                   robot_mover.place(position,
                                     x: values[0].to_i,
                                     y: values[1].to_i,
                                     facing: values[2])

                 else
                   position
                 end
    end
  end

  private

  attr_reader :robot_mover, :commands
end

RobotCommandsRunner.new(Array(ARGV)).call
