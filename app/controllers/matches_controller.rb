class MatchesController < ApplicationController
	before_filter :authenticate, :except => [:show, :about, :index]
	def index
		if user_signed_in?		
			perfect_match = current_user.raw(current_user.male_list.sample, current_user.female_list.sample)
			flash[:female] = perfect_match[0]
			@female = flash[:female]
			@male = perfect_match[1]
			flash[:male] = perfect_match[1]
			@match = Match.new
		end
	end


	def create
		@match = Match.new
		@match.female = flash[:female]
		@match.male = flash[:male]

		if params[:yes]
			@match.result = true
		else
			@match.result = false
		end
		@match.user = current_user
		@match.save!
		if current_user && params[:yes]
      		User.delay.add_action(current_user.id, match_url(@match))
      		current_user.facebook.put_wall_post("I just set up " + @match.female["name"] + " & " + @match.male["name"] + " on \"dude set me up\"", {:name => @match.female["name"] + " & " + @match.male["name"], :link => match_url(@match) })
      		#current_user.facebook.put_object("yochay", "dudesetmeup")
        end
		redirect_to '/'
	end

	def show
		@match = Match.find(params[:id])
		redirect_to '/' if @match.result == false
	end

	def about
		@match = Match.last		
	end

	def authenticate
		if !user_signed_in?
			redirect_to matches_path
		end
	end
end
