class Location < ApplicationRecord
  validates :postal_code, presence: true, uniqueness: true
  has_many :projects

  def self.most_active
    Location.joins(:projects).group(:id).order('project.location_id DESC').first
  end

  def self.top_5_most_active
    sql = 'SELECT locations.*, count(projects.location_id)
           AS project_count
           FROM "locations"
           INNER JOIN "projects"
           ON "projects"."location_id" = "locations"."id"
           GROUP BY "locations"."id"
           ORDER BY project_count DESC
           LIMIT 5'
    records_array = ActiveRecord::Base.connection.execute(sql)
    # Location.find_by_sql(sql)
    # binding.pry
  end
end
