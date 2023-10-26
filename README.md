# Description
- The applica+on is a simula+on of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units
- There are no other obstruc+ons on the table surface
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruc+on. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must s+ll be allowed
- You need to provide test data/results for the app & its logic

# Objectives
- Create an applica+on that can read in commands of the following form:
  - PLACE X,Y,F
  - MOVE
  - LEFT
  - RIGHT
  - REPORT
- PLACE will put the toy robot on the table in posi+on X,Y and facing NORTH, SOUTH, EAST or WEST
- The origin (0,0) can be considered to be the SOUTH WEST most corner
- The first valid command to the robot is a PLACE command, aYer that, any sequence of commands may be issued, in any order, including another PLACE command
- The applica+on should discard all commands in the sequence un+l a valid PLACE command has been executed
- MOVE will move the toy robot one unit forward in the direc+on it is currently facing
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direc+on without changing the posi+on of the robot
- REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient
- Input can be from a file, or from standard input, as the developer chooses
- Provide test data to exercise the applica+on
