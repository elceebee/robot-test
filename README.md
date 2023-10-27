# Moving the robot
- Ensure you have ruby installed on your machine.
- run $ ruby ./robot_commands_runner.rb ARGS where ARGS is a list of the following:
  - "PLACE X,Y,F" (X and Y are between 0 and 4, F is one of NORTH, EAST, SOUTH, WEST)
  - MOVE
  - LEFT
  - RIGHT
  - REPORT
- Example: `ruby ./robot_commands_runner.rb "PLACE 0,0,NORTH" MOVE LEFT REPORT`
  will output

```
0,1,WEST
■ ■ ■ ■ ■
■ ■ ■ ■ ■
■ ■ ■ ■ ■
R ■ ■ ■ ■
■ ■ ■ ■ ■ 
```
