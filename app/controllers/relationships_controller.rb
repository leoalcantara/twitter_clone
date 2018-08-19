class RelationshipsController < ApplicationController

	def create 
		current_user.follow!(User.find(params["id"]))
		
	end

	def destroy
		if current_user.following?(User.find(params['id']))
			current_user.unfollow!(User.find(params['id']))
			
	end
		
end
