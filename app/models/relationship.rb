class Relationship < ApplicationRecord
	belongs_to :folower, class_name => 'User'
	belongs_to :folowed, class_name => 'User'
end
