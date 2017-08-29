# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :string           not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
             class_name: :User

  belongs_to :post

  belongs_to :parent_comment,
             foreign_key: :parent_comment_id,
             class_name: :Comment,
             optional: true
end
