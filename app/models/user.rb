class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets  
  has_many :active_relationships, class_name: 'Relationship',
 			foreign_key: 'follower_id', dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship',
 			foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed 
  has_many :followers, through: :passive_relationships, source: :follower					
  
  def following?(other_user)
  	#Este método checa se o usuário está seguindo o outro
  	following.include? other_user
  end

  def follow!(other_user)
  	#Este método criará o relacionamento entre um usuário e o outro.
  	active_relationships.create(followed: other_user)
  	#following << other_user
  end


  def unfollow!(other_user)
  	#Este método ira apagar o relacionamento ente um usuário
  	following.destroy(other_user)
  end

  def feed
  		user_ids = following.pluck(:id)
  		user_ids << self.id
  		Tweet.where(user_id: user_ids).order(created_at: :desc)
  end	

end
