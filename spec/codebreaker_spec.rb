require 'spec_helper'

module Codebreaker
	describe Game do
    let(:game) { Game.new }

	  context "#start" do
      subject { game.instance_variable_get(:@secret_key) }

      it { expect(subject).not_to be_empty }
      it { expect(subject).to have(4).items }
      it { expect(subject).to match(/[1-6]+/) }
	  end

    context "#answer" do
      before { game.instance_variable_set(:@secret_key, "1234") }

      it { expect(game.answer("1111")).to eql("+---") }
      it { expect(game.answer("1211")).to eql("++--") }
      it { expect(game.answer("1231")).to eql("+++-") }
      it { expect(game.answer("1234")).to eql("++++") }

      it { expect(game.answer("5555")).to eql("XXXX") }
      it { expect(game.answer("1555")).to eql("+XXX") }
      it { expect(game.answer("1155")).to eql("+-XX") }
      it { expect(game.answer("1115")).to eql("+--X") }
      it { expect(game.answer("2222")).to eql("-+--") }
      it { expect(game.answer("1555")).to eql("+XXX") }
    end

    context "#valid?" do
      it "should be valid with four digits" do
        test = game.valid?("1122")
        expect(test).to eql(0)
      end
      it "should be valid with 'hint'" do
        test = game.valid?("hint")
        expect(test).to eql(true)
      end
      it "should not be valid with more than four digits" do
        test = game.valid?("11322")
        expect(test).to eql(false)
      end
      it "should not be valid with less than four digits" do
        test = game.valid?("113")
        expect(test).to eql(false)
      end
      it "should be valid with any other" do
        test = game.valid?("any other")
        expect(test).to eql(false)
      end
    end

    context "#hint" do
      subject { game.hint }

      before { game.instance_variable_set(:@secret_key, "1234") }

      it { expect(subject).to match(/^[*]{0,3}[1-6]{1}[*]{0,3}$/) }
      it { expect(subject).to match(/([1***]|[*2**]|[**3*]|[***4])/) }
    end
	end
end