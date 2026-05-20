extends Node

const DAMAGE_NUMBERS = preload("uid://cavvx4krfmcvh")


func add_damage_numbers(amount, position):
	var nums = DAMAGE_NUMBERS.instantiate()
	nums.position = position
	get_tree().root.add_child(nums)
