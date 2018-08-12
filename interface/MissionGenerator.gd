extends VBoxContainer

const Mission = preload('res://interface/Mission.tscn')

onready var MissionContainer : = $MarginContainer/VBoxContainer/ScrollContainer/Missions as VBoxContainer


const TITLE_START = ['Kill', 'Annihilate', 'Destroy', 'Exterminate']

const TITLE_VICTIM = ['Mr. Thompson', 'Eduardo', 'Jose', 'Willian']

const TITLE_VICTIM_FEMALE = ['Caroline', 'Marta', 'This Dudette']

const RARE_TITLE_VICTIM = ['Donald Trump', 'Kim Gon Jun']

const DESCRIPTION_START = ['I want him dead,']

const DESCRIPTION_START_FEMALE = ['I want her dead,']

const DESCRIPTION_REASON = [
	'because he stole my guitar,', 
	'because he beat me in fortnite,',
	'\'cause he\'s a noisy neighbour,',
	'since he said my butt looks big,']

const DESCRIPTION_REASON_FEMALE = [
	'because she stole my guitar,', 
	'because she beat me in fortnite,',
	'\'cause she\'s a noisy neighbour,',
	'since she said my butt looks big,']

const DESCRIPTION_END = ['fast!', 'ASAP']


func _ready() -> void:
	randomize()
	for x in range(7):
		var new_mission = Mission.instance() as Mission
		var male : = rand_range(0, 100) > 50
		new_mission.init(_generate_title(male), _generate_description(male), 500)
		MissionContainer.add_child(new_mission)


func _generate_title(male : bool) -> String:
	var start = TITLE_START[rand_range(0, TITLE_START.size())]
	var end : String
	
	if male:
		end = TITLE_VICTIM[rand_range(0, TITLE_VICTIM.size())]
	else:
		end = TITLE_VICTIM_FEMALE[rand_range(0, TITLE_VICTIM_FEMALE.size())]
	
	return start + ' ' + end
	

func _generate_description(male : bool) -> String:
	var start : String
	var reason : String
	var end : String
	
	if male:
		start = DESCRIPTION_START[rand_range(0, DESCRIPTION_START.size())]
		reason = DESCRIPTION_REASON[rand_range(0, DESCRIPTION_REASON.size())]
	else:
		start = DESCRIPTION_START_FEMALE[rand_range(0, DESCRIPTION_START_FEMALE.size())]
		reason = DESCRIPTION_REASON_FEMALE[rand_range(0, DESCRIPTION_REASON_FEMALE.size())]
	
	end = DESCRIPTION_END[rand_range(0, DESCRIPTION_END.size())]
	
	return start + ' ' + reason + ' ' + end


