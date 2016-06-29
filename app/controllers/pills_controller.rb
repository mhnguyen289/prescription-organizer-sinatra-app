class PillsController < ApplicationController

  get '/pills/new' do
  	
    if logged_in?
    	if session[:count] != nil
    		@count = session[:count].to_i
    	else
    		@count = 1
    	end
      erb :'pills/new'
    else
    	redirect '/login'
    end
  end

  get '/pills/new/:id' do
  	if logged_in?
  		if session[:count] != nil
  			@count = session[:count].to_i
  		else
  			@count = 1
  		end
  		@error_msg = params[:error]
  		@prescription = Prescription.find(params[:id])
  		erb :'pills/new'
  	else
  		redirect '/login'
  	end
  end

  get '/pills/:id/edit' do
  	@pill = Pill.find(params[:id])
  	@error_msg = params[:error]
  	@prescription_id = params[:prescription_id]
  	erb :'pills/edit'
  end

  get "/pills/:id/delete" do
      Pill.find(params[:id]).destroy
      redirect "/prescriptions/#{params[:prescription_id]}/edit"
  end

  get '/pills/:id/unlink' do
    @prescription = Prescription.find(params[:prescription_id])
    temp = @prescription.pill_ids
    temp.delete(params[:id].to_i)
    @prescription.pill_ids = temp
    @prescription.save
    redirect "/prescriptions/#{params[:prescription_id]}/edit"
 end
    

   patch "/pills/:id" do
   		
    if params[:name] == "" || params[:instruction] == "" || params[:exp_date] == ""
      redirect "/pills/#{params[:id]}/edit?error=Field(s) cannot be left blank"
    end
    @pill = Pill.find(params[:id])
    @pill.name = params[:name]
    @pill.instruction = params[:instruction]
    @pill.exp_date = params[:exp_date]
    @pill.save
    redirect "/prescriptions/#{params[:prescription_id]}/edit"
  end

  get '/pills/:id/delete' do
    if logged_in?
      Pill.find(params[:id]).destroy
      redirect "/prescriptions"
    else
      redirect "/login"
    end
  end
end