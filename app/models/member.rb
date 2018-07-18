class Member < User


  private

  def warning_member
    logger.info("=================User < 18 age =================")
    self.active = false
  end

  def downcase
    name.downcase!
  end
end
