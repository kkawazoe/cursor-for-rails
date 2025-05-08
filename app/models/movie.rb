# == Schema Information
#
# Table name: movies
#
#  id                           :bigint           not null, primary key
#  director_name                :string           default(""), not null
#  published_year               :integer
#  rating                       :float
#  restrict                     :integer          default("general"), not null
#  summary                      :text
#  title                        :string           not null
#  to_favorite_registered_count :integer          default(0), not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
class Movie < ApplicationRecord
  enum :restrict, {
    general: 0, # unlimited
    pg_12: 1,   # PG12
    r_15: 2,    # R15+
    r_18: 3     # R18+
  }, prefix: true

  scope :with_title, ->(title) do
    next if title.blank?

    where("title LIKE ?", "%#{title}%")
  end

  scope :with_summary, ->(summary) do
    next if summary.blank?

    where("summary LIKE ?", "%#{summary}%")
  end

  scope :with_restrict, ->(restrict) do
    next if restrict.nil?

    where(restrict: restrict)
  end

  scope :with_rating, ->(rating) do
    next if rating.nil?

    where("rating >= ?", rating)
  end

  scope :with_to_favorite_registered_count, ->(count) do
    next if count.nil?

    where("to_favorite_registered_count >= ?", count)
  end

  validates :title, presence: true
  validates :restrict, presence: true, inclusion: { in: restricts.keys }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5.0 }
  validates :director_name, presence: true
  validates :to_favorite_registered_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.search(options: {})
    with_title(options[:title])
      .with_summary(options[:summary])
      .with_restrict(options[:restrict])
      .with_rating(options[:rating])
      .with_to_favorite_registered_count(options[:to_favorite_registered_count])
      .order(to_favorite_registered_count: :desc, id: :asc)
  end
end
