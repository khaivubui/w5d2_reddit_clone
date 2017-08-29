# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :subs, presence: true
  after_initialize :set_blank_to_nil

  belongs_to :author,
             class_name: :User

  has_many :post_subs,
           dependent: :destroy

  has_many :subs,
           through: :post_subs

  has_many :comments

  def set_blank_to_nil
    self.url = nil if self.url == ""
    self.content = nil if self.content == ""
  end
end
