class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :params_page
  
  # GET /products
  def index
    if user_signed_in?
      @products = Product.paginate :page => params[:page], :per_page => 8, :order => :cents
    else
      @products = Product.for_sale.paginate :page => params[:page], :per_page => 8, :order => :cents
    end
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  def create
    @product = Product.new(params[:product])

    if @product.save
      if params[:product][:photo].blank?
        redirect_to(@product, :notice => 'Product was successfully created.')
      else
        render :action => 'crop'
      end
    else
      render :action => "new"
    end

  end

  # PUT /products/1
  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      if params[:product][:photo].blank?
        redirect_to(product_path(@product, :page => params[:page]), :notice => t('flash.products.update.success', :product => "#{@product}"))
      else
        render :action => 'crop'
      end
    else
      render :action => "edit"
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    
    redirect_to(products_path(:page => params[:page]), :notice => t('flash.products.destroy.success', :product => "#{@product}"))
  end
  
  private
  def params_page
    if params[:page].blank?
      params[:page] = 1
    end
  end
end
