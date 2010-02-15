class DramasController < ApplicationController
  def index
    unless params[:query].blank?
      @dramas = Drama.title_like(params[:query]).all
    else
      @dramas = Drama.populer.all
      render "populer"
    end
  end

  def show
    @drama = Drama.find(params[:id])
  end

  def new
    @drama = Drama.new
  end

  def create
    @drama = Drama.new(params[:drama])
    if @drama.save
      flash[:notice] = "Successfully created drama."
      redirect_to @drama
    else
      render :action => 'new'
    end
  end

  def edit
    @drama = Drama.find(params[:id])
  end

  def update
    @drama = Drama.find(params[:id])
    if @drama.update_attributes(params[:drama])
      flash[:notice] = "Successfully updated drama."
      redirect_to @drama
    else
      render :action => 'edit'
    end
  end

  def destroy
    @drama = Drama.find(params[:id])
    @drama.destroy
    flash[:notice] = "Successfully destroyed drama."
    redirect_to dramas_url
  end
end