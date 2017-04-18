class Group < ApplicationRecord
	belongs_to :user
	has_many :posts
	validates :title, :presence => { :message => "標題欄位不可為空白"}

	#設定group與user的關係
	has_many :group_relationships
	has_many :members, through: :group_relationships, source: :user
end
