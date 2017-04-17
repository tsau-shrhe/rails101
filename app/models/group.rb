class Group < ApplicationRecord
	validates :title, :presence => { :message => "標題欄位不可為空白"}
end
