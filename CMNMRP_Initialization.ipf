#pragma rtGlobals=1		// Use modern global access method and strict wave access.

#pragma version = 0.3
 
//9/16/2015 AMM
// This Procedure file contains the main initialization functions for creating strings, variables, waves, reference waves, folders, 
//and the main analysis panel. This also includes some general procedures which make programming simpler

// 9/16/2015 AMM
// First documented the functions
// Initialize gspin=1, gtransition=1, gtransitionlower=-1, gNQR=0, gNQRstring="NMR"
// Initialize grecoveries=1, grecoveriesindex=1, grecvoeriesguessindex=1
//Changed main panel name to ConMatNMRPro, new analysis program name
// 9/20/2015
// Made Tab controled main window for raw data and different analysis types

Function Checkanalysiswindow()
	//Called by the ConMatNMRPro_Initialization Macro
	//Check if ConMatNMRPro panel is open
	//If open, brings it to front, if not open, creats ConMatNMRPro panel

	DoWindow ConMatNMRPro
	if(v_flag==1)
		Dowindow/F ConMatNMRPro
	elseif(v_flag==0)
		Execute "ConMatNMRPro()"
	endif

End

Function Makevariables()
	//Called by the ConMatNMRPro_Initialization Macro
	//Creates a main folder root:analysis: and further folders where varaibles, strings, waves, ect. are stored, then sets the data folder to root:analysis:system: for easier system variable and wave creation
	//Creates and initializes the global variables and strings
	//Makes system waves, T1 waves, FFT/Integral waves
	//Calls functions which create the variable name wave and T1recoveries waves
	
	newdatafolder/o root:analysis
	newdatafolder/o root:analysis:statwaves
	newdatafolder/o root:analysis:system
	newdatafolder/o root:analysis:t1waves 
	newdatafolder/o root:analysis:timewaves
	newdatafolder/o root:analysis:FFTsums
	newdatafolder/o root:analysis:Integral
	newdatafolder/o root:analysis:fits
	newdatafolder/o root:analysis:phase
	setdatafolder root:analysis:system

	//Datavariables
	variable/g gw0, gdw,gw,  gH0, gdH,gH, gsamplerate, gdatapoints, gpoints1D, gpoints2D, gfieldsweep, gfrequencysweep, gT1measure, ggyro
	
	//Analysis variables
	variable/g gbuffer, gbaselinestart, gbaselineend, gwindowstart, gwindowend, gbaseline, gwindow, gfilter, gfilterrange, gtphase, gtphasecorrect, gscanphase
	variable/g gfphase1, gfphase2, gfphasecorrect, gautophase1, gintreal, gintimag,gintmag, gindex, gindexparameter, gusegyro, gStoN
	
	//T1variables
	variable/g gspin=1, gtransition=1, gtransitionlower=1, gNQR=0, gMguess, gM, gMerror,  gT1guess, gT1, gT1error,  gtipguess, gtip, gtiperror,  gtstart, gtend, gtoffset
	variable/g gt1index, gt1indexparameter
	variable/g gstretch, gstretchfit, gstretchfiterror, gstretchguess
	variable/g grecoveries=1, grecoveriesindex=1, grecoveriesguessindex=1
	variable/g gT1type
	string/g gt1storagename, gNQRstring="NMR"
	
	
	//FFT Integral variables
	variable/g gmoment0, gmoment1, gmoment2, gmoment3, gmomentindex, gmomentindexparameter
	variable/g ggaussians, glorentzians, gGA, gLA, gGw, gLw, gGx, gLx, gFIbaseline, gGindex, gLindex
	variable/g gGAfit, gGafiterror, gGwfit, gGwfiterror, gGxfit, gGxfiterror, gLAfit, gLafiterror, gLwfit, gLwfiterror, gLxfit, gLxfiterror, gGfitindex, gLfitindex
	variable/g gFIbaselinefit, gFIBaselinefiterror, gglindex, gglparameter
	string/g gmomentstoragewavename, gGLstoragewavename
	
	//Conversion variables
	variable/g gsystem2i, gsystem2di, gdilfri, gdilfrdi
	
	//Time table
	variable/g gtpoints, gtdecimal, gttecmag,gtmapping
	
	//General Variables
	variable/g gprevioustab=0

	string/g gfilename, gstatwavename, gfftsumname, gtimewavename, gMname, gintwavename, gstoragewavename

	
	//Systemwaves
	make/o/n=(gpoints1D) root:analysis:system:Achan, root:analysis:system:Bchan, root:analysis:system:Zchan, root:analysis:system:FFTAchan, root:analysis:system:FFTBchan,root:analysis:system:FFTZchan
	make/o/n=(gpoints2D) root:analysis:system:guessfit, root:analysis:system:timewave, root:analysis:system:M, root:analysis:system:integral, root:analysis:system:fit_M	
	make/o/n=(gpoints2D) root:analysis:system:integral,root:analysis:system:fftsumwave
	make/o/n=(3) root:analysis:system:w_coef, root:analysis:system:w_sigma
	
	
	//T1waves
	make/o/n=(gpoints2D) M, timewave,t1guesswave, t1fitwave
	
	//FFT Int waves
	make/o/n=0 root:analysis:system:gaussianparameters, root:analysis:system:lorentzianparameters
	make/o/n=1000 FIguessfit, fit_fftsumwave
	
	makevariablenamewave()
	makeT1recoverywaves()
End

Function Makevariablenamewave()
	//Creates a text wave which stores the global names of variables which are stored in the stats wave specific to each experiment

	make/t/o/n=22 root:analysis:system:variablenames
	wave/t variablenames=root:analysis:system:variablenames

 variablenames[0]="gpoints1D";variablenames[1]="gpoints2D";variablenames[2]="gsamplerate";variablenames[3]="gw0";variablenames[4]="gdw";variablenames[5]="gH0";variablenames[6]="gdH";variablenames[7]="gfrequencysweep";
variablenames[8]="gfieldsweep";variablenames[9]="gT1measure";variablenames[10]="gbaselinestart";variablenames[11]="gbaselineend";variablenames[12]="gwindowstart";variablenames[13]="gwindowend";
  variablenames[14]="gfilterrange";variablenames[15]="gtphase";variablenames[16]="gfphase1";variablenames[17]="gfphase2";variablenames[18]="gtstart";variablenames[19]="gtend";variablenames[20]="gtoffset";variablenames[21]="gscanphase";

End

Function MakeT1recoverywaves()
	//Makes waves which store the recovery curve information for high field limit NMR recovery and eta=0 NQR recovery to be recalled by the T1 fit function
	//consts waves refer to the constanst infront of the exponentials and exps rever to the constants C: exp(-Ct/T1) 
	make/o/n=(1) root:analysis:system:Spin1_2NMRT1consts
	make/o/n=(1) root:analysis:system:Spin1_2NMRT1exps
	wave spin1_2T1consts= root:analysis:system:Spin1_2NMRT1consts
	wave spin1_2T1exps=root:analysis:system:Spin1_2NMRT1exps
	spin1_2T1consts[0]={1/2}
	spin1_2T1consts[0]={1}


	make/o/n=(3,2) root:analysis:system:Spin3_2NMRT1consts
	make/o/n=(3) root:analysis:system:Spin3_2NMRT1exps
	wave spin3_2T1consts= root:analysis:system:Spin3_2NMRT1consts
	wave spin3_2T1exps=root:analysis:system:Spin3_2NMRT1exps
	
	spin3_2T1consts[0][0]={9/10,0,1/10}
	spin3_2T1consts[0][1]={2/5, 1/2, 1/10}
	spin3_2T1exps={6,3,1}
	
	make/o/n=(5,3) root:analysis:system:Spin5_2NMRT1consts
	make/o/n=(5) root:analysis:system:Spin5_2NMRT1exps
	wave spin5_2T1consts= root:analysis:system:Spin5_2NMRT1consts
	wave spin5_2T1exps=root:analysis:system:Spin5_2NMRT1exps
	
	spin5_2T1consts[0][0]={50/63,0, 8/45,0, 1/35}
	spin5_2T1consts[0][1]={25/56,25/56,1/40,3/56,1/35}
	spin5_2T1consts[0][3]={1/14,2/7,2/5,3/14,1/35}
	spin5_2T1exps={15,10,6,3,1}
	
	make/o/n=(7,4) root:analysis:system:Spin7_2NMRT1consts
	make/o/n=(7) root:analysis:system:Spin7_2NMRT1exps
	wave spin7_2T1consts= root:analysis:system:Spin7_2NMRT1consts
	wave spin7_2T1exps=root:analysis:system:Spin7_2NMRT1exps
	
	spin7_2T1consts[0][0]={1225/1716,0,75/364,0,3/44,0,1/84}
	spin7_2T1consts[0][1]={196/429,49/132,1/1092,9/77,1/33,1/84,1/84}
	spin7_2T1consts[0][2]={49/429,49/132,100/273,25/308,1/132,1/21,1/84}
	spin7_2T1consts[0][3]={4/429,3/44,75/364,25/77,3/11,3/28,1/84}
	spin7_2T1exps={28,21,15,10,6,3,1}

	make/o/n=(9,5) root:analysis:system:Spin9_2NMRT1consts
	make/o/n=(9) root:analysis:system:Spin9_2NMRT1exps
	wave spin9_2T1consts= root:analysis:system:Spin9_2NMRT1consts
	wave spin9_2T1exps=root:analysis:system:Spin9_2NMRT1exps
	
	spin9_2T1consts[0][0]={7838/12115,0,1568/7293,0,6/65,0,24/715,0,1/165}
	spin9_2T1consts[0][1]={2205/4862,441/1430,49/14586,49/330,5/312,45/1144,361/17160,1/264,1/165}
	
	
	spin9_2T1exps={45,36,28,21,15,10,6,3,1}

	make/o/n=(1) root:analysis:system:Spin3_2NQRT1consts=1
	make/o/n=(1) root:analysis:system:Spin3_2NQRT1exps=3

	make/o/n=(2,2) root:analysis:system:Spin5_2NQRT1consts
	make/o/n=(2) root:analysis:system:Spin5_2NQRT1exps
	wave spin5_2T1consts= root:analysis:system:Spin5_2NQRT1consts
	wave spin5_2T1exps=root:analysis:system:Spin5_2NQRT1exps
	
	spin5_2T1consts[0][0]={25/28,3/28}
	spin5_2T1consts[0][1]={4/7,3/7}
	spin5_2T1exps={10,3}


	make/o/n=(3,3) root:analysis:system:Spin7_2NQRT1consts
	make/o/n=(3) root:analysis:system:Spin7_2NQRT1exps
	wave spin7_2T1consts= root:analysis:system:Spin7_2NQRT1consts
	wave spin7_2T1exps=root:analysis:system:Spin7_2NQRT1exps
	
	spin7_2T1consts[0][0]={49/66,18/77,1/42}
	spin7_2T1consts[0][1]={49/66,36/154,2/21}
	spin7_2T1consts[0][2]={3/22,50/77,3/14}
	spin7_2T1exps={21,10,3}
	
	make/o/n=(4,4) root:analysis:system:Spin9_2NQRT1consts
	make/o/n=(4) root:analysis:system:Spin9_2NQRT1exps
	wave spin9_2T1consts= root:analysis:system:Spin9_2NQRT1consts
	wave spin9_2T1exps=root:analysis:system:Spin9_2NQRT1exps
	
	spin9_2T1consts[0][0]={441/715,49/165,45/572,1/132}
	spin9_2T1consts[0][1]={576/715,4/165,20/143,1/33}
	spin9_2T1consts[0][2]={729/2860,147/220,5/572,3/44}	
	spin9_2T1consts[0][3]={16/715,49/165,80/143,4/33}
	spin9_2T1exps={36,21,10,3}
end


Function PrintStatwave()
	//Will reprint the text format of the statwave to recreat at a later time
	wave/t variablenames=root:systemwaves:variablenames
	string printout
	variable i
	printout="variablenames["+num2istr(i)+"]="+variablenames[i]+";"
	do
		i+=1
		printout=printout+"variablenames["+num2istr(i)+"]="+variablenames[i]+";"
	while(i<dimsize(variablenames,0)-1)
		
	print printout
	
end



Function storestats(s)
	//Stores the global variables in the stat wave associated with the current raw data wave

	STRUCT NMRdata &s
		
	string varname
	variable i=0

	do
		varname=s.variablenames[i]
		NVAR var=root:analysis:system:$varname
		s.statwave[i]=var
		
		i+=1
	while(i<dimsize(s.statwave, 0))
	
End

Function loadstats(s)
	//loads the stats in the stat wave for the current raw data wave
	//if the stat is NAN, the old stat will be store in in the stat wave, otherwise the statwave value is transfered to the corresponding global variable

	STRUCT NMRdata &s

	string varname
	variable varval, i=0

	do
		varname=s.variablenames[i]
		NVAR var=root:analysis:system:$varname
		if(numtype(s.statwave[i])==2)
			s.statwave[i]=var
		elseif(numtype(s.statwave[i])==0)
			var =s.statwave[i]
		endif		
		i+=1

	while(i<dimsize(s.statwave, 0))
		
End	

//Sets up the main analysis panel
//Calls the ConMatNMRProMaster() Function so that the recreation macro is not overwritten when closed
//Modifications to the actual setup of the panel should be made in ConMatNMRProMaster() other than	
	
//	PauseUpdate; Silent 1		// building window...
//	NewPanel /W=(0,0,1250,700)
//	ShowTools/A
	
//	NMRAnalysisMaster()

//If the panel is acidentlaly overwritten, replace the macro with the above code

//Window ConMatNMRPro() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(0,0,1250,700)
	ShowTools/A
	
	NMRAnalysisMaster()
//EndMacro

Window ConMatNMRPro() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(0,0,1270,740)
	
	TabControl Tabs,pos={1,0},size={1270,740},font="Arial",tabLabel(0)="Data", disable=0
	TabControl Tabs,tabLabel(1)="T1",tabLabel(2)="FFT/Integral",value= 0, proc=ConMatNMRProTabControl	
	
	
	DataTabMaster();SetActiveSubWindow ConMatNMRPro
	T1TabMaster();SetActiveSubWindow ConMatNMRPro
	setwindow $("conmatnmrpro#t1tab") hide=1
	FFTIntTabMaster();SetActiveSubWindow ConMatNMRPro
	setwindow $("conmatnmrpro#FFTInttab") hide=1

EndMacro




	
Function DataTabMaster()
	
	STRUCT NMRdata expt; initexpt(expt)
	
	NewPanel/W=(0, 20, 1270, 740)/Host=#
	Renamewindow #,DataTab
	
	SetActiveSubwindow	 ConMatNMRPro#DataTab
		
	variable x, y
	
	//File Name and Load File

	x=380;y=25
	
	TitleBox title0,pos={x+70,y},size={117,20}, disable=0, userdata(tab)="all"
	TitleBox title0,variable= root:analysis:system:gfilename
	PopupMenu popupseclectwave,pos={x,y+30},size={231,20},proc=loadspectrum,title="Select Wave", disable=0, userdata(tab)="all"
	PopupMenu popupseclectwave,mode=3,popvalue="",value= #"ListofWavesinFolder()"
	PopupMenu popuploadfile,pos={x,y+55},size={148,20},proc=LoadFile,title="Load File", disable=0, userdata(tab)="all"
	PopupMenu popuploadfile,mode=1,popvalue="Tecmag (.tnt)",value= #"\"Tecmag (.tnt);Tecmag Field Sweep (.txt folder);Magres2000 (.mr2)\""
	
	//Experiment Parameters

	x=10;y=80
	
	ValDisplay valdispScan1D,pos={x,y},size={90,13},title="Data points", disable=0
	ValDisplay valdispScan1D,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispScan1D,value= #"root:analysis:system:gpoints1D"
	ValDisplay valdispgpoints2D,pos={x,y+20},size={90,13},title="2D points", disable=0
	ValDisplay valdispgpoints2D,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgpoints2D,value= #"root:analysis:system:gpoints2D"
	SetVariable setvargsamplerate,pos={x,y+40},size={125,15},proc=SetStat,title="Sample rate (us)", disable=0
	SetVariable setvargsamplerate,value= root:analysis:system:gsamplerate

	SetVariable setvargw0,pos={x,y+70},size={160,15},proc=SetStat,title="Init. Frequency (MHz)", disable=0
	SetVariable setvargw0,value= root:analysis:system:gw0
	SetVariable setvardW,pos={x, y+90},size={160,15},proc=SetStat,title="Frequency Step (MHz)", disable=0
	SetVariable setvardW,value= root:analysis:system:gdw
	ValDisplay valdispgw,pos={x, y+110},size={160,13},title="Frequency (MHz)", disable=0
	ValDisplay valdispgw,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgw,value= #"root:analysis:system:gw"
	
	SetVariable setvargH0,pos={x, y+140},size={160,15},proc=SetStat,title="Initial Field (T)", disable=0
	SetVariable setvargH0,value= root:analysis:system:gH0
	SetVariable setvargdH,pos={x, y+160},size={160,15},proc=SetStat,title="Field step (T)", disable=0
	SetVariable setvargdH,value= root:analysis:system:gdH
	ValDisplay valdispgH,pos={x, y+180},size={160,13},title="Field (T)", disable=0
	ValDisplay valdispgH,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgH,value= #"root:analysis:system:gH"

	SetVariable setvargbuffer,pos={x+175,y+40},size={65,15},proc=GetbufferSetVar,title="Scan", disable=0
	SetVariable setvargbuffer,limits={0,inf,1},value= root:analysis:system:gbuffer

	//Experiment types
	
	x=280; y=120
	
	CheckBox checkgfieldsweep,pos={x,y},size={69,14},proc=DataManipulationCheckbox,title="Field Sweep", disable=0
	CheckBox checkgfieldsweep,variable= root:analysis:system:gfieldsweep
	CheckBox checkgfrequencysweep,pos={x+80,y},size={94,14},proc=DataManipulationCheckbox,title="Frequency Sweep", disable=0
	CheckBox checkgfrequencysweep,variable= root:analysis:system:gfrequencysweep
	CheckBox checkgT1measure,pos={x+180,y},size={82,14},proc=DataManipulationCheckbox,title="T1 mesurment", disable=0
	CheckBox checkgT1measure,variable= root:analysis:system:gT1measure

	//Current to Field Transofrmations LANL

	x=10;y=10

	SetVariable setvarSystem2I,pos={x,y},size={150,15},proc=CurrentConversion,title="System 2 Current (A)", disable=0
	SetVariable setvarSystem2I,value= root:analysis:system:gsystem2i
	SetVariable setvargSystem2dI,pos={x,y+20},size={150,15},proc=CurrentConversion,title="System 2 dCurrent (A)", disable=0
	SetVariable setvargSystem2dI,value= root:analysis:system:gsystem2di
	SetVariable setvarDilFrI,pos={x+155, y},size={150,15},proc=CurrentConversion,title="Dil Fridge Current (A)", disable=0
	SetVariable setvarDilFrI,value= root:analysis:system:gdilfri
	SetVariable setvarDilFrdI,pos={x+155, y+20},size={150,15},proc=CurrentConversion,title="Dil Fridge dCurrent (A)", disable=0
	SetVariable setvarDilFrdI,value= root:analysis:system:gdilfrdi

	//Data Controls
	
	x=660;y=10
	
	Button buttonRenamewave,pos={x,y},size={170,20},proc=Renamecurrentwave,title="Rename current data set", disable=0
	Button buttonDeleteCurrentDataset,pos={x+180,y},size={170,20},proc=KillCurrentData,title="Delete Current Data Set", disable=0
	//Append drop down menues have been excluded until the procedures are corrected
//	PopupMenu popupAppendfilebefore,pos={669,31},size={192,20},proc=Appendpopup,title="Append file before"
//	PopupMenu popupAppendfilebefore,mode=1,popvalue="From Memory",value= #"\"From Memory;From File (.tnt)\""
//	PopupMenu popupAppendfileafter,pos={674,53},size={185,20},proc=Appendpopup,title="Append file after"
//	PopupMenu popupAppendfileafter,mode=1,popvalue="From Memory",value= #"\"From Memory;From File (.tnt)\""

	//Time Data Manipulation

	x=180; y=550
	
	CheckBox checkgbaseline,pos={x,y},size={53,14},proc=DataManipulationCheckbox,title="Baseline", disable=0
	CheckBox checkgbaseline,variable= root:analysis:system:gbaseline
	ValDisplay valdispayBaselinestart,pos={x+85, y},size={100,13},title="Baseline start", disable=0
	ValDisplay valdispayBaselinestart,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispayBaselinestart,value= #"root:analysis:system:gbaselinestart"
	ValDisplay valdispayBaselineend,pos={x+195,y},size={100,13},title="Baseline end", disable=0
	ValDisplay valdispayBaselineend,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispayBaselineend,value= #"root:analysis:system:gbaselineend"
	Button buttonsetBaseline,pos={x+320,y-3},size={90,20},proc=SetDataManipulationButton,title="Set Baseline", disable=0

	y=575

	CheckBox checkgwindow,pos={x,y},size={52,14},proc=DataManipulationCheckbox,title="Window", disable=0
	CheckBox checkgwindow,variable= root:analysis:system:gwindow
	ValDisplay valdispayWindowStart,pos={x+85,y},size={100,13},title="Window start", disable=0
	ValDisplay valdispayWindowStart,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispayWindowStart,value= #"root:analysis:system:gwindowstart"
	ValDisplay valdispayWindowEnd,pos={x+195,y},size={100,13},title="Window  end", disable=0
	ValDisplay valdispayWindowEnd,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispayWindowEnd,value= #"root:analysis:system:gwindowend"
	Button buttonsetWindow,pos={x+320, y-3},size={90,20},proc=SetDataManipulationButton,title="Set Window", disable=0
	
	Button ButtonRevertData,pos={x+420,y-15},size={90,20},proc=SetDataManipulationButton,title="Revert Data", disable=0

	
	y=600
	
	CheckBox checkgfilter,pos={x,y},size={40,14},proc=DataManipulationCheckbox,title="Filter", disable=0
	CheckBox checkgfilter,variable= root:analysis:system:gfilter
	SetVariable setvarfilterfreq,pos={x+85, y},size={130,15},proc=SetStat,title="Filter range (kHz)", disable=0
	SetVariable setvarfilterfreq,limits={0,inf,25},value= root:analysis:system:gfilterrange
	
	y=625
	
	CheckBox checkgtphasecorrect,pos={x,y},size={79,14},proc=DataManipulationCheckbox,title="Phase Correct", disable=0
	CheckBox checkgtphasecorrect,variable= root:analysis:system:gtphasecorrect	
	SetVariable setvargtphase,pos={x+85,y},size={70,15},proc=SetStat,title="Phase", disable=0
	SetVariable setvargtphase,value= root:analysis:system:gtphase
	CheckBox checkgscanphase,pos={x+155,y},size={79,14},proc=ScanPhasecheckbox,title="Individ. Phase", disable=0
	CheckBox checkgscanphase,variable= root:analysis:system:gscanphase
	Button buttonautotphasecorrect,pos={x+300,y-3},size={130,20},proc=AutoTphasecorrect,title="Auto Phase Correct", disable=0

	//Frequency Data Manipulation

	x=730;y=560

	CheckBox checkgfphasecorrect,pos={x,y-10},size={79,14},proc=Modifycheckbox,title="Phase Correct", disable=0
	CheckBox checkgfphasecorrect,variable= root:analysis:system:gfphasecorrect
	CheckBox checkgautophase1,pos={x,y+10},size={76,14},proc=DataManipulationCheckbox,title="Auto Phase 1", disable=0
	CheckBox checkgautophase1,variable= root:analysis:system:gautophase1
	SetVariable setvargtphase1,pos={x+90,y},size={80,15},proc=SetStat,title="Phase1", disable=0
	SetVariable setvargtphase1,value= root:analysis:system:gfphase1
	SetVariable setvargtphase2,pos={x+175,y},size={130,15},proc=SetStat,title="Phase2 (1/MHz)", disable=0
	SetVariable setvargtphase2,value= root:analysis:system:gfphase2
	Button buttonautotphasecorrect1,pos={x+310,y-3},size={130,20},proc=AutoFphasecorrect,title="Auto Phase Correct", disable=0

	//Integration and FFT

	x=360;y=660

	CheckBox checkgintreal,pos={x,y},size={36,14},proc=DataManipulationCheckbox,title="Real", disable=0
	CheckBox checkgintreal,variable= root:analysis:system:gintreal
	CheckBox checkgintimag,pos={x+45,y},size={60,14},proc=DataManipulationCheckbox,title="Imaginary", disable=0
	CheckBox checkgintimag,variable= root:analysis:system:gintimag
	CheckBox checkgintmag,pos={x+110,y},size={63,14},proc=DataManipulationCheckbox,title="Magnitude", disable=0
	CheckBox checkgintmag,variable= root:analysis:system:gintmag
	Button buttonIntimedomain,pos={x,y+20},size={150,20},proc=Integratedata,title="Integrate time domain", disable=0
	
	x=890;y=660
	
	CheckBox checkgintreal1,pos={x,y},size={36,14},proc=DataManipulationCheckbox,title="Real", disable=0
	CheckBox checkgintreal1,variable= root:analysis:system:gintreal
	CheckBox checkgintimag1,pos={x+45,y},size={60,14},proc=DataManipulationCheckbox,title="Imaginary", disable=0
	CheckBox checkgintimag1,variable= root:analysis:system:gintimag
	CheckBox checkgintmag1,pos={x+110,y},size={63,14},proc=DataManipulationCheckbox,title="Magnitude", disable=0
	CheckBox checkgintmag1,variable= root:analysis:system:gintmag
	Button buttonInfreqdomain,pos={x,y+20},size={190,20},proc=Integratedata,title="Integrate frequency domain", disable=0

	x=940; y=610

	Button buttonFFTsum,pos={x,y},size={80,20},proc=FFTsum,title="FFT Sum", disable=0
	SetVariable setvarggryo,pos={x+90,y},size={160,15},proc=SetStat,title="Gyro. Ratio (MHz/T)", disable=0
	SetVariable setvarggryo,value= root:analysis:system:ggyro
	
	x=1180;y=545
	
	Button buttonAutoscaleFFT,pos={x,y},size={80,20},proc=AutoScaleButton,title="Auto Scale", disable=0

	//Graphs

	Display/W=(175,140,710,540)/HOST=#  root:analysis:system:Zchan,root:analysis:system:Bchan,root:analysis:system:Achan
	setactivesubwindow #
	ModifyGraph rgb(Zchan)=(0,0,0),rgb(Bchan)=(1,12815,52428)
	Label bottom "Time (us)"
	Cursor/P A Achan 56;Cursor/P B Zchan 210
	RenameWindow #,G0
	SetActiveSubwindow ##

	Display/W=(720,140,1255,540)/HOST=#  root:analysis:system:FFTZchan,root:analysis:system:FFTBchan,root:analysis:system:FFTAchan
	ModifyGraph rgb(FFTZchan)=(0,0,0),rgb(FFTBchan)=(1,12815,52428)
	Label bottom "Frequency (MHz)"
	Cursor/P A FFTZchan 496;Cursor/P B FFTZchan 524
	RenameWindow #,G1
	SetActiveSubwindow ##
	
	//expt.previoustab=0

End
	
Function T1TabMaster()

	STRUCT NMRdata expt; initexpt(expt)

	NewPanel/W=(0, 20, 1270, 740)/Host=#
	Renamewindow #,T1Tab
	
	SetActiveSubwindow	 ConMatNMRPro#T1Tab

	variable x, y

	//File Name and Load File
	
	x=380;y=25
	
	TitleBox title0,pos={x+70,y},size={117,20}, disable=0
	TitleBox title0,variable= root:analysis:system:gfilename
	PopupMenu popupseclectwave,pos={x,y+30},size={231,20},proc=loadspectrum,title="Select Wave", disable=0
	PopupMenu popupseclectwave,mode=3,popvalue="",value= #"ListofWavesinFolder()"
	//PopupMenu popuploadfile,pos={x,y+55},size={148,20},proc=LoadFile,title="Load File", disable=0
	//PopupMenu popuploadfile,mode=1,popvalue="Tecmag (.tnt)",value= #"\"Tecmag (.tnt);Tecmag Field Sweep (.txt folder);Magres2000 (.mr2)\""

	//Time wave
	
	x=20; y=150
	
	SetVariable setvargtstart,pos={x,y},size={100,15},title="time start"
	SetVariable setvargtstart,value= root:analysis:system:gtstart
	SetVariable setvargtend,pos={x,y+20},size={100,15},title="time end"
	SetVariable setvargtend,value= root:analysis:system:gtend
	SetVariable setvargtoffset,pos={x,y+40},size={100,15},title="time offset"
	SetVariable setvargtoffset,value= root:analysis:system:gtoffset
	Button buttonMaketimewave,pos={x-10,y+57},size={140,20},proc=Maketimewave,title="Make log Time wave"

	//Spin for fit
	
	NewPanel/W=(730, 160, 960, 295)/Host=conmatnmrpro#t1tab
	
	x=10;y=15	
	
	PopupMenu popupgspin,pos={x,y},size={107,20},proc=Spinpopup,title="Nuclear Spin"
	PopupMenu popupgspin,mode=1,popvalue="1/2",value= #"\"1/2;3/2;5/2;7/2;9/2\""
	
	SetVariable setvargrecoveries,pos={x+115,y},size={90,15},title="#recoveries"
	SetVariable setvargrecoveries,limits={1,inf,1},value= root:analysis:system:grecoveries	
	
	PopupMenu popupgtransition,pos={x,y+30},size={186,20},proc=Spinpopup,title="Nuclear Transiiton"
	PopupMenu popupgtransition,mode=1,popvalue="1/2<->-1/2",value= #"\"1/2<->-1/2; 1/2<->3/2; 3/2<->5/2; 5/2<->7/2;7/2<->9/2\""
	
	PopupMenu popupgNQR,pos={x,y+60},size={116,20},proc=Spinpopup,title="NMR or NQR?"
	PopupMenu popupgNQR,mode=1,popvalue="NMR",value= #"\"NMR;NQR\""

	CheckBox checkgstretched,pos={x+130, y+60},size={66,14},title="Stretched?"
	CheckBox checkgstretched,variable= root:analysis:system:gstretch

	string spintitle
	
	spintitle="I="+num2istr(expt.spin)+"/2     T=" +num2istr(expt.transition)+"/2<->"+num2istr(expt.transitionlower)
	spintitle+= "/2     "+expt.NQRstring

	TitleBox titlespin,pos={x,y+90},size={100,17},fSize=12, frame=0
	TitleBox titlespin,limits={0,0,0},barmisc={0,1000},mode= 1
	TitleBox titlespin,title=spintitle

	//Guess T1
	
	NewPanel/W=(730, 305, 960, 430)/Host=##
	
	x=10; y=15
	
	SetVariable setvargMguess,pos={x,y},size={120,15},proc=T1guesscontrol,title="M guess"
	SetVariable setvargMguess,value= root:analysis:system:gMguess
	SetVariable setvargMinfM0guess,pos={x, y+20},size={120,15},proc=T1guesscontrol,title="Tip frac. guess"
	SetVariable setvargMinfM0guess,value= root:analysis:system:gtipguess
	SetVariable setvargT1guess,pos={x, y+40},size={120,15},proc=T1guesscontrol,title="T1 guess"
	SetVariable setvargT1guess,value= root:analysis:system:gT1guess
	SetVariable setvargexponentguess,pos={x, y+60},size={120,15},proc=T1guesscontrol,title="Exponent guess"
	SetVariable setvargexponentguess,value= root:analysis:system:gstretchguess
	
	
	Button buttonCursorguess,pos={x,y+80},size={100,20},proc=Cursorguess,title="Cursor Guess"
	SetVariable setvargrecoveriesguessindex,pos={x+120,y},size={45,15},title="#"
	SetVariable setvargrecoveriesguessindex,limits={1,inf,1},value= root:analysis:system:grecoveriesguessindex

	//Fit T1

	NewPanel/W=(730, 445, 960, 570)/Host=##
	
	x=10; y=10
	
	Button buttonFitT1,pos={x+80,y},size={50,20},proc=FitT1,title="Fit T1"
	
	SetVariable setvargrecoveriesindex,pos={x,y},size={45,15},title="#"
	SetVariable setvargrecoveriesindex,limits={1,inf,1},value= root:analysis:system:grecoveriesindex
	
	ValDisplay valdispgM,pos={x,y+25},size={95,13},title="M fit"
	ValDisplay valdispgM,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgM,value= #"root:analysis:system:gM"
	ValDisplay valdispgMerror,pos={x+100,y+25},size={95,13},title="+/-"
	ValDisplay valdispgMerror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgMerror,value= #"root:analysis:system:gMerror"
	
	ValDisplay valdispgtip,pos={x, y+45},size={95,13},title="Inv. frac. fit"
	ValDisplay valdispgtip,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgtip,value= #"root:analysis:system:gtip"
	ValDisplay valdispgtiperror,pos={x+100, y+45},size={95,13},title="+/-"
	ValDisplay valdispgtiperror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgtiperror,value= #"root:analysis:system:gtiperror"

	ValDisplay valdispgT1,pos={x,y+65},size={95,13},title="T1 fit"
	ValDisplay valdispgT1,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgT1,value= #"root:analysis:system:gT1"
	ValDisplay valdispgT1error,pos={x+100, y+65},size={95,13},title="+/-"
	ValDisplay valdispgT1error,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgT1error,value= #"root:analysis:system:gT1error"
		
	ValDisplay valdispgexpfit,pos={x, y+85},size={95,13},title="Exp fit"
	ValDisplay valdispgexpfit,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgexpfit,value= #"root:analysis:system:gstretchfit"
	ValDisplay valdispgexpfiterror,pos={x+100, y+85},size={95,13},title="+/-"
	ValDisplay valdispgexpfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgexpfiterror,value= #"root:analysis:system:gstretchfiterror"	

	//Store Data
	
	NewPanel/W=(175, 570, 400, 710)/Host=##
	
	x=10;y=10
	
	PopupMenu popupt1storage,pos={x,y},size={186,20},proc=T1storagePopup,title="StorageWave"
	PopupMenu popupt1storage,mode=1, popvalue="T1vs", value= #"ListofT1vsWavesinFolder()"
	
	TitleBox title0,pos={x,y+25},size={9,9}
	TitleBox title0,variable= root:analysis:system:gt1storagename
	SetVariable setvargindex,pos={x, y+50},size={110,15},title="Storage Index"
	SetVariable setvargindex,value= root:analysis:system:gt1index
	SetVariable setvargindexparameter,pos={x, y+75},size={180,15},title="Index Parameter (H, w, T, ect)"
	SetVariable setvargindexparameter,value= root:analysis:system:gt1indexparameter
	Button buttonStoreData,pos={x, y+100},size={90,20},proc=StoreFitParameters,title="Store fit data"

	//Graphs

	Display/W=(175,140,710,540)/HOST=ConMatNMRPro#T1Tab  root:analysis:system:M vs root:analysis:system:timewave
	AppendToGraph root:analysis:system:fit_M vs root:analysis:system:timewave
	ModifyGraph mode(M)=3
	ModifyGraph marker(M)=19
	ModifyGraph log(bottom)=1
	Label bottom "Time (us)"
	Label left "M(t)"
	SetActiveSubwindow ##

End

Function FFTIntTabMaster()

	STRUCT NMRdata expt; initexpt(expt)

	NewPanel/W=(0, 20, 1270, 740)/Host=#
	Renamewindow #,FFTIntTab
	
	SetActiveSubwindow	 ConMatNMRPro#FFTIntTab

	variable x, y	
		
	//Select Data
	
	x=380;y=25
	
	TitleBox title0,pos={x+70,y},size={117,20}, disable=0
	TitleBox title0,variable= root:analysis:system:gfilename
	PopupMenu popupseclectwave,pos={x,y+30},size={231,20},proc=loadspectrum,title="Select Wave", disable=0
	PopupMenu popupseclectwave,mode=3,popvalue="",value= #"ListofWavesinFolder()"

	//Moment Panel
	
	NewPanel/W=(50, 570, 400, 720)/Host=ConMatNMRPro#FFTIntTab
	
	x=10;y=10
	
	Button buttonCalculateMoments,pos={x,y},size={130,20},proc=CalculateMomentsButton,title="Calculate Moments"
	ValDisplay valdispgmoment0,pos={x, y+25},size={120,13},title="0th moment"
	ValDisplay valdispgmoment0,limits={0,0,0},barmisc={0,1000}	
	ValDisplay valdispgmoment1,pos={x, y+45},size={120,13},title="1st moment"
	ValDisplay valdispgmoment1,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgmoment1,value= #"root:analysis:system:gmoment1"
	ValDisplay valdispgmoment2,pos={x, y+65},size={120,13},title="2nd moment"
	ValDisplay valdispgmoment2,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgmoment2,value= #"root:analysis:system:gmoment2"
	ValDisplay valdispgmoment3,pos={x, y+85},size={120,13},title="3rd moment"
	ValDisplay valdispgmoment3,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgmoment3,value= #"root:analysis:system:gmoment3"

	PopupMenu popupmomentstorage,pos={x+150,y},size={186,20},proc=MomentstoragePopup,title="StorageWave"
	PopupMenu popupmomentstorage,mode=1, popvalue="Momentvs", value= #"ListofMomentvsWavesinFolder()"
	
	TitleBox title0,pos={x+150,y+25},size={9,9}
	TitleBox title0,variable= root:analysis:system:gmomentstoragewavename
	SetVariable setvargmomindex,pos={x+150,y+50},size={65,15},title="Index"
	SetVariable setvargmomindex,value= root:analysis:system:gmomentindex
	SetVariable setvargmomindexparam,pos={x+150,y+75},size={90,15},title="Param."
	SetVariable setvargmomindexparam,value= root:analysis:system:gmomentindexparameter
	Button buttonStoreMoments,pos={x+150,y+100},size={130,20},proc=StoreMomParameters,title="Store Mom. Param."

	//Fit Spec sub panel 
	
	NewPanel/W=(730, 160, 960, 295)/Host=ConMatNMRPro#FFTIntTab

	x=10;y=10

	SetVariable setvargGaussians,pos={x,y},size={80,15},proc=GLGuessControl,title="Gaussians"
	SetVariable setvargGaussians,limits={0,inf,1},value= root:analysis:system:ggaussians
	SetVariable setvargbaseline,pos={x+40,y+20},size={100,15},proc=GLGuessControl,title="Baseline"
	SetVariable setvargbaseline,limits={0,inf,1},value= root:analysis:system:gFIbaseline

	SetVariable setvargGindex,pos={x,y+40},size={80,15},proc=GLGuessControl,title="G#"
	SetVariable setvargGindex,limits={0,inf,1},value= root:analysis:system:gGindex		
	SetVariable setvargGA,pos={x,y+60},size={80,15},proc=GLGuessControl,title="A"
	SetVariable setvargGA,limits={0,inf,1},value= root:analysis:system:gGA
	SetVariable setvargGw,pos={x,y+80},size={80,15},proc=GLGuessControl,title="w"
	SetVariable setvargGw,limits={0,inf,1},value= root:analysis:system:gGw
	SetVariable setvargGx,pos={x,y+100},size={80,15},proc=GLGuessControl,title="x"
	SetVariable setvargGx,limits={0,inf,1},value= root:analysis:system:gGx

	x=100;y=10

	SetVariable setvargLorentzians,pos={x,y},size={90,15},proc=GLGuessControl,title="Lorentzians"
	SetVariable setvargLorentzians,limits={0,inf,1},value= root:analysis:system:glorentzians
	
	SetVariable setvargLindex,pos={x, y+40},size={60,15},proc=GLGuessControl,title="L#"
	SetVariable setvargLindex,limits={0,inf,1},value= root:analysis:system:gLindex
	SetVariable setvargLA,pos={x, y+60},size={60,15},proc=GLGuessControl,title="A"
	SetVariable setvargLA,limits={0,inf,1},value= root:analysis:system:gLA
	SetVariable setvargLw,pos={x, y+80},size={60,15},proc=GLGuessControl,title="w"
	SetVariable setvargLw,limits={0,inf,1},value= root:analysis:system:gLw
	SetVariable setvargLx,pos={x, y+100},size={60,15},proc=GLGuessControl,title="x"
	SetVariable setvargLx,limits={0,inf,1},value= root:analysis:system:gLx


	//Fit spec sub panel
	
	NewPanel/W=(730, 305, 960, 430)/Host=ConMatNMRPro#FFTIntTab

	x=10;y=10
		
	Button buttonFitFI,pos={x,y},size={50,20},proc=FitFI,title="Fit"
	
	ValDisplay valdispFIbaseline,pos={x, y+20},size={100,13},title="Baseline fit"
	ValDisplay valdispFIbaseline,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispFIbaseline,value= #"root:analysis:system:gFIBaselinefit"
	ValDisplay valdispFIbaseline1,pos={x+100, y+20},size={100,13},title="+/-"
	ValDisplay valdispFIbaseline1,value= #"root:analysis:system:gFIBaselinefiterror"
	
	SetVariable setvargGfitindex,pos={340,494},size={80,15},proc=SetVarFitIndex,title="G index"
	SetVariable setvargGfitindex,limits={0,inf,1},value= root:analysis:system:gGfitindex
	ValDisplay valdispgGAfit,pos={340,510},size={100,13},title="G. A fit"
	ValDisplay valdispgGAfit,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGAfit,value= #"root:analysis:system:gGAfit"
	ValDisplay valdispgGAfiterror,pos={440,510},size={100,13},title="+/-"
	ValDisplay valdispgGAfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGAfiterror,value= #"root:analysis:system:gGAfiterror"
	ValDisplay valdispgGwfit,pos={340,525},size={100,13},title="G. w fit"
	ValDisplay valdispgGwfit,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGwfit,value= #"root:analysis:system:gGwfit"
	ValDisplay valdispgGwfiterror,pos={440,525},size={100,13},title="+/-"
	ValDisplay valdispgGwfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGwfiterror,value= #"root:analysis:system:gGwfiterror"
	ValDisplay valdispgGxfit,pos={340,540},size={100,13},title="G. x fit"
	ValDisplay valdispgGxfit,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGxfit,value= #"root:analysis:system:gGxfit"
	ValDisplay valdispgGxfiterror,pos={440,540},size={100,13},title="+/-"
	ValDisplay valdispgGxfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGxfiterror,value= #"root:analysis:system:gGxfiterror"
	
	
	
	SetVariable setvargLfitindex,pos={340,560},size={80,15},proc=SetVarFitIndex,title="L index"
	SetVariable setvargLfitindex,limits={0,inf,1},value= root:analysis:system:gLfitindex
	ValDisplay valdispFIbaseline1,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGLfit,pos={340,580},size={100,13},title="L. A fit"
	ValDisplay valdispgGLfit,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgGLfit,value= #"root:analysis:system:gLAfit"
	ValDisplay valdispgLAfiterror,pos={440,580},size={100,13},title="+/-"
	ValDisplay valdispgLAfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgLAfiterror,value= #"root:analysis:system:gLAfiterror"
	ValDisplay valdispgLwfit1,pos={340,595},size={100,13},title="L. w fit"
	ValDisplay valdispgLwfit1,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgLwfit1,value= #"root:analysis:system:gLwfit"
	ValDisplay valdispgLwfiterror,pos={440,595},size={100,13},title="+/-"
	ValDisplay valdispgLwfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgLwfiterror,value= #"root:analysis:system:gLwfiterror"
	ValDisplay valdispgLxfit1,pos={340,610},size={100,13},title="L. x fit"
	ValDisplay valdispgLxfit1,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgLxfit1,value= #"root:analysis:system:gLxfit"
	ValDisplay valdispgLxfiterror,pos={440,610},size={100,13},title="+/-"
	ValDisplay valdispgLxfiterror,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgLxfiterror,value= #"root:analysis:system:gLxfiterror"


	//Graph

	Display/W=(175,140,710,540)/HOST=ConMatNMRPro#FFTIntTab  root:analysis:system:fftsumwave
	Label left "Intensity (a.u.)"
	Label bottom "Field (T)"

	//expt.previoustab=2

End

//////////////////////
//General Procedures
/////////////////////



Function Lastpoint(wname)
	wave wname
	//Returns the last point of wave wname
		
	return dimsize(wname,0)-1
End

Function Firstxpoint(wname)
	wave wname
	//returns the first x value of the wave	
	return pnt2x(wname, 0)
end


Function Lastxpoint(wname)
	wave wname
	//returns the last x value of a wave
	
	return pnt2x(wname, dimsize(wname, 0)-1)
End


Function/s ListofWavesinFolder()
	//Lists all wavs in root:
	setdatafolder root:

	string list=""
	variable numwaves,index=0
	
	numwaves = Countobjects(":",1)
	do
		list=list + GetIndexedObjName(":", 1, index)+";"
		index +=1
	while(index < numwaves)
	
	return(Sortlist(list))
	
End

Function Samestring(string1, string2)
	string string1, string2
	
	//Determines if two strings are the exact same string
	if(cmpstr(string1, string2)==0)
		return 1
	else
		return 0
	endif
End

