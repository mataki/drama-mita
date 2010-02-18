class WatchesController < ApplicationController
  def index
    @populer_watches = Watch.populer.all
    @friends_watches = Watch.friends(current_user).all
  end

  def show
    @watch = Watch.find(params[:id])
  end

  def new
    @watch = Watch.new
  end

  def create
    @watch = Watch.new(params[:watch])
    @watch.user = current_user
    if @watch.save
      if @watch.drama.completed?(current_user)
        flash[:notice] = "#{@watch.drama.title}をコンプリートしました！おめでとう！"
        MixiRest::Activities.request(current_user.mixi_id, "#{@watch.drama.title}を全部見ました。あなたも見ませんか？", convert_url_for_mixi_app(url_for(@watch.drama)))
      else
        flash[:notice] = "見た登録しました"
      end
      redirect_to @watch.episode
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
