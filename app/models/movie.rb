class Movie < ActiveRecord::Base
    
 def self.give_ratings
   Movie.uniq.pluck(:rating).sort
 end
    
end
