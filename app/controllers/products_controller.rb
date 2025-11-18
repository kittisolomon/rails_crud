class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      flash.now[:notice] = 'Product was successfully created.'
      @product = Product.new 
    end
    render :new, status: @product.persisted? ? :ok : :unprocessable_entity
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity, :sku, :instock, :description)
  end
end
