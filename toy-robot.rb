#TOY ROBOT

=begin
The application is a simulation of a toy robot moving on a square tabletop,of dimensions 5 units x 5 units.  There are no other obstructions on the table surface.  The robot is free to roam around the surface of the table, but must be prevented from falling to destruction.  Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

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


#ROBOT CLASS: keeps track of whether robot is on the board & stores position & orientation of the robot

class Robot
        attr_accessor :facing, :onBoard
        attr_reader :xPosition, :yPosition

       	def initialize()
                @directions = {"NORTH" => 0, "EAST" => 1, "SOUTH" => 2, "WEST" => 3}
		@game = Game.new	
        end

	#Set xPosition: setter guards against any move that would take the robot off the board
 	def xPosition=(x)
                if x < 0 || x > 4 
                	puts @game.errortext["out_of_bounds"] 
                else
                        @xPosition = x
                end
        end


	#Set yPosition: setter guards against any move that would take the robot off the board
        def yPosition=(y)
                if y < 0 || y > 4 
                	puts @game.errortext["out_of_bounds"] 
                else
                        @yPosition = y
                end
       end

	#Place method: Puts the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. 
        def place(x,y,f)
                self.xPosition = x
                self.yPosition = y
                puts f
		@facing = f
        end

	#Move Method: moves the toy robot one unit forward in the direction it is currently facing.
	def move
              	case @facing
                when "NORTH"
                        self.yPosition += 1
                when "EAST"
                        self.xPosition += 1
                when "SOUTH"
                        self.yPosition -= 1
                when "WEST"
                        self.xPosition -= 1
                end
	end

	#Left Method:  rotates the robot 90 degrees to the left without changing the position of the robot.
	def left
                dir_code = @directions[@facing]
                new_dir_code = (dir_code - 1) % 4
                @facing = @directions.key(new_dir_code)	
	end

	#Right Method:  rotates the robot 90 degrees to the right without changing the position of the robot.
	def right
                dir_code = @directions[@facing]
                new_dir_code = (dir_code + 1) % 4
                @facing = @directions.key(new_dir_code)
	end

	#Report Method announces the X,Y and F of the robot.
	def report
		puts "#{@xPosition},#{@yPosition},#{@facing}"
	end

end


#GAME CLASS: stores basic constants & error messages associated with game 
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
                        "invalid_command" => "Command not recognised.  Permissable commands are #{commands.inspect}",
                        "out_of_bounds" => "Sorry, that command would put the robot off the table. Command Ignored."
			}
        end
end


#Run main function
main


