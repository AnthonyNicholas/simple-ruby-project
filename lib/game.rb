#GAME CLASS: stores basic constants & error messages associated with game 


require_relative('./robot')

class Game
        attr_reader :positions, :directions, :commands, :permitted_command_lengths, :errortext
	attr_accessor :robot


        def initialize()
                @positions = ["0","1","2","3","4"]
                @directions = ["NORTH", "EAST", "SOUTH", "WEST"]
                @commands = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT", "QUIT"]
                @permitted_command_lengths = [1,2]
                @errortext = {
                        "placement" => "Please place robot with command in form \"PLACE x,y,facing\" eg PLACE 1,2,NORTH",
                        "placement_position" => "Please place robot with both x and y coordinates in range 0 to 4",
                        "placement_direction" => "Please place robot facing in one of NORTH, EAST, SOUTH or WEST directions",
                        "invalid_command" => "Command not recognised.  Permissable commands are #{commands.inspect}",
                        "out_of_bounds" => "Sorry, that command would put the robot off the table. Command Ignored."
			}
		@robot = Robot.new
        end


	def run
		
		#Initial placement of robot on the board
		loop do
			inputString = gets.chomp
			if inputString == "QUIT"
				return
			elsif is_valid_placement(inputString)
				inputArray = get_input_array(inputString)
				@robot.place(inputArray[1].to_i, inputArray[2].to_i, inputArray[3])
				break
			end
		end

		#Allow the robot to move in response to stdin commands
		loop do
			inputString = gets.chomp
			if is_valid_input(inputString)
				inputArray = get_input_array(inputString)

				command = inputArray[0]

				case command
				when "MOVE"
					@robot.move
				when "LEFT"
					@robot.left
				when "RIGHT"
					@robot.right
				when "REPORT"
					@robot.report
				when "PLACE"
					@robot.place(inputArray[1].to_i, inputArray[2].to_i, inputArray[3])
				when "QUIT"
					return
				end
			end
		end
	end

	# is_valid_input method
	def is_valid_input(inputString)
		inputArray = get_input_array(inputString)
		len = inputArray.length
		if !(len == 1 or len == 4)
			puts @errortext["invalid_command"]
			return false
		elsif len == 1 and @commands[1..5].include?(inputArray[0])
			return true
		elsif len == 4 and @commands[0] == inputArray[0]
			return is_valid_placement(inputString)
		else
			puts @errortext["invalid_command"]
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
	def is_valid_placement(input)
		if input.split(" ").length != 2
			puts @errortext["placement"]
			return false
		end
		inputArray = [input.split(" ")[0]] + input.split(" ")[1].split(",")
		if (inputArray[0] != "PLACE" || inputArray.length != 4)
			puts @errortext["placement"]
			return false
		elsif !@positions.include?(inputArray[1]) || !@positions.include?(inputArray[2])
			puts @errortext["placement_position"]
			return false
		elsif !@directions.include?(inputArray[3])
			puts @errortext["placement_direction"]
			return false
		else
			return true
		end
	end






end
