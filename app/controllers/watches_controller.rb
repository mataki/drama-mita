class WatchesController < ApplicationController
  def index
    @watches = Watch.all
  end
  
  def show
    @watch = Watch.find(params[:id])
  end
  
  def new
    @watch = Watch.new
  end
  
  def create
    @watch = Watch.new(params[:watch])
    if @watch.save
      flash[:notice] = "Successfully created watch."
      redirect_to @watch
    else
      render :action => 'new'
    end
  end
  
  def edit
    @watch = Watch.find(params[:id])
  end
  
  def update
    @watch = Watch.find(params[:id])
    if @watch.update_attributes(params[:watch])
      flash[:notice] = "Successfully updated watch."
      redirect_to @watch
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @watch = Watch.find(params[:id])
    @watch.destroy
    flash[:notice] = "Successfully destroyed watch."
    redirect_to watches_url
  end
end
