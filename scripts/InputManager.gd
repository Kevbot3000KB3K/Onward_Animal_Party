extends Node

# --- Core UI Actions ---

func confirm_pressed() -> bool:
	return Input.is_action_just_pressed("confirm")

func cancel_pressed() -> bool:
	return Input.is_action_just_pressed("cancel")

func start_pressed() -> bool:
	return Input.is_action_just_pressed("start")

func pause_pressed() -> bool:
	return Input.is_action_just_pressed("pause")


# --- Movement ---

func move_up() -> bool:
	return Input.is_action_pressed("move_up")

func move_down() -> bool:
	return Input.is_action_pressed("move_down")

func move_left() -> bool:
	return Input.is_action_pressed("move_left")

func move_right() -> bool:
	return Input.is_action_pressed("move_right")


# --- Reserved ---

func action_1_pressed() -> bool:
	return Input.is_action_just_pressed("action_1")

func action_2_pressed() -> bool:
	return Input.is_action_just_pressed("action_2")
