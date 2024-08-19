extends Node
class_name AnimExec

var execActive: bool = true
var killHost: bool = false

func ExecuteQueue(queue: Array, displacement: Vector3):
	var timePassed: float = 0.0
	$"../../VisualsOffset".position = -displacement
	
	for ii in queue:
		await get_tree().create_timer(ii[0] - timePassed).timeout
		timePassed = ii[0]
		
		if(execActive):
			get_parent().animPlayers[ii[1]].play(ii[2])
			if(ii.size() >= 4): 
				$"../../VisualsOffset".position += ii[3]
				$"../../VisualsOffset/Visuals".position -= ii[3]
			
	if(execActive):
		$"../../VisualsOffset".position = Vector3.ZERO
	await get_tree().create_timer(1.0).timeout
	End()

func Skip():
	execActive = false

func End():
	queue_free()
	if(killHost):
		get_parent().get_parent().queue_free()
