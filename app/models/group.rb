class Group < ApplicationRecord
	belongs_to :user
	validates :title, :presence => { :message => "標題欄位不可為空白"}
end
