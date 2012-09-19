class MatchesController < ApplicationController

	def index
		if user_signed_in?		
			perfect_match = current_user.raw(current_user.male_list.sample, current_user.female_list.sample)
			flash[:female] = perfect_match[0]
				@female = flash[:female]
			@male = perfect_match[1]
				flash[:male] = perfect_match[1]
			@match = Match.new
			# @match.female = @female
			# @match.male = @male
		end
	end

	# def new
	# 	create
	# end


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

		redirect_to '/'
	end

end
