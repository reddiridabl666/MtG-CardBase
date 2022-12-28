class User < ApplicationRecord
  has_secure_password

  validates :name, uniqueness: true, length: {maximum: 20}

  def self.by_name(str)
    return User.all if str.blank?
    User.where("name like ?", '%' + Card.sanitize_sql_like(str) + '%')
  end
end
