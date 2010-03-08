require "csv"

drama_list_path = File.expand_path('../../db/drama_list.csv', __FILE__)

Drama.transaction do
  CSV.open(drama_list_path, "r") do |raw|
    title = raw.shift
    next if title.blank?
    ambiguous_title = raw.shift
    title_image = raw.shift
    drama = Drama.find_or_initialize_by_title(title)
    drama.title_image = title_image
    drama.ambiguous_title = ambiguous_title
    drama.save!
    raw.each_with_index do |episode_title, index|
      episode = drama.episodes.find_or_initialize_by_title(episode_title) do |episode|
        episode.num = (index + 1)
        episode.save!
      end
    end
  end
end
