require 'spec_helper.rb'

module DkCodebreaker
  shared_context "start game" do
    let(:game) { Game.new }
  end
  describe Game do
    include_context "start game"

    context "#start" do
      it "generates secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end
      it "saves secret code with numbers 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context "#guess" do
      it "answer submited" do
        game.guess "6776"
        expect(game.instance_variable_get(:@submit_code)).to eq("6776")
      end

      it "user can add only string" do
        game.guess 213
        expect(game.instance_variable_get(:@submit_code)).to eq(nil)
      end

      it "if user added less the 4 symbols" do
        expect(game.guess "123").to eq(:less_then_four)        
      end

      it "if user added more then 4 symbols" do
        game.guess "218712131"
        expect(game.instance_variable_get(:@submit_code)).to eq("2187")
      end

      it "user guess 4 numbers and positions" do        
        game.instance_variable_set(:@secret_code,"1432")
        expect(game.guess "1432").to eq("++++")
      end

      it "user guess 4 numbers but no positions" do        
        game.instance_variable_set(:@secret_code,"3121")
        expect(game.guess "1213").to eq("----")
      end

      it "user not guess any numbers" do
        game.instance_variable_set(:@secret_code,"6556")
        expect(game.guess "1421").to be_empty
      end

      it "submit 4561 get ++" do
        game.instance_variable_set(:@secret_code,"4231")
        expect(game.guess "4561").to eq("++")
      end

      it "submit 3124 get +--" do
        game.instance_variable_set(:@secret_code,"1223")
        expect(game.guess "3124").to eq("+--")
      end

      it "submit 5623 get ++--" do
        game.instance_variable_set(:@secret_code,"6523")
        expect(game.guess "5623").to eq("++--")
      end
    end 

    context "#hint" do
      before do
        game.guess "1478"
        game.instance_variable_set(:@secret_code,"1478") 
      end

      it "user request hint" do
        expect(game.hint).to have(4).items 
      end
    end

    context "#user" do
      it "restart game" do
        sc = game.instance_variable_get(:@secret_code)
        game.restart
        expect(game.instance_variable_get(:@submit_code)).to eq(nil)
        expect(game.instance_variable_get(:@secret_code)).not_to eq(sc)
      end
     end
  end
end 