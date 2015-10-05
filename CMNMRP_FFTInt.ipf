#pragma rtGlobals=1		// Use modern global access method and strict wave access.

Window integralFFTSUMpanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(303,216,1023,855)
	ShowInfo/W=integralFFTSUMpanel
	
	
	PopupMenu popselectwave,pos={243,50},size={221,20},proc=loadspectrum,title="Select Wave"
	PopupMenu popselectwave,mode=1,popvalue="",value= #"ListofWavesinFolder()"
	TitleBox displayfilename,pos={303,16},size={117,20}
	TitleBox displayfilename,variable= root:analysis:system:gfilename
	
	//Moments display
	
	Button buttonCalculateMoments,pos={10,457},size={130,20},proc=CalculateMomentsButton,title="Calculate Moments"
	ValDisplay valdispgmoment1,pos={10,480},size={120,13},title="1st moment"
	ValDisplay valdispgmoment1,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgmoment1,value= #"root:analysis:system:gmoment1"
	ValDisplay valdispgmoment2,pos={10,500},size={120,13},title="2nd moment"
	ValDisplay valdispgmoment2,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgmoment2,value= #"root:analysis:system:gmoment2"
	ValDisplay valdispgmoment3,pos={10,520},size={120,13},title="3rd moment"
	ValDisplay valdispgmoment3,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispgmoment3,value= #"root:analysis:system:gmoment3"
	
	
	Button buttonstoremomenta,pos={9,537},size={130,20},proc=SetMomentStorageWaveName,title="Mom. Storage Loc. "
	TitleBox title0,pos={146,538},size={9,9}
	TitleBox title0,variable= root:analysis:system:gmomentstoragewavename
	Button buttonStoreMoments,pos={8,592},size={130,20},proc=StoreMomParameters,title="Store Mom. Param."
	SetVariable setvargmomindex,pos={16,563},size={65,15},title="Index"
	SetVariable setvargmomindex,value= root:analysis:system:gmomentindex
	SetVariable setvargmomindexparam,pos={85,564},size={90,15},title="Param."
	SetVariable setvargmomindexparam,value= root:analysis:system:gmomentindexparameter
	Button buttonAutoscaleFFTSum,pos={611,457},size={80,20},proc=AutoScale,title="Auto Scale"
	
	//Set Guess parameters
	
	
	SetVariable setvargGaussians,pos={200,460},size={80,15},proc=GLGuessControl,title="Gaussians"
	SetVariable setvargGaussians,limits={0,inf,1},value= root:analysis:system:ggaussians
	SetVariable setvargLorentzians,pos={235,480},size={90,15},proc=GLGuessControl,title="Lorentzians"
	SetVariable setvargLorentzians,limits={0,inf,1},value= root:analysis:system:glorentzians
	SetVariable setvargbaseline,pos={210,500},size={100,15},proc=GLGuessControl,title="Baseline"
	SetVariable setvargbaseline,limits={0,inf,1},value= root:analysis:system:gFIbaseline

	SetVariable setvargGindex,pos={190,520},size={60,15},proc=GLGuessControl,title="G#"
	SetVariable setvargGindex,limits={0,inf,1},value= root:analysis:system:gGindex		
	SetVariable setvargGA,pos={190,540},size={60,15},proc=GLGuessControl,title="A"
	SetVariable setvargGA,limits={0,inf,1},value= root:analysis:system:gGA
	SetVariable setvargGw,pos={190,560},size={60,15},proc=GLGuessControl,title="w"
	SetVariable setvargGw,limits={0,inf,1},value= root:analysis:system:gGw
	SetVariable setvargGx,pos={190,580},size={60,15},proc=GLGuessControl,title="x"
	SetVariable setvargGx,limits={0,inf,1},value= root:analysis:system:gGx
	
	SetVariable setvargLindex,pos={270,520},size={60,15},proc=GLGuessControl,title="L#"
	SetVariable setvargLindex,limits={0,inf,1},value= root:analysis:system:gLindex
	SetVariable setvargGA1,pos={270,540},size={60,15},proc=GLGuessControl,title="A"
	SetVariable setvargGA1,limits={0,inf,1},value= root:analysis:system:gLA
	SetVariable setvargGw1,pos={270,560},size={60,15},proc=GLGuessControl,title="w"
	SetVariable setvargGw1,limits={0,inf,1},value= root:analysis:system:gLw
	SetVariable setvargGx1,pos={270,580},size={60,15},proc=GLGuessControl,title="x"
	SetVariable setvargGx1,limits={0,inf,1},value= root:analysis:system:gLx
	
	Button buttonFitFI,pos={420,457},size={50,20},proc=FitFI,title="Fit"
	ValDisplay valdispFIbaseline,pos={340,480},size={100,13},title="Baseline fit"
	ValDisplay valdispFIbaseline,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdispFIbaseline,value= #"root:analysis:system:gFIBaselinefit"
	ValDisplay valdispFIbaseline1,pos={440,480},size={100,13},title="+/-"
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
	
	
	String fldrSav0= GetDataFolder(1)
	SetDataFolder root:analysis:system:
	Display/W=(13,78,688,448)/HOST=#  root:analysis:system:fftsumwave//,FIguessfit,fit_fftsumwave
	SetDataFolder fldrSav0
	Label left "Intensity (a.u.)"
	Label bottom "Field (T)"
	SetAxis bottom 5.19183984523918,5.36536888905755
	Cursor/P A fftsumwave 665;Cursor/P B fftsumwave 550
	RenameWindow #,G0
	SetActiveSubwindow ##
EndMacro

Function CalculateMomentsButton(ctrlname):ButtonControl
	string ctrlname
	
	STRUCT NMRdata expt; Initexpt(expt)	
	
	checkdisplayed/W=$(expt.fftsumintwindow) expt.sysfftsum
	if(v_flag==1)
		duplicate/o expt.sysfftsum, root:analysis:system:moment0wave;initexpt(expt)
	elseif(v_flag==0)
		duplicate/o expt.sysint, root:analysis:system:moment0wave;initexpt(expt)
	endif

	duplicate/o expt.moment0wave, root:analysis:system:moment1wave,root:analysis:system:moment2wave,root:analysis:system:moment3wave;initexpt(expt)

	expt.moment0=area(expt.moment0wave, xcsr(A, expt.fftsumintwindow), xcsr(B, expt.fftsumintwindow))

	expt.moment1wave=expt.moment1wave*x
	expt.moment1=area(expt.moment1wave, xcsr(A, expt.fftsumintwindow), xcsr(B, expt.fftsumintwindow))/expt.moment0

	expt.moment2wave=expt.moment2wave*(x-expt.moment1)^2
	expt.moment3wave=expt.moment3wave*(x-expt.moment1)^3
	
	expt.moment2=area(expt.moment2wave, xcsr(A, expt.fftsumintwindow), xcsr(B, expt.fftsumintwindow))/expt.moment0
	expt.moment3=area(expt.moment3wave, xcsr(A, expt.fftsumintwindow), xcsr(B, expt.fftsumintwindow))/expt.moment0

End

Function SetMomentStorageWaveName(ctrlname):ButtonControl
	string ctrlname
	
	string localstoragewavename
	
	Prompt localstoragewavename, "Enter storage wave name:"
	DoPrompt "Storage Wave Name", localstoragewavename
	
	if(v_flag==1)
		return 0
	endif
	
	SVAR  gmomentstoragewavename=root:analysis:system:gmomentstoragewavename
	
	gmomentstoragewavename="Momnts"+localstoragewavename
	
end

Function StoreMomParameters(ctrlname):ButtonControl
	string ctrlname

	STRUCT NMRdata expt; Initexpt(expt)

	SVAR  gmomentstoragewavename=root:analysis:system:gmomentstoragewavename
	
	if(exists(gmomentstoragewavename)==0)
		make/n=(1,5) $gmomentstoragewavename=nan
	endif	
	
	variable/g gmomentindex, gmomentindexparameter
		
	wave storageref=root:$gmomentstoragewavename
		
	variable initialdimsize=dimsize(storageref,0)
	
	if(gmomentindex+1>dimsize(storageref,0))
		insertpoints dimsize(storageref,0)+1, gmomentindex-dimsize(storageref,0)+1, storageref
		storageref[initialdimsize,dimsize(storageref,0)-1]=nan
	endif
	
	storageref[gmomentindex][0]=gmomentindexparameter
	storageref[gmomentindex][1]=expt.moment0
	storageref[gmomentindex][2]=expt.moment1
	storageref[gmomentindex][3]=expt.moment2
	storageref[gmomentindex][4]=expt.moment3

End	

Function GLGuessControl(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum	// value of variable as number
	String varStr		// value of variable as string
	String varName	// name of variable
	
	STRUCT NMRdata expt;initexpt(expt)
	
	variable initdimsize
	
	checkdisplayed/W=$(expt.fftsumintwindow) expt.sysint
	if(v_flag==1)
		wave displayed=expt.sysint
	elseif(v_flag==0)
		wave displayed=expt.sysfftsum
	endif
	
	if(samestring(varname, "ggaussians")==1)
		initdimsize=dimsize(expt.Gparameters,0)
		make/o/n=(3*expt.gaussians) root:analysis:system:gaussianparameters
		expt.Gindex=expt.gaussians
		wavestats/Q displayed
		if(initdimsize<dimsize(expt.Gparameters,0))
			expt.GA=v_max
			if(expt.fieldsweep==1)
				expt.Gw=.01
			else
				expt.GW=.05
			endif
			expt.Gx=(lastxpoint(displayed)+firstxpoint(displayed))/2
			StoreGLparam(expt)
		else
			LoadGLparam(expt)
		endif
		
	elseif(samestring(varname,"glorentzians")==1)
		initdimsize=dimsize(expt.Lparameters,0)
		make/o/n=(3*expt.Lorentzians) root:analysis:system:Lorentzianparameters
		expt.Lindex=expt.Lorentzians
		wavestats/Q displayed
		if(initdimsize<dimsize(expt.Lparameters,0))
			expt.LA=v_max
			if(expt.fieldsweep==1)
				expt.Lw=.01
			else
				expt.LW=.05
			endif		
			expt.Lx=(lastxpoint(displayed)+firstxpoint(displayed))/2
			StoreGLparam(expt)
			LoadGLparam(expt)
		endif
	elseif(samestring(varname, "glorentzians")==1)
		make/o/n=(3*expt.lorentzians) root:analysis:system:lorentzianparameters
	elseif(samestring(varname,"ggindex")==1 || samestring(varname, "glindex")==1)
		if(expt.gindex>expt.gaussians)
			expt.gindex=expt.gaussians
			return 0
		endif
		
		if(expt.Lindex>expt.Lorentzians)
			expt.Lindex=expt.Lorentzians
			return 0
		endif
		LoadGLparam(expt)
	else
		StoreGLparam(expt)
	endif
	
	CalcFIguessfit(expt)
	
End

Function FitFI(ctrlname):ButtonControl
	string ctrlname
	
	SetDataFolder root:analysis:system:
	
	STRUCT NMRdata expt; initexpt(expt)
	
	make/o/n=(dimsize(expt.gparameters,0)+dimsize(expt.lparameters,0)+1) root:analysis:system:w_coef; initexpt(expt)
	
	expt.w_coef[0]=expt.FIbaseline
	
	if(dimsize(expt.gparameters,0)!=0)
		expt.w_coef[1,dimsize(expt.gparameters,0)]=expt.gparameters[p-1]
	endif
	
	if(expt.lorentzians!=0)
		expt.w_coef[dimsize(expt.gparameters,0)+1, *]=expt.lparameters[p-dimsize(expt.gparameters,0)-1]
	endif
		
	checkdisplayed/W=$(expt.fftsumintwindow) expt.sysint
	if(v_flag==1)
		FuncFit/NTHR=0 FI_fit, expt.W_coef,  expt.sysint[pcsr(A, expt.fftsumintwindow), pcsr(B,expt.fftsumintwindow )]  /D
	elseif(v_flag==0)
		FuncFit/NTHR=0 FI_fit, expt.W_coef,  expt.sysfftsum[pcsr(A, expt.fftsumintwindow), pcsr(B,expt.fftsumintwindow )] /D
	endif

	make/o/n=(3*max(expt.gaussians, expt.lorentzians)+1,4)  root:analysis:system:FIfitparameters
	
	expt.FIfitparameters[0][0]=expt.w_coef[0];expt.FIfitparameters[0][1]=expt.w_sigma[0]
	expt.FIfitparameters[0][2]=expt.gaussians; expt.FIfitparameters[0][3]=expt.lorentzians

	variable i=0
	if(expt.gaussians!=0)
		expt.Gfitindex=1
		do
			i+=1
			expt.FIfitparameters[i][0]=expt.w_coef[p]
			expt.FIfitparameters[i][1]=expt.w_sigma[p]
		while(i/3<expt.gaussians)
	else
		expt.gfitindex=0
	endif
	i=0
	if(expt.lorentzians!=0)
		expt.lfitindex=1
		do
			i+=1
			expt.FIfitparameters[i][2]=expt.w_coef[p+3*expt.gaussians]
			expt.FIfitparameters[i][3]=expt.w_sigma[p+3*expt.gaussians]
		while(i/3<expt.lorentzians)
	else
		expt.lfitindex=0
	endif
	
	DisplayFIFitParameters(expt)	
	
End

Function StoreGLparam(s)
	STRUCT NMRdata &s
	
	s.Gparameters[3*s.gindex-3]=s.gA
	s.Gparameters[3*s.gindex-2]=s.gw
	s.Gparameters[3*s.gindex-1]=s.gx
	
	s.lparameters[3*s.lindex-3]=s.lA
	s.lparameters[3*s.lindex-2]=s.lw
	s.lparameters[3*s.lindex-1]=s.lx
End

Function LoadGLparam(s)
	STRUCT NMRdata &s
	
	if(s.gindex!=0)
		s.gA=s.Gparameters[3*s.gindex-3]
		s.gw=s.Gparameters[3*s.gindex-2]
		s.gx=s.Gparameters[3*s.gindex-1]
	else
		s.GA=0;s.gW=0;s.gx=0
	endif
	
	if(s.lindex!=0)
		s.lA=s.lparameters[3*s.lindex-3]
		s.lw=s.lparameters[3*s.lindex-2]
		s.lx=s.lparameters[3*s.lindex-1]
	else
		s.LA=0;s.Lw=0;s.Lx=0
	endif
	
end

Function CalcFIguessFit(s)
	STRUCT NMRdata &s
	
	make/o/n=10000 root:analysis:system:FIguessfit=0;initexpt(s)
		
	checkdisplayed/W=$(s.fftsumintwindow) s.sysint
	if(v_flag==1)
		wave displayed=s.sysint
	elseif(v_flag==0)
		wave displayed=s.sysfftsum
	endif

	setscale/i x firstxpoint(displayed), lastxpoint(displayed), s.FIguessfit
	
	s.Figuessfit+=s.FIbaseline
	
	variable i=0
		
	if(s.gaussians>0)
		do
			i+=1
			s.FIguessfit+=(s.gparameters[3*i-3]-s.FIbaseline)*exp(-(x-s.gparameters[3*i-1])^2/sqrt(2)/(s.gparameters[3*i-2])^2)
		while(i<s.gaussians)
	endif
	i=0
	
	if(s.lorentzians>0)
		do
			i+=1
			s.Figuessfit+=0
		while(i<s.lorentzians)
	endif
	
End


Function FI_fit(w,x):FitFunc
	wave w
	variable x
	
	STRUCT NMRdata expt; initexpt(expt)
			
	variable FIsum=0, lw,i=1

	if(expt.gaussians!=0)
		do
			FIsum+=(w[3*i-2])*exp(-(x-w[3*i])^2/sqrt(2)/(w[3*i-1])^2)
			//print w[3*i-2], w[3*i], w[3*i-1]
			i+=1
		while(i<expt.gaussians)
	endif
	
	if(expt.lorentzians!=0)
		do
			FIsum+=(w[3*i-3]-w[0])
			i+=1
		while(i<expt.gaussians+expt.lorentzians)
	endif
	
	FIsum+=w[0]
	
	return FIsum
	
end

Function DisplayFIfitparameters(s)
	STRUCT NMRDATa &s
	
	s.FIbaselinefit=s.FIfitparameters[0][0]
	s.FIbaselinefiterror=s.FIfitparameters[0][1]
	
	if(s.gaussians!=0)
		s.GAfit=s.FIfitparameters[3*s.Gfitindex-2][0];	s.GAfiterror=s.FIfitparameters[3*s.Gfitindex-2][1]
		s.Gwfit=s.FIfitparameters[3*s.Gfitindex-1][0];	s.Gwfiterror=s.FIfitparameters[3*s.Gfitindex-1][1]
		s.gxfit=s.FIfitparameters[3*s.Gfitindex-2][0];	s.gxfiterror=s.FIfitparameters[3*s.Gfitindex-2][1]
	else
		s.Gafit=NAN;s.Gafiterror=NAN;s.gWfit=NAN;s.Gwfiterror=NAN;s.Gxfit=NAN;s.gxfiterror=NAN
	endif

	if(s.lorentzians!=0)
		s.LAfit=s.FIfitparameters[3*s.Lfitindex-2][2];	s.LAfiterror=s.FIfitparameters[3*s.Lfitindex-2][3]
		s.Lwfit=s.FIfitparameters[3*s.Lfitindex-1][2];	s.Lwfiterror=s.FIfitparameters[3*s.Lfitindex-1][3]
		s.Lxfit=s.FIfitparameters[3*s.Lfitindex-2][2];	s.Lxfiterror=s.FIfitparameters[3*s.Lfitindex-2][3]
	else
		s.Lafit=NAN;s.Lafiterror=NAN;s.LWfit=NAN;s.Lwfiterror=NAN;s.Lxfit=NAN;s.Lxfiterror=NAN
	endif

End	

Function SetVarFitIndex(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum	// value of variable as number
	String varStr		// value of variable as string
	String varName	// name of variable
	
	STRUCT NMRdata expt; initexpt(expt)
	
	if(samestring(varname,"gGfitindex")==1)
		if(expt.Gfitindex>expt.gaussians)
			expt.gfitindex=expt.gaussians
		elseif(expt.gfitindex==0 && expt.gaussians!=0)
			expt.gfitindex=1	
		endif
	elseif(samestring(varname,"gLfitindex")==1)
		if(expt.Lfitindex>expt.lorentzians)
			expt.Lfitindex=expt.lorentzians
		elseif(expt.lfitindex==0 && expt.lorentzians!=0)
			expt.lfitindex=1
		endif
	endif

	DisplayFIFitParameters(expt)

end


Function SetGLStorageWaveName(ctrlname):ButtonControl
	string ctrlname
	
	string localstoragewavename
	
	Prompt localstoragewavename, "Enter storage wave name:"
	DoPrompt "Storage Wave Name", localstoragewavename
	
	if(v_flag==1)
		return 0
	endif
	
	SVAR gGLstoragewavename=root:analysis:system:gGLstoragewavename
		
	gGLstoragewavename="fit"+localstoragewavename
	
end

Function StoreGLfit(ctrlname):ButtonControl
	string ctrlname
	
	setdatafolder root:
	STRUCT NMRdata expt; Initexpt(expt)

	SVAR gGLstoragewavename=root:analysis:system:gGLstoragewavename
	
	if(exists(gGLstoragewavename)==0)
		make/o/n=(1,dimsize(expt.w_coef,0)*2+3) root:$gGLstoragewavename=nan
	endif	

	NVAR gGLindex=root:analysis:system:gGLindex, gGLparameter=root:analysis:system:gGLparameter
		
	wave storageref=root:$gGLstoragewavename
		
	variable initialdimsize=dimsize(storageref,0)
	
	print gglindex,dimsize(storageref,0)
	if(gGLindex+1>dimsize(storageref,0))
		insertpoints dimsize(storageref,0)+1, gGLindex-dimsize(storageref,0)+1, storageref
		storageref[initialdimsize,dimsize(storageref,0)-1]=nan
	endif
	
	storageref[gGLindex][0]=gGLparameter
	storageref[GGLindex][1]=expt.gaussians
	storageref[gGLindex][2]=expt.lorentzians
	storageref[gGLindex][3]=expt.FIbaselinefit
	storageref[gGLindex][4]=expt.FIbaselinefiterror
	print expt.gaussians
	variable i=0

	do
		storageref[gGLindex][2*i+5]=expt.w_coef[i+1]
		storageref[gGLindex][2*i+6]=expt.w_sigma[i+1]
		i+=1
	while(i<dimsize(expt.w_coef,0)-1)
	
End

Function FFTIntFits(w,x) : FitFunc
	Wave w
	Variable x

	variable/g gFIfitnumber
	
	if(gFIfitnumber==1)
		return w[0]+w[1]*exp(-(x-w[2])^2/sqrt(2)/w[3]^2)
	elseif(gFIfitnumber==2)
		return w[0]+2*w[1]/pi*w[3]/(4*(x-w[2])^2+w[3]^2)
	endif
end