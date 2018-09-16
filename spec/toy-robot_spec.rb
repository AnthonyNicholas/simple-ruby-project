#require 'init'
require 'robot'
require 'game'

describe 'Toy-robot' do
=begin
	it "returns the position and orientation of the robot" do
		robot = Robot.new
		expect(... ).to eq("1,1,NORTH")

		allow(STDIN).to receive(:gets) { 'joe' }
=end
	it "takes user's name and returns it" do
		puts "Hello world"
=begin
	utput = capture_standard_output { init }
  		expect(output).to eq ""
  		allow(STDIN).to receive(:gets) { 'joe' }
  		expect(game.ask_for_name).to eq 'Joe'
=end
	end
end
