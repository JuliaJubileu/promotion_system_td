class PromotionApproval < ApplicationRecord
  belongs_to :promotion
  belongs_to :user
<<<<<<< HEAD
  
  validate :different_user
  
  private
  
=======

  validate :different_user

  private

>>>>>>> af97c791456378dc41b8fec153ac32d908243764
  def different_user
    if promotion && promotion.user == user 
      errors.add(:user, 'não pode ser o criador da promoção')
    end
  end
end
