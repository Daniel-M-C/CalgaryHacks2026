extends Node

# inventory for pieces
var book_pieces : Array[BookTypes]

# inventory for completed pieces
var books_completed : Array[BookTypes]

# limit for ruin collection
var cart_limit = 3
var in_cart = 0
var in_cart_list: Array[BookPiece]

var is_dragging:BookPiece
var is_dragging_2d:BookPiece2D

# The node on the left
var drawing_holder : Glyph

# TODO set this
# The node on the right
var restoration_holder : Line2D

### Cart 
func put_in_cart(book_piece:BookPiece):
	if in_cart < cart_limit:
		in_cart += 1
		in_cart_list.append(book_piece)
		pass
	pass
	
func empty_cart():
	for i in range(in_cart_list.size()):
		print("Index:", i, "Value:", in_cart_list[i])
		
		# was 
		# book_pieces.append(in_cart_list[i])
		# if this change causes an issue, you can make another var
		# for this info since it's necessary for the drawing functions
		#book_pieces.append({
			 #'glyph' : in_cart_list[i].glyph,
			 #'part'  : in_cart_list[i].part,
			 #'colour': in_cart_list[i].colour})
		# using the BookType for interoperability between 2d and 3d
		book_pieces.append(in_cart_list[i].colour)
		in_cart_list[i].queue_free()
		in_cart_list.pop_at(i)
	# play pickup sound
	pass
	
### Drawing

func _ready() :
	await get_tree().process_frame
	# NOTE
	# for testing purposes only. Remove!
	const TESTING_BOOK = preload("uid://chbx4na2n10p7")
	const TESTING_RESTORATION = preload("uid://d2cvr5bw75o1r")
	book_pieces.append(TESTING_BOOK)
	books_completed.append(TESTING_RESTORATION)
	
	
	if ! drawing_holder :
		if len(get_tree().current_scene.find_children("", 'Glyph')) > 0 :
			drawing_holder = get_tree().current_scene.find_children("", 'Glyph')[0]
			# shouldn't rely on this
			drawing_holder.get_parent().make_books(book_pieces, books_completed)
	
	
	
func put_in_drawing_tablet(book_piece:BookPiece2D):
	#TODO (necessary) make all the BookPiece2D
	# on the table from the list of the book_pieces
	# so that we can drag them onto the drawing tablet.
	# prob do it in the drawing_tablet
	drawing_holder.change_book(book_piece)
	
	pass
	
func put_in_restoration_tablet(book_piece:BookPiece2D):
	return
	if in_cart < cart_limit:
		in_cart += 1
		in_cart_list.append(book_piece)
		pass
	pass
