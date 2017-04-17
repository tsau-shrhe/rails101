class Group < ApplicationRecord
	belong_to :user
	validates :title, :presence => { :message => "標題欄位不可為空白"}
end
