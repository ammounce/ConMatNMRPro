#pragma rtGlobals=1		// Use modern global access method and strict wave access.

//9/15/2015 AMM
// Removed g-variables from SetStats
// Removed g-variables from DataManipulationCheckbox
//9/20/2015 AMM
//Started ConMatNMRProTabControl to make tab controls for the Main Analysis Window

Function ConMatNMRProTabControl(tca) : TabControl
	STRUCT WMTabControlAction &tca

	STRUCT NMRData expt; initexpt(expt)

	print tca.tab, expt.previoustab
	if(tca.tab!=expt.previoustab)
		if(expt.previoustab==0)
			KillWindow ConMatNMRPro#DataTab
		elseif(expt.previoustab==1)
			KillWindow ConMatNMRPro#T1tab
		elseif(expt.previoustab==2)
			Killwindow ConMatNMRPro#FFTIntTab
		endif
				
		if(tca.tab==0)
			DataTabMaster()
		elseif(tca.tab==1)
			T1TabMaster()
		elseif(tca.tab==2)
			FFTIntTabMAster()
		endif	
	endif
	
	expt.previoustab=tca.tab
End

	if(tca.tab!=expt.previoustab)
		if(expt.previoustab==0)
			KillWindow ConMatNMRPro#RawDataTabPanel
		elseif(expt.previoustab==1)
			KillWindow ConMatNMRPro#T1tabPanel
		elseif(expt.previoustab==2)
			Killwindow ConMatNMRPro#FFTIntTabPanel
		endif
		
		if(tca.tab==0)
			RawDataTabPanelMaster()
		elseif(tca.tab==1)
			T1TabMaster()
		elseif(tca.tab==2)
			FFTIntTabMaster()
		endif
	endif
	
	expt.previoustab=tca.tab

end
	//Raw Data Controls
	//Experiment Parameters
	ValDisplay valdispScan1D,disable=(tca.tab!=0)
	ValDisplay valdispgpoints2D,disable=(tca.tab!=0)
	SetVariable setvargsamplerate,disable=(tca.tab!=0)
	SetVariable setvargbuffer,disable=(tca.tab!=0)
	SetVariable setvargw0,disable=(tca.tab!=0)
	SetVariable setvardW,disable=(tca.tab!=0)
	ValDisplay valdispgw,disable=(tca.tab!=0)
	SetVariable setvargH0,disable=(tca.tab!=0)
	SetVariable setvargdH,disable=(tca.tab!=0)
	ValDisplay valdispgH,disable=(tca.tab!=0)

	//Experiment types
	
	CheckBox checkgfieldsweep,disable=(tca.tab!=0)
	CheckBox checkgfrequencysweep,disable=(tca.tab!=0)
	CheckBox checkgT1measure,disable=(tca.tab!=0)
	
	//Current to Field Transofrmations LANL

	SetVariable setvarSystem2I,disable=(tca.tab!=0)
	SetVariable setvargSystem2dI,disable=(tca.tab!=0)
	SetVariable setvarDilFrI,disable=(tca.tab!=0)
	SetVariable setvarDilFrdI,disable=(tca.tab!=0)
	
	//Time Data Manipulation
	
	CheckBox checkgbaseline,disable=(tca.tab!=0)
	ValDisplay valdispayBaselinestart,disable=(tca.tab!=0)
	ValDisplay valdispayBaselineend,disable=(tca.tab!=0)
	Button buttonsetBaseline,disable=(tca.tab!=0)

	CheckBox checkgwindow,disable=(tca.tab!=0)
	ValDisplay valdispayWindowStart,disable=(tca.tab!=0)
	ValDisplay valdispayWindowEnd,disable=(tca.tab!=0)
	Button buttonsetWindow,disable=(tca.tab!=0)
	
	CheckBox checkgfilter,disable=(tca.tab!=0)
	SetVariable setvarfilterfreq,disable=(tca.tab!=0)
	
	CheckBox checkgtphasecorrect,disable=(tca.tab!=0)
	SetVariable setvargtphase,disable=(tca.tab!=0)
	CheckBox checkgscanphase,disable=(tca.tab!=0)
	Button buttonautotphasecorrect,disable=(tca.tab!=0)

	//Frequency Data Manipulation

	CheckBox checkgfphasecorrect,disable=(tca.tab!=0)
	CheckBox checkgautophase1,disable=(tca.tab!=0)
	SetVariable setvargtphase1,disable=(tca.tab!=0)
	SetVariable setvargtphase2,disable=(tca.tab!=0)
	Button buttonautotphasecorrect1,disable=(tca.tab!=0)

	//Integration and FFT

	CheckBox checkgintreal,disable=(tca.tab!=0)
	CheckBox checkgintimag,disable=(tca.tab!=0)
	CheckBox checkgintmag,disable=(tca.tab!=0)
	Button buttonIntimedomain,disable=(tca.tab!=0)
	Button ButtonRevertData,disable=(tca.tab!=0)
	
	CheckBox checkgintreal1,disable=(tca.tab!=0)
	CheckBox checkgintimag1,disable=(tca.tab!=0)
	CheckBox checkgintmag1,disable=(tca.tab!=0)
	Button buttonInfreqdomain,disable=(tca.tab!=0)

	Button buttonFFTsum,disable=(tca.tab!=0)
	SetVariable setvarggryo,disable=(tca.tab!=0)
	Button buttonAutoscaleFFT,disable=(tca.tab!=0)

	////////////////////
	//T1 Controls////////
	////////////////////
	
	//Time wave
	
	SetVariable setvargtstart,disable=(tca.tab!=1)
	SetVariable setvargtend,disable=(tca.tab!=1)
	SetVariable setvargtoffset,disable=(tca.tab!=1)
	Button buttonMaketimewave,disable=(tca.tab!=1)
	
	//Spin for fit
	PopupMenu popupgspin,disable=(tca.tab!=1)
	SetVariable setvargrecoveries,disable=(tca.tab!=1)
	PopupMenu popupgtransition,disable=(tca.tab!=1)
	PopupMenu popupgNQR,disable=(tca.tab!=1)
	CheckBox checkgstretched,disable=(tca.tab!=1)		
	TitleBox titlespin,disable=(tca.tab!=1)
	
	//Guess T1
	SetVariable setvargMguess,disable=(tca.tab!=1)
	SetVariable setvargT1guess,disable=(tca.tab!=1)
	SetVariable setvargMinfM0guess,disable=(tca.tab!=1)
	SetVariable setvargexponentguess,disable=(tca.tab!=1)
	
	Button buttonCursorguess,disable=(tca.tab!=1)
	SetVariable setvargrecoveriesguessindex,disable=(tca.tab!=1)
		
	//FitT1
	
	Button buttonFitT1,disable=(tca.tab!=1)
	SetVariable setvargrecoveriesindex,disable=(tca.tab!=1)
	
	ValDisplay valdispgM,disable=(tca.tab!=1)
	ValDisplay valdispgMerror,disable=(tca.tab!=1)
	
	ValDisplay valdispgT1,disable=(tca.tab!=1)
	ValDisplay valdispgT1error,disable=(tca.tab!=1)

	ValDisplay valdispgtip,disable=(tca.tab!=1)
	ValDisplay valdispgtiperror,disable=(tca.tab!=1)
	
	ValDisplay valdispgexpfit,disable=(tca.tab!=1)
	ValDisplay valdispgexpfiterror,disable=(tca.tab!=1)
	
		//Store Data
//	Button buttonStoragewaveName,disable=(tca.tab!=1)
//	TitleBox title0,disable=(tca.tab!=1)
//	SetVariable setvargindex,disable=(tca.tab!=1)
//	SetVariable setvargindexparameter,disable=(tca.tab!=1)
//	Button buttonStoreData,pos={191,514},disable=(tca.tab!=1)

	
	//Graphs Control
	
	KillWindow ConMAtNMRPro#G0	
	if(expt.previoustab==0)
		KillWindow ConMatNMRPro#G1
	endif
	
	if(tca.tab==0)
		Display/W=(171,146,709,536)/HOST=#  root:analysis:system:Zchan,root:analysis:system:Bchan,root:analysis:system:Achan
		setactivesubwindow #
		ModifyGraph rgb(Zchan)=(0,0,0),rgb(Bchan)=(1,12815,52428)
		Label bottom "Time (us)"
		Cursor/P A Achan 56;Cursor/P B Zchan 210
		RenameWindow #,G0
		SetActiveSubwindow ##
		
		if(expt.previoustab!=0)
			Display/W=(721,146,1220,536)/HOST=#  root:analysis:system:FFTZchan,root:analysis:system:FFTBchan,root:analysis:system:FFTAchan
			ModifyGraph rgb(FFTZchan)=(0,0,0),rgb(FFTBchan)=(1,12815,52428)
			Label bottom "Frequency (MHz)"
			Cursor/P A FFTZchan 496;Cursor/P B FFTZchan 524
			RenameWindow #,G1
			SetActiveSubwindow ##	
		endif
	elseif(tca.tab==1)
		Display/W=(171,146,709,536)/HOST=#  root:analysis:system:M vs root:analysis:system:timewave
		AppendToGraph root:analysis:system:fit_M vs root:analysis:system:timewave
		ModifyGraph mode(M)=3
		ModifyGraph marker(M)=19
		ModifyGraph log(bottom)=1
		Label bottom "Time (s)"
		Label left "M (a.u.)"
		Cursor/P A M 15;Cursor/P B M 7
		RenameWindow #,G0
	elseif(tca.tab==2)
		Display/W=(171,146,709,536)/HOST=# root:analysis:system:fftsumwave//,FIguessfit,fit_fftsumwave
		ModifyGraph log(bottom)=1
		RenameWindow #,G0
	endif

	expt.previoustab=tca.tab

End


	
Function loadspectrum(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum	// which item is currently selected (1-based)
	String popStr		// contents of current popup item as string
	
	SVAR gfilename=root:analysis:system:gfilename
	gfilename=popstr
	
	STRUCT NMRdata expt;Initexpt(expt)
	expt.scanphase=0
	
	loadstats(expt)
//	
	expt.baseline=0; expt.windowdata=0; expt.filter=0; expt.tphasecorrect=0; expt.fphasecorrect=0
	expt.buffer=0

	getbuffer(expt)

	if(waveexists(expt.fftsum)==1 && waveexists(expt.int)==1)
		duplicate/o expt.fftsum, root:analysis:system::fftsumwave
		duplicate/o expt.int, root:analysis:system:integral
		DisplayFFTSum(expt)
	elseif(waveexists(expt.fftsum)==1 && waveexists(expt.int)==0)
		duplicate/o expt.fftsum, root:analysis:system:fftsumwave
		expt.sysInt=nan
		DisplayFFTsum(expt)
	elseif(waveexists(expt.fftsum)==0 && waveexists(expt.int)==1)
		expt.sysfftsum=nan
		duplicate/o expt.int, root:analysis:system:integral
		DisplayIntegral(expt)
	elseif(waveexists(expt.fftsum)==0 && waveexists(expt.int)==0)
		expt.sysfftsum=nan
		expt.sysint=nan
	endif

	if(waveexists(expt.Mwave)==1 && waveexists(expt.twave)==1)
		duplicate/o expt.Mwave, root:analysis:system:m
		duplicate/o expt.twave, root:analysis:system:timewave
	elseif(waveexists(expt.Mwave)==1 && waveexists(expt.twave)==0)
		duplicate/o expt.Mwave, root:analysis:system:M
		expt.syst=x
	elseif(waveexists(expt.Mwave)==0 && waveexists(expt.twave)==1)
		expt.sysM=NAN
		duplicate/o expt.twave, root:analysis:system::timewave
	elseif(waveexists(expt.Mwave)==0 && waveexists(expt.twave)==0)
		expt.sysM=NAN
		expt.syst=NAN
	endif

End
				
Function GetbufferSetVar(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum	// value of variable as number
	String varStr		// value of variable as string
	String varName	// name of variable
	
	STRUCT NMRdata expt; initexpt(expt)
	
	Getbuffer(expt)
	
End

Function Getbuffer(s)
	STRUCT NMRdata &s

	make/o/n=(s.points1D) root:analysis:system:Achan, root:analysis:system:Bchan, root:analysis:system:Zchan, root:analysis:system:FFTAchan, root:analysis:system:FFTBchan, root:analysis:system:FFTZchan
	make/o/c/n=(s.points1D) root:analysis:system:ABchan, root:analysis:system:FFTABchan
	Initexpt(s)
	
	s.H = s.H0+s.dH*s.buffer
	s.w = s.w0+s.dw*s.buffer	

	if(s.buffer>=s.points2D-1)
		s.buffer=s.points2D-1
	endif

	s.Achan= s.data[s.buffer*s.points1D+p][0]
	s.Bchan= s.data[s.buffer*s.points1D+p][1]
		
	Setscale/p x 0, s.samplerate, s.Achan, s.Bchan, s.Zchan
	
	if(s.baselinestart==0 || s.baselineend==0 || s.baselinestart > s.points1D || s.baselineend> s.points1D &&s.baseline!=0)
		print "Bad baseline"
	elseif(s.baseline==1)	
		variable amean=mean(s.Achan,pnt2x(s.Achan,s.baselinestart), pnt2x(s.Achan,s.baselineend))
		variable bmean=mean(s.bchan, pnt2x(s.bchan,s.baselinestart),pnt2x(s.bchan,s.baselineend))

		s.Achan-= amean
		s.Bchan-= bmean
	endif
		
	if(s.windowend == 0 || s.windowstart > s.points1D || s.windowend> s.points1D && s.windowdata!=0)
		print "Bad Window"
	elseif(s.windowdata==1)
		s.Achan[0, s.windowstart]=0
		s.Achan[ s.windowend,*] =0
		
		s.Bchan[0, s.windowstart]=0
		s.Bchan[ s.windowend,*] =0
	endif

	if(s.filter==1)
		make/o/D/n=0 coefs
		filterfir/dim=0/LO={s.filterrange*10^3*s.samplerate/10^6,s.filterrange*10^3*s.samplerate/10^6,s.points1D}/COEF coefs, s.Achan	
		filterfir/dim=0/LO={s.filterrange*10^3*s.samplerate/10^6,s.filterrange*10^3*s.samplerate/10^6,s.points1D}/COEF coefs, s.Bchan
	endif
		
	s.Zchan=sqrt(s.Achan^2+s.Bchan^2)
		
	s.ABchan = s.Achan+ sqrt(-1) *s.Bchan
		
	FFT/dest=root:analysis:system:FFTaBchan s.ABchan

	s.FFTAchan = Real(s.FFTaBchan)
	s.FFTBchan = imag(s.FFTaBchan)	
	
	if(s.scanphase==1)
		s.tphase=s.phasewave[s.buffer]
	endif
	
	
	if(s.tphasecorrect ==1)
		Tphasecorrect(s)
	endif

	if(s.fphasecorrect==1)
		Fphasecorrect(s)
	endif

	s.FFTZchan=sqrt(s.FFTAchan^2+s.FFTBchan^2)
	
	SetScale/P x s.w0+s.buffer*s.dw- 1/(2*s.samplerate)+1/s.samplerate/s.points1D,1/(s.samplerate*s.points1D),s.FFTAchan, s.FFTBchan, s.FFTZchan
	
	//dumpexpt(s)
End

Function Tphasecorrect(s)
	STRUCT NMRdata &s
		
	duplicate/o s.achan, root:analysis:system:phaseachan
	duplicate/o s.bchan, root:analysis:system:phasebchan
	Initexpt(s)

	s.achan= cos(pi/180*s.tphase)*s.phaseachan-sin(pi/180*s.tphase)*s.phasebchan
	s.bchan= sin(pi/180*s.tphase)*s.phaseachan+cos(pi/180*s.tphase)*s.phasebchan
		
End

Function Fphasecorrect(s)
	STRUCT NMRdata &s	
	
	duplicate/o s.FFTachan, root:analysis:system:phaseachan
	duplicate/o s.FFTbchan, root:analysis:system:phasebchan
	Initexpt(s)

	s.FFTachan= cos(pi/180*s.fphase1-s.fphase2*pi/180*(x-s.w0))*s.phaseachan-sin(pi/180*s.fphase1-s.fphase2*pi/180*(x-s.w0))*s.phasebchan
	s.FFTbchan= sin(pi/180*s.fphase1-s.fphase2*pi/180*(x-s.w0))*s.phaseachan+cos(pi/180*s.fphase1-s.fphase2*pi/180*(x-s.w0))*s.phasebchan
End



Function AutoTphasecorrect(ctrlname):ButtonControl
	string ctrlname
	
	STRUCT NMRdata expt; initexpt(expt)

	variable zchanmax, achanmax, i=0
	
	expt.tphase=0
	Getbuffer(expt)
	
	do
		expt.tphase = i
		Tphasecorrect(expt)
		
		wavestats/q expt.zchan
		zchanmax=v_max
		
		wavestats/q expt.achan
		achanmax=v_max
	
		i+=.5
		
		expt.tphase=0
		Getbuffer(expt)


	while(achanmax<.99*zchanmax)

	expt.tphase=i

	if(expt.scanphase==1)
		expt.phasewave[expt.buffer]=i
	endif

	expt.tphasecorrect=1

	Getbuffer(expt)
	
	storestats(expt)
End

Function AutoFphasecorrect(ctrlname):ButtonControl
	string ctrlname

	STRUCT NMRdata expt;initexpt(expt)
	
	variable fftzchanmax, fftachanmax, fftachanarea, fftzchanarea, i=0
	
	expt.fphase1=0
	expt.fphase2=0
	expt.fphasecorrect=1
	Getbuffer(expt)
	
	do
		i+=2
		expt.fphase2=i

		autofphase1correct(expt)
		
		fftachanarea= area(expt.fftachan, xcsr(A, expt.fftwindow), xcsr(B, expt.fftwindow))
		fftzchanarea=area(expt.fftzchan, xcsr(A, expt.fftwindow), xcsr(B, expt.fftwindow))
		
		print i, fftachanarea/fftzchanarea
	while(i<90 && fftachanarea < .85*fftzchanarea)

	print "Refining"
	
	i-=1.1
	
	do
		i+=.2

		expt.fphase2=i
		print i

		autofphase1correct(expt)
		
		fftachanarea= area(expt.fftachan, xcsr(A, expt.fftwindow), xcsr(B, expt.fftwindow))
		fftzchanarea=area(expt.fftzchan, xcsr(A, expt.fftwindow), xcsr(B, expt.fftwindow))
		
		print  expt.fphase2, fftachanarea/ fftzchanarea
		
	while(i<90 && fftachanarea < .94*fftzchanarea)	

	storestats(expt)
End




Function AutoFphase1correct(s)
	STRUCT NMRdata &s	
	
	variable fftzchanmax, fftachanmax,  i=0	
	
	s.fphasecorrect=1	
	s.fphase1=0
	
	Getbuffer(s)
	do
		s.fphase1 = i
		
		Getbuffer(s)

		wavestats/q s.fftzchan
		fftzchanmax=v_max
			
		wavestats/q s.fftachan
		fftachanmax=v_max

		i+=1
		
		s.fphase1=0
		Getbuffer(s)
	while(fftachanmax<.95*fftzchanmax)

	s.fphase1=i

	Getbuffer(s)

End

Function integratedata(ctrlname):ButtonControl
	string ctrlname
	
	STRUCT NMRData expt; initexpt(expt)
	
	variable i=0
	string datawindow
	if(samestring(ctrlname, "buttonIntimedomain")==1)
		datawindow=expt.timewindow
		if(expt.intreal==1)
			wave integralwave = expt.achan
		elseif(expt.intimag==1)
			wave integralwave=expt.bchan
		elseif(expt.intmag==1)
			wave integralwave=expt.zchan
		endif
		
	elseif(samestring(ctrlname, "buttonInfreqdomain")==1)
		datawindow=expt.fftwindow
		if(expt.intreal==1)
			wave integralwave = expt.fftachan
		elseif(expt.intimag==1)
			wave integralwave=expt.fftbchan
		elseif(expt.intmag==1)
			wave integralwave=expt.fftzchan
		endif
	endif
	
	
	if(expt.T1measure==1)
		make/o/n=(expt.points2D) root:analysis:system:timewave,  root:analysis:system:guessfit, root:analysis:system:M
		
		do
			expt.buffer=i
			Getbuffer(expt)
	
			expt.sysM[i]= area(integralwave, xcsr(A, datawindow), xcsr(B,datawindow))
			i+=1
		while(i<expt.points2D)
	
		print integralwave, xcsr(A, datawindow), xcsr(B,datawindow)
	
		STRUCT WMTabControlAction tca; tca.tab=1
		TabControl Tabs, win=ConMatNMRPro, value=1; expt.previoustab=0
		ConMatNMRProTabControl(tca)

		duplicate/o expt.sysM, root:analysis:T1waves:$("M"+expt.filename)
		
	elseif(expt.frequencysweep==1 || expt.fieldsweep==1)
		make/o/n=(expt.points2D) root:analysis:system:integral		
		
		if(expt.frequencysweep==1)
			setscale/p x, expt.w0, expt.dw, expt.sysint
		elseif(expt.fieldsweep==1)
			setscale/p x, expt.H0, expt.dH, expt.sysint
		endif
		
		 i=0
		do
			expt.buffer=i
			Getbuffer(expt)
					
			expt.sysint[i]=area(integralwave, xcsr(A,datawindow), xcsr(B,datawindow))
			i+=1
		while(i<expt.points2D)
		
		DoWindow integralFFTSUMpanel

		if(V_flag ==0)
			Execute "integralFFTSUMpanel()"
		elseif(V_flag ==1)
			DoWindow/F integralFFTSUMpanel
		endif	
		
		DisplayIntegral(expt)
				
		duplicate/o expt.sysint, root:analysis:integral:$("Int"+expt.filename)
		
	endif	
	
	
End


Function FFTsum(ctrlname):ButtonControl
	string ctrlname
	
	STRUCT NMRdata expt;Initexpt(expt)
		
	make/o/n=(expt.points1D) root:analysis:system:fftsumwave;initexpt(expt)
		
	if(expt.frequencysweep==1)
		expt.buffer=0
		Getbuffer(expt)

		SetScale/P x expt.w0-1/(2*expt.samplerate)+1/expt.samplerate/expt.points1D,1/(expt.samplerate*expt.points1D),expt.sysfftsum
		
		expt.sysfftsum=expt.fftzchan
		
		do
			expt.buffer+=1
			Getbuffer(expt)

			insertpoints dimsize(expt.sysfftsum, 0)-1,ceil(expt.dw*(expt.samplerate*expt.points1D)), expt.sysfftsum
			
			expt.sysfftsum[x2pnt(expt.sysfftsum,pnt2x(expt.fftzchan,0))+1, x2pnt(expt.sysfftsum,pnt2x(expt.fftzchan, dimsize(expt.fftzchan,0)))-1]+=expt.fftzchan(x)

		while(expt.buffer<expt.points2D-1)
	
	elseif(expt.fieldsweep==1)
		expt.buffer=0
		getbuffer(expt)	
		make/o/n=(expt.points1D) root:analysis:system:tempfftzchan;initexpt(expt)
		//s.w0+s.buffer*s.dw- 1/(2*s.samplerate)+1/s.samplerate/s.points1D,1/(s.samplerate*s.points1D)
			if(expt.usegyro==1)
				setscale/p x expt.H+1/(2*expt.samplerate)/expt.gyro+1/expt.samplerate/expt.points1D/expt.gyro, -1/(expt.samplerate*expt.points1D*expt.gyro), expt.tempfftzchan //lastxpoint(expt.fftzchan)/expt.gyro,-dimdelta(expt.fftzchan,0)/expt.gyro,expt.tempfftzchan
			elseif(expt.usegyro==0)
				setscale/p x expt.H+1/(2*expt.samplerate)*expt.H/expt.w+1/expt.samplerate/expt.points1D/expt.w*expt.H, -1/(expt.samplerate*expt.points1D)/expt.w*expt.H, expt.tempfftzchan //lastxpoint(expt.fftzchan)/expt.gyro,-dimdelta(expt.fftzchan,0)/expt.gyro,expt.tempfftzchan
			endif
		
		duplicate/o expt.tempfftzchan, root:analysis:system:fftsumwave
		
		variable i
		
		do
			i+=1
			expt.buffer=i
			
			getbuffer(expt)
			expt.tempfftzchan=expt.fftzchan
			
			if(expt.usegyro==1)
				setscale/p x expt.H+1/(2*expt.samplerate)/expt.gyro+1/expt.samplerate/expt.points1D/expt.gyro, -1/(expt.samplerate*expt.points1D*expt.gyro), expt.tempfftzchan //lastxpoint(expt.fftzchan)/expt.gyro,-dimdelta(expt.fftzchan,0)/expt.gyro,expt.tempfftzchan
			elseif(expt.usegyro==0)
				setscale/p x expt.H+1/(2*expt.samplerate)*expt.H/expt.w+1/expt.samplerate/expt.points1D/expt.w*expt.H, -1/(expt.samplerate*expt.points1D)/expt.w*expt.H, expt.tempfftzchan //lastxpoint(expt.fftzchan)/expt.gyro,-dimdelta(expt.fftzchan,0)/expt.gyro,expt.tempfftzchan
			endif

			insertpoints dimsize(expt.sysfftsum,0), ceil(( lastxpoint(expt.tempfftzchan)-lastxpoint(expt.sysfftsum))/dimdelta(expt.sysfftsum,0))+1,expt.sysfftsum
			expt.sysfftsum[x2pnt(expt.sysfftsum,pnt2x(expt.tempfftzchan,0))+1, x2pnt(expt.sysfftsum,pnt2x(expt.tempfftzchan, dimsize(expt.tempfftzchan,0)))-1]+=expt.tempfftzchan(x)	
		while(i<expt.points2D-1)
		
	endif
		
	DoWindow IntegralFFTSUMpanel

	if(V_flag ==0)
		Execute "IntegralFFTSUMpanel()"
	elseif(V_flag ==1)
		DoWindow/F IntegralFFTSUMpanel
	endif	
	
	DisplayFFTsum(expt)	

	
	duplicate/o expt.sysfftsum, root:analysis:fftsums:$("FFTSum"+expt.filename)

End

Function/S FileNameof(theStr)	
	string theStr
	variable index=0,pos
	
	index = strlen(theStr)
	
	do
		//start check at end; remember strings start at 0 for positioning
		pos = strsearch(theStr,":",(index-1))
		if ((pos == -1) & (index == 1))
			doalert 0, "can't find filename from full filename"
			break
		else
			if (pos == -1)
				index -= 1
			else
				break
			endif
		endif
	while(1)
	//don't include colon, remember strlen is 1 more than last position value
	return(theStr[pos+1,strlen(theStr)-1])	
End


//Similar to Filenameof however this function extracts the path from the full path/filename

Function/S PathNameof(theStr)	
	string theStr
	variable index=0,pos

	index = strlen(theStr)
	do
		pos = strsearch(theStr,":",(index-1))	//start check at end; remember strings start at 0 for positioning
		if ((pos == -1) & (index == 1))
			doalert 0, "can't find pathname from full filename"
			break
		else
			if (pos == -1)
				index -= 1
			else
				break
			endif
		endif
	while(1)
	return(theStr[0,pos])

End




Function SetDataManipulationButton(ctrlname):ButtonControl
	string ctrlname

	//Controls "Set Baseline", "Set Window", and "Revert Data" buttons on main panel
	//If "Set Baseline" is clicked baselinestart and baseline end are set to cursor A and B in time window and the 
	//baseline indicator is set to one
	//"Set Window" works the same as "Set Baseline"
	//"Revert Data" will set the analysis indicators to 0 but retain the baselinestart,"end, ect
	// After changing the parameters, the buffers are updated with the new settings

	STRUCT NMRdata expt; initexpt(expt)
	
	if(samestring(ctrlname, "ButtonsetBaseline")==1)
		expt.baselinestart=pcsr(A, expt.timewindow)
		expt.baselineend=pcsr(B, expt.timewindow)
		expt.baseline=1
	elseif(samestring(ctrlname, "ButtonSetWindow")==1)
		expt.windowstart=pcsr(A, expt.timewindow)
		expt.windowend=pcsr(B, expt.timewindow)
		expt.windowdata=1
	elseif(samestring(ctrlname, "ButtonRevertData")==1)
		expt.windowdata=0
		expt.baseline=0
		expt.tphasecorrect=0
		expt.fphasecorrect=0
		expt.filter=0
	endif
	
	Getbuffer(expt)

End


Function SetStat(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum	// value of variable as number
	String varStr		// value of variable as string
	String varName	// name of variable

	//SetStat conrols variables on the main panel and performs additional functions depending on the variable set
	//gtphase: sets tphasecorrect indicator to 1, updates phase wave if individual phasing is engaged and the phases the data
	//gfphase1: removes auotphase1, sets gfphasecorrect indicator to 1, then rephases data to gfphase1 (the constant phase)
	//gfphase2: sets gfphasecorrect indicator to 1, then refphases data to gfphase2 (linear phase)
	//gfilterrange: Filters data at set kHz and sets gfilter indicator to 1
	//ggryo: sets gusegyro indicator to 1 to FFTSUM fieldsweeps using the gyromagnetic ratio rather than frequency/field ratio
	//gH0 or gdH: will change gH to indicate the field of current scan
	//gw0 or gdw: will change gw to indicate the frequency of current scan
	//after the appropriate variable is chosen by the if tree, the new stats are stored in the stats wave

	STRUCT NMRdata expt; Initexpt(expt)
	
	variable fphase1, fphase2
		
	if(samestring(varname, "gtphase")==1)
		expt.tphasecorrect=1
		expt.tphase=0
		Getbuffer(expt)
		expt.tphase=varnum
		if(expt.scanphase==1)
			expt.phasewave[expt.buffer]=expt.tphase
		endif
		
		Getbuffer(expt)	
	elseif(samestring(varname, "gfphase1")==1)
			expt.autophase1=0
			expt.fphasecorrect=1
			expt.fphase1=0
			expt.fphase2=0
			Getbuffer(expt)
			expt.fphase1=varnum
			expt.fphase2=fphase2
			Getbuffer(expt)	
	elseif(samestring(varname, "gfphase2")==1)
		if(expt.autophase1==0)
			expt.fphasecorrect=1
			expt.fphase1=0
			expt.fphase2=0
			Getbuffer(expt)
			expt.fphase1=fphase1
			expt.fphase2=varnum	
			getbuffer(expt)
		elseif(expt.autophase1==1)
			AutoFphase1correct(expt)
		endif
	elseif(samestring(varname, "gfilterrange")==1)
		expt.filter=1
		getbuffer(expt)
	elseif(samestring(varname, "ggyro")==1)
		expt.usegyro=1
	elseif(samestring(varname, "gH0")==1||samestring(varname, "gdH")==1)
		expt.H=expt.H0+expt.dH*expt.buffer
	elseif(samestring(varname, "gw0")==1||samestring(varname, "gdw")==1)
		expt.w=expt.w0+expt.dw*expt.buffer
	endif
	
	Storestats(expt)

END


Function DataManipulationCheckbox(ctrlname, checked): CheckBoxControl
	string ctrlname
	variable checked

	//DataMainuplationCheckbox will provide additional settings when g-variable check boxes are check or unchecked on the main panel
	//gtphasecorrect: if checked, rephase data, if unchecked unphases data
	//gfphasecorrect: if checked and autophase1 is off, rephase fft; if checked and autofphase1 is on, autophases fphase1 for indicated fphase2
	//     if unchecked: autophase1 indicator is turned off, and the fft is unphased
	//gautophase1: if checked turns on fautophasecorrect indicator then auto phase corrects gfphase1 for the selected gfphase2
	//gintreal, gintimag, gintmag: Mutually exclusive checkboxes, if one is selected, all others are de-selected.  If one is selected, a different one is selected.
	//gfieldsweep, gfrequencysweep, gt1measure: mutually exclusive similar to above
	//Stats are stored in statswave after if tree
	
	STRUCT NMRdata expt; initexpt(expt)
	
	variable tphase, fphase1, fphase2
	
	if(samestring(ctrlname, "checkgtphasecorrect")==1)
		if(checked==1)
			tphase=expt.tphase
			expt.tphase=0
			Getbuffer(expt)
			expt.tphase=tphase
			Getbuffer(expt)	
		elseif(checked==0)
			tphase=expt.tphase
			expt.tphase=0
			Getbuffer(expt)
			expt.tphase=tphase
		endif
	elseif(samestring(ctrlname,"checkgfphasecorrect")==1)
		if(checked==1 && expt.autophase1==0)
			fphase1=expt.fphase1;expt.fphase1=0
			fphase2=expt.fphase2;expt.fphase2=0
			Getbuffer(expt)
			expt.fphase1=fphase1
			expt.fphase2=fphase2
			getbuffer(expt)
		elseif(checked==1 && expt.autophase1==1)
			AutoFphase1correct(expt)
		elseif(checked==0 )
			fphase1=expt.fphase1
			fphase2=expt.fphase2
			expt.autophase1=0
			expt.fphase1=0
			expt.fphase2=0
			Getbuffer(expt)
			expt.fphase1=fphase1
			expt.fphase2=fphase2
		endif
	elseif(samestring(ctrlname, "checkgautophase1")==1)
		expt.fphasecorrect=1
		AutoFphase1correct(expt)	
	elseif(samestring(ctrlname, "checkgintreal")==1)
		if(checked==1)
			expt.intimag=0
			expt.intmag=0
		elseif(checked==0)
			expt.intmag=1
		endif
	elseif(samestring(ctrlname, "checkgintimag")==1)
		if(checked==1)
			expt.intreal=0
			expt.intmag=0
		elseif(checked==0)
			expt.intreal=1
		endif
	elseif(samestring(ctrlname, "checkgintmag")==1)
		if(checked==1)
			expt.intreal=0
			expt.intimag=0
		elseif(checked==0)
			expt.intreal=1
		endif
	elseif(samestring(ctrlname, "checkgfrequencysweep")==1)
		if(checked==1)
			expt.fieldsweep=0
			expt.T1measure=0
		elseif(checked==0)
			expt.fieldsweep=1
			expt.T1measure=0
		endif
	elseif(samestring(ctrlname, "checkgfieldsweep")==1)
		if(checked==1)
			expt.frequencysweep=0
			expt.T1measure=0		
		elseif(checked==0)
			expt.frequencysweep=1
			expt.T1measure=0		
		endif
	elseif(samestring(ctrlname, "checkgT1measure")==1)
		if(checked==1)
			expt.frequencysweep=0
			expt.fieldsweep=0		
		elseif(checked==0)
			expt.frequencysweep=1
			expt.fieldsweep=0		
		endif	
	else
		Getbuffer(expt)
	endif	

	storestats(expt)
	
END

Function AutoScaleButton(ctrlname):ButtonControl
	string ctrlname
	
	//AutoScalebutton Can be applied to multiple panels and will auto scale axes of target window because using ctrl-A doesn't seem to work on subwindows
	//buttonAutoscaleFFT: autoscales FFT window
	
	STRUCT NMRdata expt; initexpt(expt)
	
	if(samestring(ctrlname, "buttonAutoscaleFFT")==1)
		SetAxis/A/W=$(expt.fftwindow) bottom
	elseif(samestring(ctrlname,"buttonAutoscaleFFTSum")==1)
		setaxis/A/W=$(expt.fftsumintwindow) bottom
	Endif
End


Function KillCurrentData(ctrlname):ButtonControl
	string ctrlname
	
	STRUCT NMRdata expt; Initexpt(expt)
	
	//KillCurrentData button
	//First prompts user to indicate if they indeed want to kill the raw data wave and all associated waves
	//Kills all data wave associated with expt.filename suppressing errors if no such wave exists
			
	string killdata
	Prompt killdata, "Kill current data?", popup "Yes;No"
	DoPrompt "Kill data? " + expt.filename, killdata
	
	if (V_Flag || strlen(killdata)==2)
		return -1								// User canceled
	endif

	Killwaves/Z  root:$(expt.filename), root:analysis:fftsums:$("fftsum"+expt.filename), root:analysis:integral:$("Int"+expt.filename)
	Killwaves/Z  root:analysis:T1waves:$("M"+expt.filename), root:analysis:timewaves:$("t"+expt.filename)
	Killwaves/Z  root:analysis:statwaves:$("Stats"+expt.filename)
	
End


Function CurrentConversion(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum	// value of variable as number
	String varStr		// value of variable as string
	String varName	// name of variable
	
	//Variable controls specific to LANL which convert the magnet currents for system 2 and the dilution refridgerator to the field variables
	// then stores the field values in the stats wave
	
	STRUCT NMRdata expt; initexpt(expt)	
	NVAR gsystem2i=root:gsystem2i, gsystem2di=root:gsystem2di, gdilfri=root:gdilfri, gdilfrdi=root:gdilfridi
	
	if(samestring(varname, "gsystem2i")==1)
		expt.H0=varnum*.11425
	elseif(samestring(varname, "gsystem2di")==1)
		expt.dH=varnum*.11425
	elseif(samestring(varname, "gdilfri")==1)
		expt.H0=varnum*.12037
	elseif(samestring(varname, "gdilfrdi")==1)
		expt.dH=varnum*.12037
	endif
	
	expt.H=expt.H0+expt.dH*expt.buffer
	
	storestats(expt)
End



Function LoadFile(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum	// which item is currently selected (1-based)
	String popStr		// contents of current popup item as string
	
	//Pop up control on the main panel which will call the correct function in LoadWaves procedure file
	//Tecmag (.tnt) loads a typical 2D tecmag file
	//Tecmag Field Sweep (.txt folder) loads the field sweep text files produced by the LANL field sweep script and labview combination
	//Magres2000 (.mr2) loads .mr2 files (may not work properly as of 9/16/2015)

	if(samestring(popstr, "Tecmag (.tnt)")==1)
		LoadTecmag()
	elseif(samestring(popstr, "Tecmag Field Sweep (.txt folder)")==1)
		LoadTextFolder()
	elseif(samestring(popstr, "Magres2000 (.mr2)")==1)
		LoadMr2()
	endif
	
end




Function Renamecurrentwave(ctrlname):ButtonControl
	string ctrlname
	
	//Prompts user to provide a new name for the currently selected data set
	//then proceeds to inspect each storage data wave and renames if it exists
	
	STRUCT NMRdata expt; initexpt(expt)	
	string newname
	
	Prompt newname, "New wave name:"
	DoPrompt "Rename " + expt.filename, newname
	
	if (V_Flag)
		return -1								// User canceled
	endif
	
	rename expt.data, $newname

	rename expt.statwave, $("stats"+newname)
	
	if(waveexists(expt.Mwave)==1)
		rename expt.Mwave,  $("M"+newname)
	endif
	
	if(waveexists(expt.twave)==1)
		rename expt.twave, $("t"+newname)
	endif
		
	if(waveexists(expt.fftsum)==1)
		rename expt.fftsum, $("FFTSum"+newname)
	endif
	
	if(waveexists(expt.int)==1)
		rename expt.int, $("Int"+newname)
	endif
	
	expt.filename=newname
	
	loadspectrum("",0, expt.filename)
End


// As of 9/16/2015 is not correctly programmed

//Function Appendpopup (ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum	// which item is currently selected (1-based)
	String popStr		// contents of current popup item as string
	
	string/g gfilename, gwavelist
	string choosewave, secondfilename

	variable/g gfrequencysweep, gfieldsweep
	variable firstfilename
	
	wave firstfileref=$gfilename
	wave firststatwaveref=$("Stats"+gfilename)
	
	gwavelist=ListofwavesinFolder()
	
	if(Samestring(popstr, "From Memory")==1 && Samestring(ctrlname, "popupAppendfilebefore")==1)
		Prompt choosewave, "Choose wave to append before current wave", popup, gwavelist
		DoPrompt "Choose wave", choosewave
		
		if(v_flag==1)
			return 0
		endif
		
		wave secondfileref=$choosewave
		wave secondstatwaveref=$("Stats"+choosewave)
		insertpoints 0, dimsize($choosewave,0), firstfileref
		
		firstfileref[0, dimsize($choosewave,0)-1]=secondfileref
		
		firststatwaveref[1]+=secondstatwaveref[1]
		if(gfrequencysweep==1)
			firststatwaveref[3]=secondstatwaveref[3]
		elseif(gfieldsweep==1)
			firststatwaveref[5]=secondstatwaveref[5]
		endif		
		//Getbuffer("", 1, "", "")
	elseif(Samestring(popstr, "From Memory")==1 && Samestring(ctrlname, "popupAppendfileafter")==1)
		Prompt choosewave, "Choose wave to append before current wave", popup, gwavelist
		DoPrompt "Choose wave", choosewave
		
		if(v_flag==1)
			return 0
		endif
		
		wave secondfileref=$choosewave
		wave secondstatwaveref=$("Stats"+choosewave)
	
		insertpoints lastpoint(firstfileref), dimsize(secondfileref,0), firstfileref
		firstfileref[dimsize(firstfileref,0)-dimsize(secondfileref,0)-1, lastpoint(firstfileref)]=secondfileref
		
		firststatwaveref[1]+=secondstatwaveref[1]
		//Getbuffer("", 1, "", "")
	endif	

//End

Function ScanPhasecheckbox(ctrlname, checked): CheckBoxControl
	string ctrlname
	variable checked
	
	//An unimplimented checkbox to individully phase each scan
	//A function to phase each scan individually (needs work)
	// sets tphasecorrect to 1 and makes a wave to sore the individual phases
	
	STRUCT NMRdata expt; initexpt(expt)
	
	if(expt.scanphase==1)
		expt.tphasecorrect=1
		make/o/n=(expt.points2D) root:analysis:phase:$("Phase"+expt.filename);initexpt(expt)
	endif
	
	
	
End	

Function SignaltoNoiseButton(ctrlname):ButtonControl
	string ctrlname
	
	//An unimplimented button to calculate the signal to noise of the time domain
	//Calculates the stats between cursor A and B on time window of Zchan
	
	STRUCT NMRdata expt; initexpt(expt)
	
	wavestats/q/r=(xcsr(A, expt.timewindow), xcsr(B,expt.timewindow)) expt.zchan
	
	print v_max, mean(expt.zchan, v_maxloc*.99, v_maxloc*1.01)
	expt.StoN=mean(expt.zchan, v_maxloc*.99, v_maxloc*1.01)/mean(expt.zchan, lastxpoint(expt.zchan), lastxpoint(expt.zchan)*.9)
	print expt.StoN
end	