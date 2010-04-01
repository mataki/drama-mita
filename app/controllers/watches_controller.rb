class WatchesController < ApplicationController
  def index
    @episode = Episode.find(params[:episode_id])
  end

  def create
    if drama_id = params[:watch][:drama_id] and drama = Drama.find(drama_id)
      @watches = drama.create_all_episodes_watches(current_user)
    else
      @watch = Watch.new(params[:watch])
      @watch.user = current_user
      drama = @watch.drama
    end
    before_count = current_user.watches_count_by_drama(drama)
    if (@watch and @watch.save) or @watches
      redirect_url = url_for((@watch and @watch.episode) || drama)
      if drama.completed?(current_user, true)
        flash[:notice] = "#{drama.title}をコンプリートしました！おめでとう！"
        send_activity("#{drama.title}を全部見たよ(#{drama.completed_users_count}人目)。あなたはあのドラマみた？", convert_url_for_mixi_app(url_for(drama)), redirect_url)
      else
        if before_count < 1
          flash[:notice] = "#{drama.title}を初めて見た！を登録しました"
          send_activity("#{drama.title}を見たよ(#{drama.watched_users_count}人目)。あなたはあのドラマみた？", convert_url_for_mixi_app(url_for(drama)), redirect_url)
        else
          redirect_to redirect_url
        end
      end
    else
      render :action => 'new'
    end
  end

  def update
    @watch = Watch.find(params[:id])
    if @watch.update_attributes(params[:watch])
      redirect_to (@watch and @watch.episode)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @watch = Watch.find(params[:id])
    @watch.destroy
    redirect_to @watch.episode
  end

private
  def send_activity(title, url, return_to)
    session[:activity] = { :title => title, :url => url, :return_to => return_to }
    redirect_to new_activity_path
  end
end
