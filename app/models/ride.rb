class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def enough_tickets?
    self.user.tickets > self.attraction.tickets
  end

  def tall_enough?
    self.user.height > self.attraction.min_height
  end

  def take_ride
    if enough_tickets? && tall_enough?
      self.user.update(tickets: self.user.tickets - self.attraction.tickets, nausea: self.user.nausea + self.attraction.nausea_rating, happiness: self.user.happiness + self.attraction.happiness_rating)
      notice = "Thanks for riding the #{attraction.name}!"
    elsif !enough_tickets? && tall_enough?
      notice = "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif enough_tickets? && !tall_enough?
      notice = "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      notice = "Sorry. You do not have enough tickets to ride the #{attraction.name}. " "You are not tall enough to ride the #{attraction.name}."
    end
  end
end
