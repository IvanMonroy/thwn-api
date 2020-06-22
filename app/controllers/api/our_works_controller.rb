module Api
  class OurWorksController < ApplicationController
    include RenderHelper
    before_action :set_work, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json

    def all
    end

    def default_serializer_options
      {root: false}
    end

    # GET /our_works
    # GET /our_works.json
    def index
      @our_works = OurWork.all #.is_in_parking se quita para proeubas en angular
      render_default_format(@our_works, true, 200)
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
      render_default_format(@our_works, true, 200)
    rescue Exception => e
      puts e.inspect
    end

    # GET /our_works/new
    def new
      @our_works = OurWork.new
    end

    # GET /our_works/1/edit
    def edit
    end

    # POST /our_works
    # POST /our_works.json
    def create
      @our_works = OurWork.new(our_work_params)
      if @our_works.plate_has_an_entry?
        render_default_error 'hay un error, Esta placa ya ha sido ingresada', 401
      else
        @our_works.date_arrival = Date.today.to_date
        @our_works.is_parking = true
        if @our_works.save
          render_success_format('Nueva entrada registrada', @our_works, true)
        end
      end
    rescue Exception => e
      render_default_error e, 401
    end

    # PATCH/PUT /our_works/1
    # PATCH/PUT /our_works/1.json
    def update
      @our_works.update_attributes!(our_works_params)
      render_success_format('Entrada actualizada', @our_works, true)
    rescue Exception => e
      render_default_error e, 401

    end

    # DELETE /our_works/1
    # DELETE /our_works/1.json
    def destroy
      @our_works.destroy
      render_success_format('Entrada eliminada', @our_works, true)
    rescue Exception => e
      render_default_error e, 401
    end

    def index_for_menu
      @our_works = OurWork.all.select(:id,:category, :name, :situation, :solution, :image_one, :image_two)
      render_success_format('Datos', @our_works, true)
    rescue Exception => e
      render_default_error e, 401
    end



    def info_our_works
      @our_works = OurWork.find_by_id params[:id]
      @index_news = OurWork.select(:id,:category, :name, :situation, :solution).all.limit(4).order('id desc')
      render_default_format_2(@our_works,@index_news,true,200 )
    end






    private

    # Use callbacks to share common setup or constraints between actions.
    def set_our_work
      @work = OutWork.find_by(id: params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def our_work_params
      params.permit(:category, :name, :situation, :solution, :image_one, :image_two, :image_three, :image_fourth, :image_fifth)
    end
  end
end
