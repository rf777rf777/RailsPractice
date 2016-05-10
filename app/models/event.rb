class Event < ActiveRecord::Base
	validates_presence_of :name #宣告name屬性為必填(不可空白)
end
