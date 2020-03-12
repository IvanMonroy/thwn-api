module Api
  class IndexNewsController < ApplicationController
    include RenderHelper
    before_action :set_index_new, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json
    def all
    end
    def default_serializer_options
      { root: false }
    end

    # GET /index_new
    # GET /index_new.json
    def index
      @index_news = IndexNew.all #.is_in_parking se quita para proeubas en angular
      render_default_format(@index_news,true,200)
    end

    def index_principal_pages
      @index_news = IndexNew.all.limit(4).order('id desc') #.is_in_parking se quita para proeubas en angular
      render_default_format(@index_news,true,200)
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
      render_default_format(@index_new,true,200)
    rescue Exception => e
      puts e.inspect
    end

    def info_new
      @index_new = IndexNew.select(:id,:title,:bodyone,:subtitle,:subtitletwo,:bodytwho,:bodythree,:img_url_one,:img_url_two,:img_url_three, :autor, :note_1, :note_2).find_by_id params[:id]
      @index_news = IndexNew.select(:id,:title,:bodyone,:img_url_one, :autor, :note_1, :note_2).all.limit(4).order('id desc')
      render_default_format_2(@index_new,@index_news,true,200 )
    end

    # GET /index_new/new
    def new
      @index_new = IndexNew.new
    end

    # GET /index_new/1/edit
    def edit
    end

    # POST /index_new
    # POST /index_new.json
    def create
      @index_new = IndexNew.new(index_new_params)
      if @index_new.plate_has_an_entry?
        render_default_error 'hay un error, Esta placa ya ha sido ingresada', 401
      else
        @index_new.date_arrival = Date.today.to_date
        @index_new.is_parking= true
        if @index_new.save
          render_success_format('Nueva entrada registrada',@index_new,true)
        end
      end
    rescue Exception => e
      render_default_error e, 401
    end

    # PATCH/PUT /index_new/1
    # PATCH/PUT /index_new/1.json
    def update
      @index_new.update_attributes!(index_new_params)
      render_success_format('Entrada actualizada',@index_new,true)
    rescue Exception => e
      render_default_error e, 401

    end

    # DELETE /index_new/1
    # DELETE /index_new/1.json
    def destroy
      @index_new.destroy
      render_success_format('Entrada eliminada',@index_new,true)
    rescue Exception => e
      render_default_error e, 401
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_new
      @index_new = IndexNew.find_by(id:params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_new_params
      params.permit(:title, :bodyone ,:subtitle ,:bodytwho ,:subtitletwo ,:bodythree,:imageone, :imagetwo ,:imagethree)
    end
  end
end
