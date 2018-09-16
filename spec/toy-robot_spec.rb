#Unit Testing of toy-robot program using rspec.  

require 'robot'
require 'game'

describe 'Toy-robot' do
	it "takes valid place command and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 1,1,NORTH", "REPORT", "QUIT")
		expect { game.run }.to output("1,1,NORTH\n").to_stdout		
	end
	
	it "takes invalid place command and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 10,10,NORTH", "QUIT")
		expect { game.run }.to output("Please place robot with both x and y coordinates in range 0 to 4\n").to_stdout		
	end

	it "takes valid place command and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 1,1,NORTH", "PLACE 2,2,EAST", "REPORT", "QUIT")
		expect { game.run }.to output("2,2,EAST\n").to_stdout		
	end
	
	it "moves once and report position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "MOVE", "REPORT", "QUIT")
		expect { game.run }.to output("0,1,NORTH\n").to_stdout		
	end
	
	it "moves to edge of board and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "MOVE", "MOVE",  "MOVE", "MOVE", "REPORT", "QUIT")
		expect { game.run }.to output("0,4,NORTH\n").to_stdout		
	end
	
	it "moves out of bounds" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE", "REPORT", "QUIT")
		expect { game.run }.to output("Sorry, that command would put the robot off the table. Command Ignored.\n0,4,NORTH\n").to_stdout 
	end

	it "moves right and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "RIGHT", "REPORT", "QUIT")
		expect { game.run }.to output("0,0,EAST\n").to_stdout		
	end

	it "moves right four times and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "RIGHT","RIGHT","RIGHT","RIGHT","REPORT", "QUIT")
		expect { game.run }.to output("0,0,NORTH\n").to_stdout		
	end

	it "moves left and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "LEFT", "REPORT", "QUIT")
		expect { game.run }.to output("0,0,WEST\n").to_stdout		
	end
	
	it "moves left four times and reports position" do
		game = Game.new
		allow(game).to receive(:gets).and_return("PLACE 0,0,NORTH", "LEFT","LEFT","LEFT","LEFT","REPORT", "QUIT")
		expect { game.run }.to output("0,0,NORTH\n").to_stdout		
	end

end
