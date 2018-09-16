# toy-robot
Ruby project - a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.  The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

The robot must first be placed and then moved using the following commands:

PLACE X,Y,F; MOVE; LEFT; RIGHT; REPORT

To start the program: *ruby init.rb*

To run the unit tests: *rspec spec/toy-robot_spec.rb*
