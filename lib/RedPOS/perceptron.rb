module RedPOS
  class Perceptron
    attr_accessor :weigths
    
    def initialize(classes)
      @classes = classes
      @weigths = {}
    end
    
    def predict(features)
      class_values = dot_product(@weigths, features)  
      
      class_values.max_by { |c, value| value }[0]
    end
    
    private 
    
    def dot_product(weigths, features)
      product = Hash.new(0)
      features.each do |feature, value|
        next if value == 0 or not weigths[feature]
        
        weigths[feature].each do |clas, weigth|
          product[clas] += weigth * value
        end
      end
      return product
    end
  end
end