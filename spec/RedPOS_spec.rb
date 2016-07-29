require 'spec_helper'

describe RedPOS::Perceptron do
  let(:classes) { [:c1, :c2, :c3] }
  let(:model) { RedPOS::Perceptron.new(classes) } 
  
  describe "#predict" do
    let(:weigths) { {
      "f1" => { c1: 5, c2: 2, c3: 9 },
      "f2" => { c1: 1, c2: 2, c3: 6 },
      "f3" => { c1: 9, c2: 0, c3: 2 }
    } }
    
    let(:features) { { "f1" => 1, "f2" => 0, "f3" => 1 } }
      
    it "returns the correct class" do
      model.weigths = weigths
      expect(model.predict(features)).to eq :c1
    end
    
    it "skips features that aren't in @weigths" do
      model.weigths = weigths
      features["f4"] = 0
      expect(model.predict(features)).to eq :c1
    end
    
    it "skips weigths that aren't in features" do
      weigths["f4"] = { c1: 6, c2: 8, c3: 0 }
      model.weigths = weigths
      expect(model.predict(features)).to eq :c1
    end
    
  end
end