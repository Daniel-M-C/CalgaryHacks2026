extends Node

# inventory for pieces
var book_pieces :Array

# inventory for completed pieces
var books_completed :Array

# limit for ruin collection
var cart_limit := 3
var in_cart := 0
var in_cart_list: Array

var is_dragging:BookPiece

func put_in_cart(book_piece:BookPiece):
	if in_cart < cart_limit:
		in_cart += 1
		in_cart_list.append(book_piece)
		pass
	pass
	
	# call this when laeving the ruins
func empty_cart():
	for i in range(in_cart_list.size()):
		print("Index:", i, "Value:", in_cart_list[i])
		book_pieces.append(in_cart_list[i])
		in_cart_list.pop_at(i)
	# play pickup sound
	pass
