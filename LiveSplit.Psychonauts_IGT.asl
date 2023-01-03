state("Psychonauts")
{
	bool isLoading : "Psychonauts.exe", 0x38C7F4;
	string8 currentCutscene : "Psychonauts.exe", 0x395A97;
	string18 savingPreferences : "Psychonauts.exe", 0x01079A0, 0x34, 0x58, 0xC, 0x40, 0x8, 0x0;
}

start
{
	vars.oldSceneSplit = "";
	vars.brainTank2KillScene = "";
	print(current.savingPreferences);
	if (current.savingPreferences == "Saving preferences") {
		return true;
	}
}

split
{
	// Most splits here...
	if ((current.currentCutscene == "cabv.bik" || current.currentCutscene == "marksman" || current.currentCutscene == "caem_win" || current.currentCutscene == "nien.bik"
	 || current.currentCutscene == "llil.bik" || current.currentCutscene == "love.bik" || current.currentCutscene == "mmdd.bik" || current.currentCutscene == "mcvi.bik")
	  && current.currentCutscene != vars.oldSceneSplit) {
		vars.oldSceneSplit = current.currentCutscene;
		return true;
	} else if (current.currentCutscene == "assp.bik" && vars.brainTank2KillScene == "") { // Meat circus doesn't have a prerendered to go off of
		vars.brainTank2KillScene = current.currentCutscene;
		return false;
	} else if (vars.brainTank2KillScene != "" && current.isLoading) { // split once we've seen assp.bik and we hit a loading screen
		vars.brainTank2KillScene = "";
		return true;
	}
	else return false;
}

isLoading
{
	return current.isLoading;
}

exit
{
	timer.IsGameTimePaused = true;
} 

init
{
	timer.IsGameTimePaused = false;
	vars.oldSceneSplit = "";
	vars.brainTank2KillScene = "";
}

gameTime
{

}
