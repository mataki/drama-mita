class WatchesController < ApplicationController
  def show
    @watch = Watch.find(params[:id])
  end

  def create
    if drama_id = params[:watch][:drama_id] and drama = Drama.find(drama_id)
      @watches = drama.create_all_episodes_watches(current_user)
    else
      @watch = Watch.new(params[:watch])
      @watch.user = current_user
    end
    if (@watch and @watch.save) or @watches
      drama = (@watch || @watches.first).drama
      if drama.completed?(current_user)
        flash[:notice] = "#{drama.title}をコンプリートしました！おめでとう！"
        MixiRest::Activities.request(current_user.mixi_id, "#{drama.title}を全部見ました。あなたも見ませんか？", convert_url_for_mixi_app(url_for(drama))) if valid_mixi_app_request
      else
        flash[:notice] = "見た登録しました"
      end
      redirect_to (@watch and @watch.episode) || drama
    else
      render :action => 'new'
    end
  end

  def update
    @watch = Watch.find(params[:id])
    if @watch.update_attributes(params[:watch])
      flash[:notice] = "Successfully updated watch."
      redirect_to (@watch and @watch.episode)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @watch = Watch.find(params[:id])
    @watch.destroy
    flash[:notice] = "Successfully destroyed watch."
    redirect_to (@watch and @watch.episode)
  end
end
