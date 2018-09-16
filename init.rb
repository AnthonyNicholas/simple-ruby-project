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

require_relative('lib/robot')
require_relative('lib/game')


#MAIN method
def main

        #Instantiate robot and game     
        game = Game.new
        robot = Robot.new

        #Initial placement of robot on the board
        loop do
                inputString = gets.chomp
 		if is_valid_placement(inputString, game)
                        inputArray = get_input_array(inputString)
			robot.place(inputArray[1].to_i, inputArray[2].to_i, inputArray[3])
                        robot.report
                        break
                end
       	end

        #Allow the robot to move in response to stdin commands
        loop do
                inputString = gets.chomp
		if is_valid_input(inputString, game)
                        inputArray = get_input_array(inputString)
			
			command = inputArray[0]
			
			case command
			when "MOVE"
				robot.move
			when "LEFT"
				robot.left
			when "RIGHT"
				robot.right
			when "REPORT"
				robot.report
			when "PLACE"
				robot.place(inputArray[1].to_i, inputArray[2].to_i, inputArray[3])
			end
                end
        end
end



# is_valid_input method
def is_valid_input(inputString, game)
	inputArray = get_input_array(inputString)
        len = inputArray.length
        if !(len == 1 or len == 4)
		puts game.errortext["invalid_command"]
                return false
        elsif len == 1 and game.commands[1..4].include?(inputArray[0])
                return true
        elsif len == 4 and game.commands[0] == inputArray[0]
		return is_valid_placement(inputString, game)
        else
                puts game.errortext["invalid_command"]
                return false
        end
end

#get_input_array method
def get_input_array(inputString)
        if inputString.split(" ").length == 1
                return [inputString]
        elsif inputString.split(" ").length == 2
                return [inputString.split(" ")[0]] + inputString.split(" ")[1].split(",")
        else
                return nil
        end
end

# is_valid_placement method
def is_valid_placement(input, game)
        if input.split(" ").length != 2
                puts game.errortext["placement"] 
                return false
        end 
        inputArray = [input.split(" ")[0]] + input.split(" ")[1].split(",")
        if (inputArray[0] != "PLACE" || inputArray.length != 4) 
                puts game.errortext["placement"] 
                return false
        elsif !game.positions.include?(inputArray[1]) || !game.positions.include?(inputArray[2])  
                puts game.errortext["placement_position"] 
                return false
        elsif !game.directions.include?(inputArray[3])
                puts game.errortext["placement_direction"] 
                return false
        else
                return true
        end
end

#Run main function
main


