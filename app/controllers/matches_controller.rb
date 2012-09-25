# encoding: utf-8
include ApplicationHelper

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
		
		respond_to do |format|
			if @match.save
				if current_user && params[:yes]
	      			User.delay.add_action(current_user.id, match_url(@match))
		      		# current_user.facebook.put_wall_post("I just set up " + @match.female["name"] + " & " + @match.male["name"] + " on \"dude set me up\"", {:name => @match.female["name"] + " & " + @match.male["name"], :link => match_url(@match) })
		      		# current_user.facebook.put_object("yochay", "dudesetmeup")
  					format.html { redirect_to matches_path, notice: 'השידך בין ' + "<a href=" + match_url(@match) + ">" + @match.female["name"] + ' לבין ' + @match.male["name"] + '</a> בוצע בהצלחה! ' + like_link(match_url(@match)) }
  				else
  					format.html { redirect_to matches_path }
		        end
		  else
		  	  format.html { redirect_to matches_path }
			end

		  end

	end

	def show
		@match = Match.find(params[:id])
		redirect_to '/' if @match.result == false
	end

	def about

	end

	def authenticate
		if !user_signed_in?
			redirect_to matches_path
		end
	end
end
