#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 0.3

// This should be the only file necessary to open in Igor Pro to run ConMatNMRPro
// It will call functions from the Procedure files in included below
// The NMRAnalysisInitialization Macro shows up in the Macros Menu

//9/16/2015
//Procedure file created to streamline using functions

#include ":CMNMRP_Initialization"
#include ":CMNMRP_GeneralControls"
#include ":CMNMRP_Loadwaves"
#include ":CMNMRP_Structure"

#include ":CMNMRP_T1"
#include ":CMNMRP_FFTInt"

  
  
  
Macro ConMatNMRPro_Initialization()
	//This function will initialize the ConMatNMRPro software by making variables, waves, strings
	// folder ect, then checking the status of the ConMatNMRPro main panel
	// This macro can be called again in order to reinitialized the variables

	makevariables()

	checkanalysiswindow()
End
