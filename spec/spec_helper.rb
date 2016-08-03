require 'RedPOS'

# return the weigths of certain classes in certain features
def array_of_weigths(weigths, features, classes)
  weigths.select do |feat, clas_weigths| 
    features.include?(feat)
  end.values.map do |clas_weigths, weigth|
    clas_weigths.select { |clas, value| classes.include?(clas) }.values
  end.flatten
end