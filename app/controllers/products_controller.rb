class ProductsController < ApplicationController
  def index
    @products = if params[:search].present?
      Product.search(params[:search])
    else
      Product.all
    end
    @products = @products.page(params[:page]).order(created_at: :desc).per(8)
    @products_count = @products.total_count
  end

  def new
    sku ="SKU-#{rand(10000000..99999999)}-#{Time.now.year}"
    @product = Product.new(sku: sku)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash.now[:notice] = 'Product was successfully created.'
      @product = Product.new 
    end
    render :new, status: @product.persisted? ? :ok : :unprocessable_entity
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    
    if @product.update(product_params)
      flash[:notice] = 'Product updated successfully.'
      redirect_to edit_product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.image.purge if @product.image.attached?
    if @product.destroy 
    flash[:notice] = 'Product deleted successfully.'
    redirect_to products_path
    else
      flash.now[:error] = 'Product could not be deleted.'
      render :show, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity, :sku, :instock, :description, :image)
  end
end
