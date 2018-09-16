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
