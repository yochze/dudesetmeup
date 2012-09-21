class Match < ActiveRecord::Base

  belongs_to :user
  
  attr_accessible :female, :male, :user_id, :result
  
  serialize :female
  serialize :male

end
