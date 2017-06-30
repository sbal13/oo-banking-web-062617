require 'bank_account.rb'


class Transfer
	attr_accessor :sender, :receiver, :amount, :status


	def initialize(sender, receiver, amount)
		@sender = sender
		@receiver = receiver
		@status = 'pending'
		@amount = amount
	end

	def valid?
		sender.valid? && receiver.valid? && @status == 'pending'
	end

	def execute_transaction
		@receiver.balance += @amount
		@sender.balance -= @amount
		@executed = true

		if !valid?
			reverse_transfer
			@status = 'rejected'
			return "Transaction rejected. Please check your account balance."
		end

		@status = 'complete'
		
	end


	def reverse_transfer
		if @executed
			@receiver.balance -= @amount
			@sender.balance += @amount
			@status = 'reversed'
		end
	end


end
