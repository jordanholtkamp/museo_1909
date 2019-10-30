class Curator

  attr_reader :photographs, :artists
  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find { |artist| artist.id == id }
  end

  def find_photograph_by_id(id)
    @photographs. find { |photo| photo.id == id }
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    group = @photographs.group_by do |photo|
      photo.artist_id
    end
    ids = group.map do |photo_hash|
      if photo_hash.last.length > 1
        photo_hash.last[0].artist_id
      end
    end.compact
      @artists.map do |artist|
        if ids.include?(artist.id)
          artist
        end
      end.compact
  end
  # I know this is probably nasty code

  def photographs_taken_by_artist_from(country)
    artists_match_country = @artists.find_all do |artist|
      artist.country == country
    end
    photos = []
    @photographs.each do |photo|
      artists_match_country.each do |artist|
        if photo.artist_id == artist.id
          photos << photo
        end
      end
    end
    photos
  end
end