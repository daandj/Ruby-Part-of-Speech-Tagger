module RedPOS
  class Perceptron
    attr_accessor :weigths, :classes
    
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
			product = Hash[@classes.map { |clas| [clas, 0] }]
      features.each do |feature, value|
				next if value == 0 or not weigths.include?(feature)
        
        weigths[feature].each do |clas, weigth|
          product[clas] += weigth
        end
      end
      return product
    end
  end
end
