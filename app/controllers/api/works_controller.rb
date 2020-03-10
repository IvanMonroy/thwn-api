module Api
  class WorksController < ApplicationController
    include RenderHelper
    before_action :set_work, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json

    def all
    end

    def default_serializer_options
      {root: false}
    end

    # GET /work
    # GET /work.json
    def index
      @works = Work.all #.is_in_parking se quita para proeubas en angular
      render_default_format(@works, true, 200)
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
      render_default_format(@work, true, 200)
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
        @work.is_parking = true
        if @work.save
          render_success_format('Nueva entrada registrada', @work, true)
        end
      end
    rescue Exception => e
      render_default_error e, 401
    end

    # PATCH/PUT /work/1
    # PATCH/PUT /work/1.json
    def update
      @work.update_attributes!(work_params)
      render_success_format('Entrada actualizada', @work, true)
    rescue Exception => e
      render_default_error e, 401

    end

    # DELETE /work/1
    # DELETE /work/1.json
    def destroy
      @work.destroy
      render_success_format('Entrada eliminada', @work, true)
    rescue Exception => e
      render_default_error e, 401
    end

    def index_for_menu
      @works = Work.all.select(:id,:title, :category, :description, :first_image)
      render_success_format('Datos', @works, true)
    rescue Exception => e
      render_default_error e, 401
    end

    def index_for_gallery
      @work = Work.find_by_id params[:id] #.is_in_parking se quita para proeubas en angular
      render_default_format_2(format_images(
                                @work.id,@work.first_image,@work.first_header,@work.first_description,
                                @work.second_image,@work.second_header,@work.second_description,
                                @work.third_image,@work.third_header,@work.third_description,
                                @work.fourth_image,@work.fourth_header,@work.fourth_description,
                                @work.fifth_image,@work.fifth_header,@work.fifth_description,
                                @work.sixth_image,@work.sixth_header,@work.sixth_description

                            ), @work.title,true, 200)
    end

    def index_for_gallery_url
      @work = Work.find_by_id params[:id] #.is_in_parking se quita para proeubas en angular
      render_default_format_2(format_images_URL(
                                  @work.img_url_one,@work.first_header,@work.first_description,
                                  @work.img_url_two,@work.second_header,@work.second_description,
                                  @work.img_url_three,@work.third_header,@work.third_description,
                                  @work.img_url_fourth,@work.fourth_header,@work.fourth_description,
                                  @work.img_url_fifth,@work.fifth_header,@work.fifth_description,
                                  @work.img_url_sixth,@work.sixth_header,@work.sixth_description

                              ), @work.title,true, 200)
    end

    def format_images(id,image_1,header_1,description_1, image_2,header_2,description_2, image_3,header_3,description_3, image_4,header_4,description_4, image_5,header_5,description_5, image_6,header_6,description_6)
      id = id.to_s
      data = [{
                  srcUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/first_image/' + id + '/' + image_1,
                  previewUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/first_image/' + id + '/' + image_1,
                  header: header_1,
                  description: description_1
              },
              {
                  srcUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/second_image/' + id + '/' + image_2,
                  previewUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/second_image/' + id + '/' + image_2,
                  header: header_2,
                  description: description_2
              },
              {
                  srcUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/third_image/' + id + '/' + image_3,
                  previewUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/third_image/' + id + '/' + image_3,
                  header: header_3,
                  description: description_3
              },
              {
                  srcUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/fourth_image/' + id + '/' + image_4,
                  previewUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/fourth_image/' + id + '/' + image_4,
                  header: header_4,
                  description: description_4
              },
              {
                  srcUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/fifth_image/' + id + '/' + image_5,
                  previewUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/fifth_image/' + id + '/' + image_5,
                  header: header_5,
                  description: description_5
              },
              {
                  srcUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/sixth_image/' + id + '/' + image_6,
                  previewUrl: 'https://willreyn-admin.herokuapp.com/uploads/work/sixth_image/' + id + '/' + image_6,
                  header: header_6,
                  description: description_6
              }
      ]
    end


    def format_images_URL(image_1,header_1,description_1, image_2,header_2,description_2, image_3,header_3,description_3, image_4,header_4,description_4, image_5,header_5,description_5, image_6,header_6,description_6)
      data = [{
                  srcUrl: image_1,
                  previewUrl: image_1,
                  header: header_1,
                  description: description_1
              },
              {
                  srcUrl: image_2,
                  previewUrl: image_2,
                  header: header_2,
                  description: description_2
              },
              {
                  srcUrl: image_3,
                  previewUrl: image_3,
                  header: header_3,
                  description: description_3
              },
              {
                  srcUrl: image_4,
                  previewUrl: image_4,
                  header: header_4,
                  description: description_4
              },
              {
                  srcUrl: image_5,
                  previewUrl: image_5,
                  header: header_5,
                  description: description_5
              },
              {
                  srcUrl: image_6,
                  previewUrl: image_6,
                  header: header_6,
                  description: description_6
              }
      ]
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find_by(id: params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.permit(:title, :category, :description, :first_image, :first_header, :first_description, :second_image, :second_header, :second_description, :third_image, :third_header, :third_description, :fourth_image, :fourth_header, :fourth_description, :fifth_image, :fifth_header, :fifth_description, :sixth_image, :sixth_header, :sixth_description)
    end
  end
end
