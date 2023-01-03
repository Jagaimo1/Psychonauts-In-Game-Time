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
	if (current.savingPreferences == "Saving preferences") {
		return true;
	}
}

startup {
	settings.Add("BasicBrainingStart", true);
    settings.Add("ShootingGallery", true);
    settings.Add("DanceParty", true);
    settings.Add("BrainTank", true);
    settings.Add("ScavengerHunt", true);
	settings.Add("Linda", true);
	settings.Add("Lungfishopolis", true);
	settings.Add("Milkman", true);
	settings.Add("BrainTank2", true);
	settings.Add("MeatCircusFinish", true);
}

split
{
	// Most splits here...
	if (((current.currentCutscene == "cabv.bik" && settings["BasicBrainingStart"]) || (current.currentCutscene == "marksman" && settings["ShootingGallery"]) 
	 || (current.currentCutscene == "caem_win" && settings["DanceParty"]) || (current.currentCutscene == "nien.bik"  && settings["BrainTank"])
	 || (current.currentCutscene == "llbt.bik" && settings["ScavengerHunt"]) || (current.currentCutscene == "llil.bik" && settings["Linda"]) 
	 || (current.currentCutscene == "love.bik" && settings["Lungfishopolis"]) || (current.currentCutscene == "mmdd.bik" && settings["Milkman"]) 
	 || (current.currentCutscene == "mcvi.bik" && settings["MeatCircusFinish"])) && current.currentCutscene != vars.oldSceneSplit) {
		vars.oldSceneSplit = current.currentCutscene;
		return true;
	} else if (current.currentCutscene == "assp.bik" && vars.brainTank2KillScene == "" && settings["BrainTank2"]) { // Meat circus doesn't have a prerendered to go off of
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
