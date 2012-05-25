class Permission
  include Mongoid::Document
  field :route, type: String

  validates :route, presence: true

  attr_accessible :route

  embedded_in :project
end
