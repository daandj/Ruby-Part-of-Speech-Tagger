module RedPOS
  class Tagger
    
    def initialize()
      @classes = nil # TODO: retrieve the correct classes somehow.
      @model = Perceptron.new(@classes)
    end
    
    def tag(sentences)
      
    end
    
    def pre_process()
      
    end
    
    def train(iterations, sentences, tags)
      iterations.each do |iter|
        sentences.each_with_index do |sent, sent_index|
          sent.each_with_index do |word, word_index|
            features = get_features()
            
            prediction = @model.predict(features)
            true_tag = tags[sent_index][word_index]
            
            if prediction != true_tag
              update(prediction, true_tag)
            end
        end
      end
    end
    
    def get_features()
      
    end
    
    private
    
    def update(prediction, true_tag)
      @model.weigths.each do |feature, classes|
        if features.include?(feature)  
          @model.weigths[feature][prediction] -= 1
          @model.weigths[feature][true_tag] += 1
        end
      end
    end
    
  end
end