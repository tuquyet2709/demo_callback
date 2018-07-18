class User < ApplicationRecord
  before_save :upcase_name, only: [:edit, :create, :show, :update]
  before_validation :test_duc
  before_update do
    self.email += "@gmail.com"
  end
  after_destroy {
      |user| logger.info("=================User #{user.id} was destroyed=================")
  }
  skip_callback :validation, :before, :test_duc, if: -> {age > 18}

  private

  def test_duc
    puts "======================Test======================"
  end

  def upcase_name
    name.upcase!
  end

  validates :email, presence: true,
            length: {maximum: 15}
end