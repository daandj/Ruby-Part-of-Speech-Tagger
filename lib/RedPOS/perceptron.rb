module RedPOS
  class Perceptron
    attr_accessor :weigths, :classes, :totals
    
    def initialize(classes)
      @classes = classes
			@weigths = {}
			@totals = {}
			@timestamps = {}
			@i = 0
    end
    
    def predict(features)
      class_values = dot_product(@weigths, features)  
      
      class_values.max_by { |c, value| value }[0]
    end
    
		def update(prediction, features, true_tag)
			if prediction != true_tag
			  features.each do |feature, value|
					update_feat(feature, prediction, -1)
					update_feat(feature, true_tag, 1)
				end
			end
			@i += 1
		end

		def average
			@weigths.each do |feat, weigths| 
				@totals[feat] ||= {}; @timestamps[feat] ||= {}
				new_weigths = {}
				weigths.each do |clas, weigth|
					@totals[feat][clas] ||= 0; @timestamps[feat][clas] ||= 0
					@totals[feat][clas] += weigth * (@i-@timestamps[feat][clas])
					averaged = @totals[feat][clas].to_f / @i
					new_weigths[clas] = averaged
					@timestamps[feat][clas] = @i
				end
				@weigths[feat] = new_weigths
			end
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

		def update_feat(feat, clas, value)
			if not @weigths.include?(feat)
				@weigths[feat] = @classes.map { |clas| [clas, 0] }.to_h
			end

			@totals[feat] ||= {}; @totals[feat][clas] ||= 0
			@timestamps[feat] ||= {}; @timestamps[feat][clas] ||= 0
			@totals[feat][clas] += @weigths[feat][clas] * (@i-@timestamps[feat][clas])
			@timestamps[feat][clas] = @i

			@weigths[feat][clas] += value
		end

	end
end
