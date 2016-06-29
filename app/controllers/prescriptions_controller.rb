require 'pry'

class PrescriptionsController < ApplicationController

  get '/prescriptions' do 
    
    if logged_in?
      @user = User.find(session[:user_id])
      @prescriptions = @user.prescriptions
       erb :'prescriptions/index'
     else
       redirect '/login'
     end
  end

  post '/prescriptions/:id' do

  	error
    @prescription = Prescription.find(params[:id])
    counter = 1
    while (params["name_#{counter.to_s}"])
      name = params["name_#{counter.to_s}"]
      brand = params["brand_#{counter.to_s}"]
      exp_date = params["exp_date_#{counter.to_s}"]
      # error checking
      if name == "" || exp_date == "" || brand == ""
        redirect "/pills/new/#{@prescription.id}?error=Field(s) cannot be left blan
        k"
      elsif Pill.find_by(name: name) != nil
        redirect "/pills/new/#{@prescription.id}?error=Pill #{name} already exists!"
      end
       
      # while the parameter exists, create the new pill with parameters and increment counter
      if Pill.find_by(name: name)
        redirect "/pills/new/#{@prescription.id}?error=#{name} already exists"
      else
      @pill = Pill.create(name: params["name_#{counter.to_s}"], 
        brand: params["brand_#{counter.to_s}"],
        exp_date: params["exp_date_#{counter.to_s}"])
      @prescription.pill_ids = (@prescription.pill_ids << @pill.id)
      @prescription.save
      end
      counter += 1
    end
    redirect "/prescriptions/#{@prescription.id}"
  end
    
  post '/prescriptions' do
    if logged_in?
      if Prescription.find_by(name: params[:name])
        redirect '/prescriptions/new?error=Prescription name already exists'
      else
        # create the prescription and link to checked pills
        @prescription = Prescription.create(name: params[:name], user_id: session[:user_id], active: false)
        if params["prescription"]
          @prescription.pill_ids = params["prescription"]["pill_ids"]
        end
        @prescription.save
        # add number of pills and redirect to new pill form
        if params["pill_count"] != ""
          session[:count] = params["pill_count"]
          redirect "/pills/new/#{@prescription.id.to_s}"
        else
        redirect "/prescriptions/#{@prescription.id.to_s}"
        end
      end
    end
  end

  patch '/prescriptions/:id' do
    if logged_in?
      # find prescription and link to checked pills
      @prescription = Prescription.find(params[:id])
      @prescription.name = params["name"]


      # if there were checked boxes..
      if params["prescription"]
        @prescription.pill_ids.each do |id|
          params["prescription"]["pill_ids"] << id
        end
        @prescription.pill_ids = params["prescription"]["pill_ids"]
      end
      if params["active"]
        @prescription.become_active
      end
      @prescription.save
      # add number of pills and redirect to new pill form
      if params["pill_count"] != ""
        
        session[:count] = params["pill_count"]
        redirect "/pills/new/#{@prescription.id.to_s}"
      else
        redirect "/prescriptions/#{@prescription.id.to_s}"
      end
    end
  end

  get '/prescriptions/new' do
    if logged_in?
      @error_msg = params[:error]
      erb :'prescriptions/new'
    else
      redirect "/login"
    end
  end

  get '/prescriptions/:id' do
    if logged_in?
      @prescription = Prescription.find(params[:id])
      erb :'prescriptions/show'
    else
      redirect "/login"
    end
  end

  get '/prescriptions/:id/edit' do
    if logged_in?
      @prescription = Prescription.find(params[:id])
      erb :'prescriptions/edit'
    else
      redirect "/login"
    end
  end

  get '/prescriptions/:id/delete' do
    if logged_in?
      Prescription.find(params[:id]).destroy
      redirect "/prescriptions"
    else
      redirect "/login"
    end
  end
end

