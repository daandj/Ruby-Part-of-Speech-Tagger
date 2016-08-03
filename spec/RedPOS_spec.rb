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

describe RedPOS::Tagger do
  classes = [:c1, :c2, :c3]
  tagger = RedPOS::Tagger.new
  tagger.model.classes = classes
  
  describe "#train" do
    weigths = {
      "f1" => { c1: 5, c2: 2, c3: 9 },
      "f2" => { c1: 1, c2: 2, c3: 6 },
      "f3" => { c1: 9, c2: 0, c3: 2 }
    } 
    tagger.model.weigths = Marshal.load(Marshal.dump(weigths)) # deep copy of
                                                               # weigths
    
    let(:features) { { "f1" => 1, "f2" => 0, "f3" => 1 } }
    let(:test_sent) { [["this_wont_get_used"]] }
    
    it "doesn't change weigths if correct" do
      test_tags = [[:c1]]
      allow(tagger).to receive(:get_features).and_return(features)
      tagger.train(1, test_sent, test_tags)
      expect(tagger.model.weigths).to eq weigths
    end
    
    it "changes the right weights if wrong" do
      test_tags = [[:c3]]
      allow(tagger).to receive(:get_features).and_return(features)
      expect {
        tagger.train(1, test_sent, test_tags)
      }.to change{array_of_weigths(tagger.model.weigths, features, [:c3])}
        .from(array_of_weigths(weigths, features, [:c3]))
        .to(array_of_weigths(weigths, features, [:c3]).map { |x| x + 1 })
        .and change{array_of_weigths(tagger.model.weigths, features, [:c1])}
        .from(array_of_weigths(weigths, features, [:c1]))
        .to(array_of_weigths(weigths, features, [:c1]).map { |x| x - 1 })
    end
  end
end

