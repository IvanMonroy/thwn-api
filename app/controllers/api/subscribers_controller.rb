module Api
  class SubscribersController < ApplicationController
    include RenderHelper
    before_action :set_subscriber, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false


    respond_to :json
    def all
    end
    def default_serializer_options
      { root: false }
    end


    # GET /subscriber
    # GET /subscriber.json
    def index
      @subscriber = Subscriber.all #.is_in_parking se quita para proeubas en angular
      render_default_format(@subscriber,true,200)
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
      render_default_format(@subscriber,true,200)
    rescue Exception => e
      puts e.inspect
    end

    # GET /subscriber/new
    def new
      @subscriber = Subscriber.new
    end

    # GET /subscriber/1/edit
    def edit
    end

    # POST /subscriber
    # POST /subscriber.json
    def create
      @subscriber = Subscriber.new(subscriber_params)

        if @subscriber.save
          QuotesMailer.quotes(@subscriber.name, @subscriber.email, @subscriber.subject, @subscriber.phone, @subscriber.mesagge).deliver_now
          # render_success_format('Gracias por preferirnos',@subscriber,true)

        end
    rescue Exception => e
      render_default_error e, 401
    end

    def subscribe
      @subscriber = Subscriber.new(subscriber_params)
      @subscriber.name = @subscriber.email.split("@")[0]
      @subscriber.subject = "Suscribeme"
      @subscriber.phone = "Ninguno"
      @subscriber.mesagge = "Sucribeme"
      #@subscriber.is_subscriber = "true"
      if @subscriber.save
        SubscriptionMailer.subscription(@subscriber.name, @subscriber.email).deliver_now
         # render_success_format('Bienvenido',@subscriber,true)
      end
    rescue Exception => e
      render_default_error e, 401
    end
    # PATCH/PUT /subscriber/1
    # PATCH/PUT /subscriber/1.json
    def update
      @subscriber.update_attributes!(subscriber_params)
      render_success_format('Suscriptor actualizada',@subscriber,true)
    rescue Exception => e
      render_default_error e, 401

    end

    # DELETE /subscriber/1
    # DELETE /subscriber/1.json
    def destroy
      @subscriber.destroy
      render_success_format('subscriber eliminada',@subscriber,true)
    rescue Exception => e
      render_default_error e, 401
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find_by(id:params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.permit(:name, :subject, :email ,:phone ,:mesagge ,:is_subscriber)
    end
  end
end
