class Project < ApplicationRecord

 include ActionView::Helpers::NumberHelper
  belongs_to :location
  belongs_to :category, required: false
  has_many   :project_owners
  has_many   :owners, through: :project_owners, source: :user
  has_many   :rewards
  has_many   :project_backers
  has_many   :backers, through: :project_backers, source: :user

  validates  :title,
             :description,
             :image_url,
             :target_amount,
             :category_id,
             :completion_date,
             presence: true
  validates_format_of :title, :without => /^\d/, :multiline => true

  validates :slug, uniqueness: true

  before_create :create_slug

  def self.find(input)
    input.to_i == 0 ? find_by(slug: input) : super
  end

  def create_slug
    self.slug = self.title.parameterize
  end

  def to_param
    slug
    #[id, title.parameterize].join("-")
  end

  def formatted_price
    number_to_currency(target_amount, unit: "$", format: "%u%n", precision: 0)
  end

  def end_date
    completion_date.strftime("%B %d, %Y")
  end

  def end_time
    completion_date.strftime("%l:%M %p")
  end

  def end_date_time
   "#{end_date} at #{end_time}"
  end

  def total_pledged
    self.project_backers.sum("pledge_amount")
  end

  def percentage_pledged
    (total_pledged.to_f/target_amount)*100
  end

  def self.most_funded
    Project.joins(:project_backers).group(:id).order('sum(pledge_amount)desc').first
  end

  def days_remaining
   (Date.parse(end_date) - Date.today).to_int
  end
end
