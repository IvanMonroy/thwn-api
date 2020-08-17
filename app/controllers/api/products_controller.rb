module Api
  class ProductsController < ApplicationController
    include RenderHelper
    before_action :set_product, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false

    respond_to :json
    def all
    end
    def default_serializer_options
      { root: false }
    end

    # GET /products
    # GET /products.json
    def index
      @products = Product.all #.is_in_parking se quita para proeubas en angular
      render_default_format(@products,true,200)
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
      render_default_format(@product,true,200)
    rescue Exception => e
      puts e.inspect
    end

    def get_by_desc
      @products = Product.where("name LIKE ? OR description LIKE ? OR mark LIKE ? OR category LIKE ?", "#{params[:filter]}%", "#{params[:filter]}%", "#{params[:filter]}%", "#{params[:filter]}%")
      render_default_format(@products,true,200)
    rescue Exception => e
      render_default_error e, 401
    end

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    # POST /products.json
    def create
      @product = Product.new(product_params)
      if @product.plate_has_an_entry?
        render_default_error 'hay un error, Esta placa ya ha sido ingresada', 401
      else
        @product.date_arrival = Date.today.to_date
        @product.is_parking= true
        if @product.save
          render_success_format('Nueva entrada registrada',@product,true)
        end
      end
    rescue Exception => e
      render_default_error e, 401
    end

    # PATCH/PUT /products/1
    # PATCH/PUT /products/1.json
    def update
      @product.update_attributes!(product_params)
      render_success_format('Entrada actualizada',@product,true)
    rescue Exception => e
      render_default_error e, 401

    end

    # DELETE /products/1
    # DELETE /products/1.json
    def destroy
      @product.destroy
      render_success_format('Entrada eliminada',@product,true)
    rescue Exception => e
      render_default_error e, 401
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by(id:params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.permit(:name, :price, :description, :mark, :imgurl, :available, :available, :image, :category)
    end
  end
end
