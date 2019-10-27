require 'pp'
require 'pry'
def find_item_by_name_in_collection(name, collection)
index = 0

while index < collection.length do 
  return collection[index] if name == collection[index][:item]
  index +=1

  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
index = 0
new_cart = []
while index < cart.length do
  item_name =  cart[index][:item]
  searched_item = find_item_by_name_in_collection(item_name, new_cart)
  
  if searched_item
     searched_item[:count] +=1
  else
      cart[index][:count] = 1
      new_cart << cart[index]
  end
  index += 1
  
end
new_cart
end

def compute_coupon(coupon)
  rounded_unit_price = (coupon[:cost].to_f * 1.0 / coupon[:num]).round(2)
  {
    :item => "#{coupon[:item]} W/COUPON",
    :price => rounded_unit_price,
    :count => coupon[:num]
  }
end

def apply_coupon_to_cart(matching_item, coupon, cart)
  matching_item[:count] -= coupon[:num]
  item_with_coupon = compute_coupon(coupon)
  item_with_coupon[:clearance] = matching_item[:clearance]
  cart << item_with_coupon
end


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

i = 0
  while i < coupons.count do
    coupon = coupons[i]
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]

    if item_is_in_basket and count_is_big_enough_to_apply
      apply_coupon_to_cart(item_with_coupon, coupon, cart)
    end
    i += 1
  end

  cart

  
end




def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

i = 0
  while i < cart.length do
    item = cart[i]
    if item[:clearance]
      discounted_price = ((1 - 0.20) * item[:price]).round(2)
        item[:price] = discounted_price
    end
    i += 1
  end

  cart



end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0
  i = 0

  ccart = consolidate_cart(cart)
  apply_coupons(ccart, coupons)
  apply_clearance(ccart)

  while i < ccart.length do
    total += items_total_cost(ccart[i])
    i += 1
  end

  total >= 100 ? total * (1.0 - 0.10) : total
end

# Don't forget, you can make methods to make your life easy!

def items_total_cost(i)
  i[:count] * i[:price]
end






