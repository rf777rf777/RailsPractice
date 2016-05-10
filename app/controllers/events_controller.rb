class EventsController < ApplicationController

	before_action :set_event, only:[:show,:edit,:update,:destroy] 

	def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		#@event = Event.new(params[:event])
		@event = Event.new(event_params)
		if @event.save
			redirect_to action: :index
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
		@page_title = @event.name
	end

	def edit
		#@event = Event.find(params[:id])
	end

	def update
		#@event = Event.find(params[:id])
		if @event.update(event_params)
			redirect_to action: :show, id: @event
			flash[:notice] = "event was successfully updated"
		else
			render action: :edit
		end
	end

	def destroy
		#@event = Event.find(params[:id])
		@event.destroy

		redirect_to action: :index
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