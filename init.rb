#TOY ROBOT

=begin
The application is a simulation of a toy robot moving on a square tabletop,of dimensions 5 units x 5 units.  There are no other obstructions on the table surface.  The robot is free to roam around the surface of the table, but must be prevented from falling to destruction.  Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

Constraints
-----------

- The toy robot must not fall off the table during movement. This also
  includes the initial placement of the toy robot.
- Any move that would cause the robot to fall must be ignored.
=end

#!/usr/bin/env ruby

require_relative('lib/game')

game = Game.new

puts "\nWelcome to the toy robot application.  First place the robot on the table (with a command in the form \"PLACE X,Y,Facing\" eg \"PLACE 2,2,NORTH\").  Then move the robot with the commands MOVE, RIGHT, LEFT or PLACE.  Retrieve the robots current location with the REPORT command."
puts "\nEnter your command: "  

game.run


