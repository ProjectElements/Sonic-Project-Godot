extends Node
var save_path : String = "user://SFl1.save"
var save_2 : String = "user://SFll2.save"
var save_3 : String = "user://SFll3.save"

var lifecount = 3
#levels cleared
var exlevelcleared = 0
var exlevelscore = 0
var exlevelbesttimemin = 99
var exlevelbesttimesec = 99
var exlevelbesttimemili = 99

var exbosscleared = 0
var exbossscore = 0
var exbossbesttimemin = 99
var exbossbesttimesec = 99
var exbossbesttimemili = 99


func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	file.store_var(exlevelcleared)
	file.store_var(exlevelscore)
	file.store_var(exlevelbesttimemin)
	file.store_var(exlevelbesttimesec)
	file.store_var(exlevelbesttimemili)
	file.store_var(exbosscleared)
	file.store_var(exbossscore)
	file.store_var(exbossbesttimemin)
	file.store_var(exbossbesttimesec)
	file.store_var(exbossbesttimemili)
	file.store_var(lifecount)

func save2():
	var file = FileAccess.open(save_2, FileAccess.WRITE)
	
	file.store_var(exlevelcleared)
	file.store_var(exlevelscore)
	file.store_var(exlevelbesttimemin)
	file.store_var(exlevelbesttimesec)
	file.store_var(exlevelbesttimemili)
	file.store_var(exbosscleared)
	file.store_var(exbossscore)
	file.store_var(exbossbesttimemin)
	file.store_var(exbossbesttimesec)
	file.store_var(exbossbesttimemili)
	file.store_var(lifecount)
	
func save3():
	var file = FileAccess.open(save_3, FileAccess.WRITE)
	
	file.store_var(exlevelcleared)
	file.store_var(exlevelscore)
	file.store_var(exlevelbesttimemin)
	file.store_var(exlevelbesttimesec)
	file.store_var(exlevelbesttimemili)
	file.store_var(exbosscleared)
	file.store_var(exbossscore)
	file.store_var(exbossbesttimemin)
	file.store_var(exbossbesttimesec)
	file.store_var(exbossbesttimemili)
	file.store_var(lifecount)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		
		exlevelcleared = file.get_var(exlevelcleared)
		exlevelscore = file.get_var(exlevelscore)
		exlevelbesttimemin = file.get_var(exlevelbesttimemin)
		exlevelbesttimesec = file.get_var(exlevelbesttimesec)
		exlevelbesttimemili = file.get_var(exlevelbesttimemili)
		exbosscleared = file.get_var(exbosscleared)
		exbossscore = file.get_var(exbossscore)
		exbossbesttimemin = file.get_var(exbossbesttimemin)
		exbossbesttimesec = file.get_var(exbossbesttimesec)
		exbossbesttimemili = file.get_var(exbossbesttimemili)
		lifecount = file.get_var(lifecount)
	else:
		print("no data saved...")
		
		lifecount = 3
		
		exlevelcleared = 0
		exlevelscore = 0
		exlevelbesttimemin = 99
		exlevelbesttimesec = 99
		exlevelbesttimemili = 99

		exbosscleared = 0
		exbossscore = 0
		exbossbesttimemin = 99
		exbossbesttimesec = 99
		exbossbesttimemili = 99
		

func load_2():
	if FileAccess.file_exists(save_2):
		var file = FileAccess.open(save_2, FileAccess.READ)
		
		exlevelcleared = file.get_var(exlevelcleared)
		exlevelscore = file.get_var(exlevelscore)
		exlevelbesttimemin = file.get_var(exlevelbesttimemin)
		exlevelbesttimesec = file.get_var(exlevelbesttimesec)
		exlevelbesttimemili = file.get_var(exlevelbesttimemili)
		exbosscleared = file.get_var(exbosscleared)
		exbossscore = file.get_var(exbossscore)
		exbossbesttimemin = file.get_var(exbossbesttimemin)
		exbossbesttimesec = file.get_var(exbossbesttimesec)
		exbossbesttimemili = file.get_var(exbossbesttimemili)
		lifecount = file.get_var(lifecount)
	else:
		print("no data saved...")
		
		lifecount = 3
		
		exlevelcleared = 0
		exlevelscore = 0
		exlevelbesttimemin = 99
		exlevelbesttimesec = 99
		exlevelbesttimemili = 99

		exbosscleared = 0
		exbossscore = 0
		exbossbesttimemin = 99
		exbossbesttimesec = 99
		exbossbesttimemili = 99
		
func load_3():
	if FileAccess.file_exists(save_3):
		var file = FileAccess.open(save_3, FileAccess.READ)
		
		exlevelcleared = file.get_var(exlevelcleared)
		exlevelscore = file.get_var(exlevelscore)
		exlevelbesttimemin = file.get_var(exlevelbesttimemin)
		exlevelbesttimesec = file.get_var(exlevelbesttimesec)
		exlevelbesttimemili = file.get_var(exlevelbesttimemili)
		exbosscleared = file.get_var(exbosscleared)
		exbossscore = file.get_var(exbossscore)
		exbossbesttimemin = file.get_var(exbossbesttimemin)
		exbossbesttimesec = file.get_var(exbossbesttimesec)
		exbossbesttimemili = file.get_var(exbossbesttimemili)
		lifecount = file.get_var(lifecount)
	else:
		print("no data saved...")
		
		lifecount = 3
		
		exlevelcleared = 0
		exlevelscore = 0
		exlevelbesttimemin = 99
		exlevelbesttimesec = 99
		exlevelbesttimemili = 99

		exbosscleared = 0
		exbossscore = 0
		exbossbesttimemin = 99
		exbossbesttimesec = 99
		exbossbesttimemili = 99
		
func nosave():
	lifecount = 3
		
	exlevelcleared = 0
	exlevelscore = 0
	exlevelbesttimemin = 99
	exlevelbesttimesec = 99
	exlevelbesttimemili = 99

	exbosscleared = 0
	exbossscore = 0
	exbossbesttimemin = 99
	exbossbesttimesec = 99
	exbossbesttimemili = 99

func savedelete1():
	lifecount = 3
		
	exlevelcleared = 0
	exlevelscore = 0
	exlevelbesttimemin = 99
	exlevelbesttimesec = 99
	exlevelbesttimemili = 99

	exbosscleared = 0
	exbossscore = 0
	exbossbesttimemin = 99
	exbossbesttimesec = 99
	exbossbesttimemili = 99
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	file.store_var(exlevelcleared)
	file.store_var(exlevelscore)
	file.store_var(exlevelbesttimemin)
	file.store_var(exlevelbesttimesec)
	file.store_var(exlevelbesttimemili)
	file.store_var(exbosscleared)
	file.store_var(exbossscore)
	file.store_var(exbossbesttimemin)
	file.store_var(exbossbesttimesec)
	file.store_var(exbossbesttimemili)
	file.store_var(lifecount)
	
func savedelete2():
	lifecount = 3
		
	exlevelcleared = 0
	exlevelscore = 0
	exlevelbesttimemin = 99
	exlevelbesttimesec = 99
	exlevelbesttimemili = 99

	exbosscleared = 0
	exbossscore = 0
	exbossbesttimemin = 99
	exbossbesttimesec = 99
	exbossbesttimemili = 99
	
	var file = FileAccess.open(save_2, FileAccess.WRITE)
	
	file.store_var(exlevelcleared)
	file.store_var(exlevelscore)
	file.store_var(exlevelbesttimemin)
	file.store_var(exlevelbesttimesec)
	file.store_var(exlevelbesttimemili)
	file.store_var(exbosscleared)
	file.store_var(exbossscore)
	file.store_var(exbossbesttimemin)
	file.store_var(exbossbesttimesec)
	file.store_var(exbossbesttimemili)
	file.store_var(lifecount)
	
func savedelete3():
	lifecount = 3
		
	exlevelcleared = 0
	exlevelscore = 0
	exlevelbesttimemin = 99
	exlevelbesttimesec = 99
	exlevelbesttimemili = 99

	exbosscleared = 0
	exbossscore = 0
	exbossbesttimemin = 99
	exbossbesttimesec = 99
	exbossbesttimemili = 99
	
	var file = FileAccess.open(save_3, FileAccess.WRITE)
	
	file.store_var(exlevelcleared)
	file.store_var(exlevelscore)
	file.store_var(exlevelbesttimemin)
	file.store_var(exlevelbesttimesec)
	file.store_var(exlevelbesttimemili)
	file.store_var(exbosscleared)
	file.store_var(exbossscore)
	file.store_var(exbossbesttimemin)
	file.store_var(exbossbesttimesec)
	file.store_var(exbossbesttimemili)
	file.store_var(lifecount)
