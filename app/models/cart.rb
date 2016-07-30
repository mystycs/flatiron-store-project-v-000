class Cart < ActiveRecord::Base
	has_many :line_items
	belongs_to :user
	has_many :items, through: :line_items

	def total
		self.items.collect { |x| x.price }.inject(:+)
	end

	def add_item(item)
		if line =  self.line_items.find_by(item_id: item)
			line.quantity+=1
			line
		else
			self.line_items.build(item_id: item, cart_id: self.id)
		end
	end

	def checkout
		self.line_items.each do |line_item|
			line_item.item.inventory -= line_item.quantity
			line_item.item.save
		end
	end

end
