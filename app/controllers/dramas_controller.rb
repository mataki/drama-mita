class DramasController < ApplicationController
  def index
    @dramas = Drama.populer.paginate({:page => params[:page]})
  end

  def search
    @dramas = Drama.title_or_ambiguous_title_like(params[:query]).descend_by_updated_at.all(:limit => 50)
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
      redirect_to @drama
    else
      render :action => 'edit'
    end
  end

  def destroy
    @drama = Drama.find(params[:id])
    @drama.destroy
    redirect_to dramas_url
  end
end
