class Post < ApplicationRecord
	belongs_to :user
	belongs_to :group
	validates :content, :presence => { :message => "文章內容不可為空白"}
	scope :recent, -> { order("created_at DESC")}
end
