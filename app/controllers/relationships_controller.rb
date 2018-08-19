class RelationshipsController < ApplicationController

	def create 
		pry
		@user = User.find(params[:id])
		
		if current_user.following? @user
			redirect_to user_path(@user), alert: 'Usuário já está sendo seguido'
		else
			current_user.follow! @user
			redirct_to user_path(@user), notice: 'Usuário sendo seguido com sucesso'
		end
		
	end

	def destroy
		@user = User.find(params[:id])
		
			current_user.unfollow! @user
			redirect_to user_path(@user), notice: 'Usuário deixou de serguido'
			

	end
		
end		
