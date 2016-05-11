class Event < ActiveRecord::Base
	
	#關聯資料設計練習-1對多關聯
	has_many :attendees , dependent: :destroy , ->{ where(["created_at > ?", Time.now - 7.day]).order("id DESC") } #複數,串連where條件+指定順序為降序

	#關聯資料設計練習-1對1關聯
	has_one :location ,dependent: :destroy #單數,設定當物件刪除時也一起刪除依賴它的資料

	#關聯資料設計練習-多對多關聯
	has_many :event_groupships #複數
	has_many :groups, through: :event_groupships

	belongs_to :category
	
	validates_presence_of :name #宣告name屬性為必填(不可空白)
end
