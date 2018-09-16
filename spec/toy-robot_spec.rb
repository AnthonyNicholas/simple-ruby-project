require 'robot'
require 'game'

describe 'Toy-robot' do
	it "takes place command and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 1,1,NORTH", "REPORT", "QUIT")
		#puts("game.robot.report = " + game.robot.report)
		expect { game.run }.to output("1,1,NORTH\n").to_stdout		
	end
	
	it "takes invalid place command and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 10,10,NORTH", "QUIT")
		#puts("game.robot.report = " + game.robot.report)
		expect { game.run }.to output("Please place robot with both x and y coordinates in range 0 to 4\n").to_stdout		
	end
	
	it "moves once  and report position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "MOVE", "REPORT", "QUIT")
		#puts("game.robot.report = " + game.robot.report)
		expect { game.run }.to output("0,1,NORTH\n").to_stdout		
	end
	
	it "moves four times and report position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "MOVE", "MOVE",  "MOVE", "MOVE", "REPORT", "QUIT")
		#puts("game.robot.report = " + game.robot.report)
		expect { game.run }.to output("0,4,NORTH\n").to_stdout		
	end
	
	it "moves out of bounds" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE", "REPORT", "QUIT")
		#puts("game.robot.report = " + game.robot.report)
		expect { game.run }.to output("Sorry, that command would put the robot off the table. Command Ignored.\n0,4,NORTH\n").to_stdout 
	end


end
