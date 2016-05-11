class Attendee < ActiveRecord::Base
	
	#關聯資料設計練習-1對多關聯
	belongs_to :event #單數
end
