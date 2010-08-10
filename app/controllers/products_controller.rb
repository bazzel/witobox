class ProductsController < ApplicationController
  before_filter :params_page
  
  # GET /products
  # GET /products.xml
  def index
    # @products = Product.for_sale.paginate :page => params[:page], :per_page => 8
    @products = Product.paginate :page => params[:page], :per_page => 8, :order => :cents

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
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
