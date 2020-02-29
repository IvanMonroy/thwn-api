module Api
  class WorksController < ApplicationController
    include RenderHelper
    before_action :set_work, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json
    def all
    end
    def default_serializer_options
      { root: false }
    end

    # GET /work
    # GET /work.json
    def index
      @works = Work.all #.is_in_parking se quita para proeubas en angular
      render_default_format(@works,true,200)
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
      render_default_format(@work,true,200)
    rescue Exception => e
      puts e.inspect
    end

    # GET /work/new
    def new
      @work = Work.new
    end

    # GET /work/1/edit
    def edit
    end

    # POST /work
    # POST /work.json
    def create
      @work = Work.new(work_params)
      if @work.plate_has_an_entry?
        render_default_error 'hay un error, Esta placa ya ha sido ingresada', 401
      else
        @work.date_arrival = Date.today.to_date
        @work.is_parking= true
        if @work.save
          render_success_format('Nueva entrada registrada',@work,true)
        end
      end
    rescue Exception => e
      render_default_error e, 401
    end

    # PATCH/PUT /work/1
    # PATCH/PUT /work/1.json
    def update
      @work.update_attributes!(work_params)
      render_success_format('Entrada actualizada',@work,true)
    rescue Exception => e
      render_default_error e, 401

    end

    # DELETE /work/1
    # DELETE /work/1.json
    def destroy
      @work.destroy
      render_success_format('Entrada eliminada',@work,true)
    rescue Exception => e
      render_default_error e, 401
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find_by(id:params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.permit(:title, :category ,:description ,:first_image ,:first_header ,:first_description,:second_image, :second_header ,:second_description,:third_image, :third_header ,:third_description,:fourth_image, :fourth_header ,:fourth_description,:fifth_image, :fifth_header ,:fifth_description,:sixth_image, :sixth_header ,:sixth_description)
    end
  end
end