class Event < ActiveRecord::Base
	
	#關聯資料設計練習-1對多關聯
	has_many :attendees , ->{ where(["created_at > ?", Time.now - 7.day]).order("id DESC") } , dependent: :destroy #複數,串連where條件+指定順序為降序

	#關聯資料設計練習-1對1關聯
	has_one :location ,dependent: :destroy #單數,設定當物件刪除時也一起刪除依賴它的資料

	#關聯資料設計練習-多對多關聯
	has_many :event_groupships #複數
	has_many :groups, through: :event_groupships

	belongs_to :category

	#加入以下程式，就會有 @event.category_name 可以使用 而且允許 @event.category 是 nil
	#防止nil.name錯誤
	delegate :name,to: :category,prefix: true,allow_nil: true
	
	#accepts_nested_attributes_for這個方法可以讓更新event資料時 也可以直接更新location的關聯資料	
	#也就是說 可以完全不需要修改events_controller的新增和編輯Action
	#可以透過本來的params[:event]參數來新增或修改location
	accepts_nested_attributes_for :location,allow_destroy: true , reject_if: :all_blank

	validates_presence_of :name #宣告name屬性為必填(不可空白)
end
