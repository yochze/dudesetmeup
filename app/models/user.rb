class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  # Omniauth	
  attr_accessible :provider, :uid, :name, :oauth_token, :oauth_expires_at

  has_many :matches

def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end


def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(  name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         oauth_token:auth.credentials.token,
                         oauth_expires_at:Time.at(auth.credentials.expires_at),
                         password:Devise.friendly_token[0,20]
                         )
  end
  user
end


  def conditions(male, female)
    girl = female
    boy = male

    if !boy["birthday_date"].nil? && girl["birthday_date"].nil?
      boy_age = Time.now.year - boy["birthday_date"][boy["birthday_date"].size, boy["birthday_date"]  -4].to_i
      girl_age = Time.now.year - girl["birthday_date"][girl["birthday_date"].size, girl["birthday_date"]-4].to_i
    end

    if !boy_age.nil? && !girl_age.nil?
      if ((boy_age/2)+7) < girl_age
        false
      end

     elsif boy["last_name"] == girl["last_name"] # DEAL BREAKER!
       false

    elsif (boy["relationship_status"] == "In a relationship" || boy["relationship_status"]  == "Married" || boy["relationship_status"] == "Engaged") || (girl["relationship_status"] == "In a relationship" || girl["relationship_status"] == "Engaged" || girl["relationship_status"] == "Married")
      false # We are not family wreckers

    else
      true
    end
  end

  def raw(male, female)
    if !conditions(male, female)
      raw(self.male_list.sample, self.female_list.sample)
    else        
      perfect_match = []
      perfect_match << female
      perfect_match << male
    end
  end
    

  def facebook 
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def female_list
    female_list = []
    female_list = facebook.fql_query("select name, uid, last_name, relationship_status, birthday_date, pic_big from user where sex='female' AND (relationship_status<>'In a relationship' OR 'Married') AND uid in (select uid2 from friend where uid1=me())").to_a
  end

  def male_list
    male_list = []
    male_list = facebook.fql_query("select name, uid, last_name, relationship_status, birthday_date, pic_big from user where sex='male' AND (relationship_status<>'In a relationship' OR 'Married') AND uid in (select uid2 from friend where uid1=me())").to_a
  end


end