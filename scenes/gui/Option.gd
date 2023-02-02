extends Control
var ip 
var Bandera
var volume 


func _process(delta):
	
	volume = $Volume/HSlider.value
	$Volume/labelVolume.text = str(volume)+"%"
	
	if $IP/IPtext.text !="" :
		$IP/validInvalid.text = "invalid"
		$Savebtn.disabled = true
	ip = $IP/IPtext.text
	
	if  $IP/IPtext.text !="" && isValided(ip):
		$IP/validInvalid.text = "valid"
		$Savebtn.disabled = false


func isValided(ip):
	 var regex = RegEx.new()
	 regex.compile( "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\." +
					"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\." +
					"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\." +
					"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
					
	 var result = regex.search(ip)
	
	 if result != null:
			return true
		
	
	  
	
	
	
	
	
#	var verdad = ip.split('.')
#
#	if verdad.size () != 5:
#	   Bandera = false
#	else:
#		 Bandera = true
#	for i in verdad:
#
#		if i > 2550 : 
#			print("es Mayor que 255")
#			Bandera = false
#
#		if i < "0" :
#			Bandera = false
#
#		#if /^[0][0-9]{1,2}/.test(verdad[i]):
#			#return false 
#
#			if verdad.size() == 4 && verdad[3] !='' :
#				print(verdad[verdad.size()-1])
#				Bandera =true
# return Bandera



