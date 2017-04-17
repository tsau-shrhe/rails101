class Group < ApplicationRecord
	validates :title, :presence => { :message => "不可為空白"}
end
