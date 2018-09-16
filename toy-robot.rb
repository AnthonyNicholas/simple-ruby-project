#TOY ROBOT

=begin
The application is a simulation of a toy robot moving on a square tabletop,of dimensions 5 units x 5 units.  There are no other obstructions on the table surface.  The robot is free to roam around the surface of the table, but must be prevented from falling to destruction.  Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

Create an application that can read in commands of the following form:

 Input can be from a file, or from standard input, as the developer chooses.
- Provide test data to exercise the application.

Constraints
-----------

- The toy robot must not fall off the table during movement. This also
  includes the initial placement of the toy robot.
- Any move that would cause the robot to fall must be ignored.
=end


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
                        robot.xPosition = inputArray[1].to_i
                        robot.yPosition = inputArray[2].to_i
                        robot.facing = inputArray[3]
                        robot.report
                        break
                end
       	end

        #Allow the robot to move in response to stdin commands
        loop do
                #read input
                inputString = gets.chomp
		#TODO
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


#ROBOT CLASS: keeps track of whether robot is on the board & stores position & orientation of the robot

class Robot
        attr_accessor :facing, :onBoard
        attr_reader :xPosition, :yPosition

	#Set xPosition: setter guards against any move that would take the robot off the board
 	def xPosition=(x)
                if x > 4
                        @xPosition = 4
                elsif x < 0
                        @xPosition = 0
                else
                        @xPosition = x
                end
        end


	#Set yPosition: setter guards against any move that would take the robot off the board
        def yPosition=(y)
                if y > 4
                        @yPosition = 4
                elsif y < 0
                        @yPosition = 0
                else
                        @yPosition = y
                end
        end



# METHOD: Place  will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. The origin (0,0) can be considered to be the SOUTH WEST most corner.  The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
	def place
		#TODO
	end

#METHOD: MOVE will move the toy robot one unit forward in the direction it is currently facing. LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot. REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORT commands.
	def move
		#TODO
	end

#METHOD: LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
	def left
		#TODO
	end

	def right
		#TODO
	end

#METHOD: REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.
	def report
		puts "Robot is placed on board at position x:#{@xPosition}, y:#{@yPosition} and facing #{@facing}"
	end

end


#Game Class:
class Game
        attr_reader :positions, :directions, :commands, :permitted_command_lengths, :errortext

        def initialize()
                @positions = ["0","1","2","3","4"]
                @directions = ["NORTH", "EAST", "SOUTH", "WEST"]
                @commands = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
                @permitted_command_lengths = [1,2]
                @errortext = {
                        "placement" => "Please place robot with command in form \"PLACE x,y,facing\" eg PLACE 1,2,NORTH",
                        "placement_position" => "Please place robot with both x and y coordinates in range 0 to 4",
                        "placement_direction" => "Please place robot facing in one of NORTH, EAST, SOUTH or WEST directions",
                        "invalid_command" => "Command not recognised.  Permissable commands are #{commands.inspect}"
                        }
        end
end


#Run main function
main


