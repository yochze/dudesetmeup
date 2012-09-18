class Match < ActiveRecord::Base

  belongs_to :user
  
  attr_accessible :female, :male, :user_id
  
  serialize :female
  serialize :male


end
