require "csv"

drama_list_path = File.expand_path('../../db/drama_list.csv', __FILE__)

Drama.transaction do
  CSV.open(drama_list_path, "r") do |raw|
    title = raw.shift
    next if title.blank?
    title_image = raw.shift
    drama = Drama.find_or_initialize_by_title(title) do |drama|
      drama.title_image = title_image
      drama.save!
    end
    raw.each_with_index do |episode_title, index|
      episode = drama.episodes.find_or_initialize_by_title(episode_title) do |episode|
        episode.num = (index + 1)
        episode.save!
      end
    end
  end
end
