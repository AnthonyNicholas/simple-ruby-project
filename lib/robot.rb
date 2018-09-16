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
