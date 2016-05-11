class EventsController < ApplicationController

	before_action :set_event, only:[:show,:edit,:update,:destroy] 

	def index
		#一次抓出所有活動太耗效能
		#@events = Event.all

		#使用kaminari套件後改成
		@events = Event.page(params[:page]).per(5)


		#使用respond_to支援不同的資料格式(XML JSON Atom)
		respond_to do |format|
			format.html # index.html.erb
			format.xml { render xml: @events.to_xml }
			format.json { render json: @events.to_json }
			format.atom {@feed_title = "my event list" } #index.atom.builder
		end
	end

	def new
		@event = Event.new
	end

	def create
		#@event = Event.new(params[:event])
		@event = Event.new(event_params)
		if @event.save

			#改成Restful後註解掉改成
			#redirect_to action: :index
			redirect_to events_url

			flash[:notice] = "event was successfully created"
		else
			render action: :new
		end
	end

	def show
		#透過before_action 
		#可以將Controller中重複的程式獨立出來
		#以下此行可註解掉
		#@event = Event.find(params[:id]) 

		#改放在respond_to裡面
		#@page_title = @event.name
		respond_to do |format|
			format.html {@page_title = @event.name } #show.html.erb
			format.xml #show.xml.builder
			format.json { render json: {id: @event.id ,name: @event.name }.to_json}
		end
	end

	def edit
		#@event = Event.find(params[:id])
	end

	def update
		#@event = Event.find(params[:id])
		if @event.update(event_params)
			#改成Restful後註解掉改成
			#redirect_to action: :show, id: @event
			redirect_to event_url(@event)

			flash[:notice] = "event was successfully updated"
		else
			render action: :edit
		end
	end

	def destroy
		#@event = Event.find(params[:id])
		@event.destroy

		#改成Restful後註解掉改成
		#redirect_to action: :index		
		redirect_to events_url

		flash[:alert] = "event was successfully deleted"

	end

	private

	def event_params
		params.require(:event).permit(:name, :description)
	end

	def set_event
		@event = Event.find(params[:id])
	end

end
