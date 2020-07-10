class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true

  validates :storage, presence: true

  def ready?
    self.cooked
  end
end
