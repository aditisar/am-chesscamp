class Family < ActiveRecord::Base
  include ChessCampHelpers

  # relationships
  has_many :students
  has_many :registrations, through: :students

  # scopes
  scope :alphabetical, -> { order('family_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  # validations
  validates_presence_of :family_name, :phone
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  # callbacks
  before_destroy :is_never_destroyable
  before_save :reformat_phone

  def make_inactive
    self.active = false
    self.save!
  end

  def to_s
    self.family_name
  end

  def amount_paid
    a = 0
    self.students.each do |s|
      s.registrations.each do |r|
        r.payment_status == 'full' ? a+=r.camp.cost : a+=50
      end
    end
    return a
  end
  
    def balance_due
    b = 0
    self.students.each do |s|
      s.registrations.each do |r|
        r.payment_status == 'full' ? b+=0 : b+= r.camp.cost - 50 
      end
    end
    return b
  end
end
