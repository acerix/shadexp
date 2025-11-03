extends Panel

var centre = Vector2.ZERO
var zoom = 2.0
#var is_dragging = false
#var drag_start_p = Vector2.ZERO
#var drag_start_mouse_pos = Vector2.ZERO

#var is_zooming = false
#var zoom_mag = 1.0
#var palette_offset = 0
var t = 0.0

const ZOOM_MAX = 8;

func get_viewport_aspect_ratio():
	var viewport_size = get_viewport_rect().size
	if viewport_size.y == 0:
		return 1.0
	return viewport_size.x / viewport_size.y

func _input(_event):
	# quit when Esc is pressed
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _process(delta):
	# var t = Time.get_unix_time_from_system()
	t += delta
	
	#centre.x = 1 + 2 * sin(t)
	#centre.y = 1 + 2 * cos(t)
	#zoom = ZOOM_MAX + ZOOM_MAX * sin(4*t)
	
	# mandelbrot test
	#centre.x = 0
	#centre.y = 0.75
	#zoom = 2
	#centre.x = sin(t)
	#centre.y = 0.75 + sin(t)
	#zoom = 2 + sin(t)
	centre.x = 0.131825904205330
	centre.y = 0.743643887037151
	zoom = t ** 4
	
	var viewport_aspect_ratio = get_viewport_aspect_ratio()
	$".".material.set("shader_parameter/viewport_aspect_ratio", viewport_aspect_ratio)
	
	$".".material.set("shader_parameter/centre", centre)
	$".".material.set("shader_parameter/zoom", zoom)
	
	#$".".material.set("shader_parameter/F", F)
	
