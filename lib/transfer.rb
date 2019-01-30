require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    if self.sender.valid? && self.receiver.valid?
      true
    else
      false
    end
  end

  def reverse_transfer

    self.sender.balance += self.amount
    self.receiver.balance -= self.amount
    self.status = "reversed"
  end

  def execute_transaction
    if self.valid? && self.status != "complete"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
        if self.valid?
          self.status = "complete"
        else
          self.reverse_transfer
          "Transaction rejected. Please check your account balance."
        end
    elsif self.sender.valid? == false
      "Transaction rejected. Please check your account balance."
    else
      "Transaction already completed."
    end
  end

end
