module RedPOS
  class Perceptron
    
    def init(classes)
      @classes = classes
      @weigths = {}
    end
    
    def predict(features)
      class_values = dot_product(@weigths, features)  
    end
    
    private 
    
    def dot_product(weigths, features)
      
    end
  end
end