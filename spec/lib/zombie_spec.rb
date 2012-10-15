require 'spec_helper'
require 'zombie'

describe Zombie do 
	it  "is named Ash" do
		zombie = Zombie.new
		zombie.name.should == 'Ash'
	end

	it "has no brains" do
		zombie = Zombie.new
		zombie.brains.should < 1
	end

	it 'is hungry' do
		zombie = Zombie.new
		zombie.hungry?.should == true  # not that great
		zombie.hungry?.should be_true
		zombie.should be_hungry	# predicate matcher
	end	

	it "is named Ash"				# pending

	xit "is named bob" do	# pending
		zombie = Zombie.new
	end

	it "is named Jon" do	# pending
				zombie = Zombie.new
				zombie.name.should == "Jon"
	end

	it "should respond to hungry" do
		zombie = Zombie.new
		zombie.should respond_to (:hungry?)
	end

	it "should be a type of mutant" do
		zombie = Zombie.new
		zombie.should be_kind_of (Mutant)
	end

end
	