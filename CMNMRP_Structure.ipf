#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 0.3

//This procedure file contains the Structure format and initialization function which is called by all other procedures

// 9/20/2015 AMM
// Added previoustab to better control graph windows in tabs

Structure NMRdata
	
	//Data variables
	NVAR  w0, dw,w, H0, dH,H, samplerate,points1D, points2D, fieldsweep, frequencysweep, T1measure
	//Analysis NVARs
	NVAR buffer, baselinestart, baselineend, windowstart, windowend, windowdata, baseline, filter, filterrange, tphase, tphasecorrect
	NVAR fphase1, fphase2, fphasecorrect, autophase1, scanphase, intreal, intimag,intmag, index, indexparameter, usegyro, gyro
	NVAR StoN
	//T1 NVARs
	 NVAR spin, transition, transitionlower, NQR, Mguess, M, Merror,  T1guess, T1, T1error,  tipguess, tip, tiperror,  stretchguess, stretchfit, stretchfiterror, stretched, tstart, tend, toffset
	NVAR recoveries, recoveriesindex, recoveriesguessindex, T1type
	 NVAR t1index, t1indexparameter
	 SVAR t1storagename
	 
	//FFTsum and Integral fit
	NVAR FIfitnumber, moment0, moment1, moment2, moment3
	NVAR gaussians, lorentzians, GA, LA, Gw, Lw, Gx, Lx, FIbaseline, Gindex, Lindex
	NVAR GAfit, LAfit, Gwfit, Lwfit, Gxfit, Lxfit, Gfitindex, Lfitindex
	NVAR GAfiterror, LAfiterror, Gwfiterror, Lwfiterror, gxfiterror, Lxfiterror
	NVAR FIbaselinefit, FIbaselinefiterror
	
	//Time table
	NVAR tpoints, tdecimal, ttecmag, tmapping
	wave/t texttwave
	
	//General Variables
	NVAR previoustab
	
	string FIfitname
	SVAR filename, statwavename, nqrstring
	string fftwindow, timewindow, fftsumintwindow, t1window
	
	//Loadfile waves
	wave tempmr2_0, tempmr2_1
	
	wave data, statwave,rawdata, phasewave//, Mwave, t, fftsum, integral
	wave ACHAN, BCHAN, ZCHAN, FFTACHAN, FFTBCHAN, FFTZCHAN, phaseACHAN, phaseBCHAN
	wave/c  ABCHAN, FFTABCHAN
	//Analysis waves
	wave fftsum, int, Mwave, twave, tempfftzchan
	//System analysis waves
	wave sysint, sysFFTsum, sysM, syst
	//T1waves
	wave W_coef, W_sigma, fit_m, guessfit, t1fitdata, t1storage, t1guesswave, t1fitwave
	//FFTsum and Integral fit
	wave moment0wave, moment1wave, moment2wave, moment3wave
	wave Gparameters, Lparameters, FIguessfit, fit_FI, FIfitparameters
	
	wave/t variablenames

Endstructure

Function InitExpt(s)
	STRUCT NMRdata &s
	
	SVAR s.filename=root:analysis:system:gfilename
	
	//Datavariables
	NVAR s.w0=root:analysis:system:gw0
	NVAR s.dw=root:analysis:system:gdw
	NVAR s.w=root:analysis:system:gw
	NVAR s.H0=root:analysis:system:gH0
	NVAR s.dH=root:analysis:system:gdH
	NVAR s.H=root:analysis:system:gH
	NVAR s.samplerate=root:analysis:system:gsamplerate
	//NVAR s.datapoints=root:analysis:system:gdatapoints
	NVAR s.points1D=root:analysis:system:gpoints1D
	NVAR s.points2D=root:analysis:system:gpoints2D
	NVAR s.fieldsweep=root:analysis:system:gfieldsweep
	NVAR s.frequencysweep=root:analysis:system:gfrequencysweep
	NVAR s.T1measure=root:analysis:system:gT1measure
	NVAR s.StoN=root:analysis:system:gStoN
	
	//Analysis variables
	NVAR s.buffer=root:analysis:system:gbuffer
	NVAR s.baselinestart=root:analysis:system:gbaselinestart
	NVAR s.baselineend=root:analysis:system:gbaselineend
	NVAR s.windowstart=root:analysis:system:gwindowstart
	NVAR s.windowend=root:analysis:system:gwindowend
	NVAR s.baseline=root:analysis:system:gbaseline
	NVAR s.windowdata=root:analysis:system:gwindow
	NVAR s.filter=root:analysis:system:gfilter
	NVAR s.filterrange=root:analysis:system:gfilterrange
	NVAR s.tphase=root:analysis:system:gtphase
	NVAR s.tphasecorrect=root:analysis:system:gtphasecorrect
	NVAR s.fphase1=root:analysis:system:gfphase1
	NVAR s.fphase2=root:analysis:system:gfphase2
	NVAR s.fphasecorrect=root:analysis:system:gfphasecorrect
	NVAR s.autophase1=root:analysis:system:gautophase1
	NVAR s.scanphase=root:analysis:system:gscanphase
	NVAR s.intreal=root:analysis:system:gintreal
	NVAR s.intimag=root:analysis:system:gintimag
	NVAR s.intmag=root:analysis:system:gintmag
	NVAR s.index=root:analysis:system:gindex
	NVAR s.indexparameter=root:analysis:system:gindexparameter
	NVAR s.usegyro=root:analysis:system:gusegyro
	NVAR s.gyro=root:analysis:system:ggyro
	
	//T1variables
	NVAR s.spin=root:analysis:system:gspin
	NVAR s.transition=root:analysis:system:gtransition
	NVAR s.transitionlower=root:analysis:system:gtransitionlower
	NVAR s.NQR=root:analysis:system:gNQR
	NVAR s.Mguess=root:analysis:system:gMguess
	NVAR s.M=root:analysis:system:gM
	NVAR s.Merror=root:analysis:system:gMerror
	NVAR s.T1guess=root:analysis:system:gT1guess
	NVAR s.T1=root:analysis:system:gT1
	NVAR s.T1error=root:analysis:system:gT1error
	NVAR s.tipguess=root:analysis:system:gtipguess
	NVAR s.tip=root:analysis:system:gtip
	NVAR s.tiperror=root:analysis:system:gtiperror
	NVAR s.stretched=root:analysis:system:gstretch
	NVAR s.stretchguess=root:analysis:system:gstretchguess
	NVAR s.stretchfit=root:analysis:system:gstretchfit
	NVAR s.stretchfiterror=root:analysis:system:gstretchfiterror
	NVAR s.tstart=root:analysis:system:gtstart
	NVAR s.tend=root:analysis:system:gtend
	NVAR s.toffset=root:analysis:system:gtoffset
	NVAR s.t1index=root:analysis:system:gt1index
	NVAR s.t1indexparameter=root:analysis:system:gt1indexparameter
	NVAR s.T1type=root:analysis:system:gT1type
	NVAR s.recoveries=root:analysis:system:grecoveries
	NVAR s.recoveriesindex=root:analysis:system:grecoveriesindex
	NVAR s.recoveriesguessindex=root:analysis:system:grecoveriesguessindex

	//FFTSum and Int
	//NVAR gFIfitnumber, blguess, Aguess, x0guess, wguess
	 NVAR s.moment0=root:analysis:system:gmoment0
	 NVAR s.moment1=root:analysis:system:gmoment1
	 NVAR s.moment2=root:analysis:system:gmoment2
	 NVAR s.moment3=root:analysis:system:gmoment3
	 
	 NVAR s.gaussians=root:analysis:system:ggaussians
	 NVAR s.GA=root:analysis:system:gGa , s.GAfit=root:analysis:system:gGAfit, s.GAfiterror=root:analysis:system:gGAfiterror
	 NVAR s.Gw=root:analysis:system:gGw, s.Gwfit=root:analysis:system:gGwfit, s.Gwfiterror=root:analysis:system:gGwfiterror
	 NVAR s.Gx=root:analysis:system:gGx, s.Gxfit=root:analysis:system:gGxfit, s.gxfiterror=root:analysis:system:gGxfiterror
	 NVAR s.Gindex=root:analysis:system:gGindex, s.gfitindex=root:analysis:system:gGfitindex
	 NVAR s.lorentzians=root:analysis:system:glorentzians
	 NVAR s.LA=root:analysis:system:gLA, s.LAfit=root:analysis:system:gLAfit, s.LAfiterror=root:analysis:system:gLAfiterror
	 NVAR s.Lw=root:analysis:system:gLw, s.Lwfit=root:analysis:system:gLWfit, s.Lwfiterror=root:analysis:system:gLwfiterror
	 NVAR s.Lx=root:analysis:system:gLx, s.Lxfit=root:analysis:system:gLxfit, s.Lxfiterror=root:analysis:system:gLXfiterror
	 NVAR s.Lindex=root:analysis:system:gLindex, s.Lfitindex=root:analysis:system:gLfitindex
	 NVAR s.FIbaseline=root:analysis:system:gFIBaseline, s.FIbaselinefit=root:analysis:system:gFIbaselinefit, s.FIBaselinefiterror=root:analysis:system:gFIBaselinefiterror

	//Time table
	NVAR s.tpoints=root:analysis:system:gtpoints
	NVAR s.tdecimal=root:analysis:system:gtdecimal
	NVAR s.ttecmag=root:analysis:system:gttecmag
	NVAR s.tmapping=root:analysis:system:gtmapping
	wave/t s.texttwave=root:analysis:system:texttwave

	//GeneralVariables
	NVAR s.previoustab=root:analysis:system:gprevioustab


	//string/g gFIfitname
	SVAR s.nqrstring=root:analysis:system:gnqrstring
	
	 SVAR s.t1storagename=root:analysis:system:gt1storagename
	 wave s.t1storage=root:$(s.t1storagename)

	
	wave s.data=root:$s.filename
	wave s.statwave=root:analysis:statwaves:$("Stats"+s.filename)	

	s.timewindow="NMRAnalysis#G0"
	s.fftwindow="NMRAnalysis#G1"
	s.fftsumintwindow="IntegralFFTSumPanel#G0"
	s.t1window="T1panel#G0"
	
	wave s.tempmr2_0=root:analysis:system:tempmr2_0
	wave s.tempmr2_1=root:analysis:system:tempmr2_1
	
	wave s.ACHAN=root:analysis:system:Achan
	wave s.Bchan=root:analysis:system:Bchan
	wave s.Zchan=root:analysis:system:Zchan
	wave s.FFTAchan=root:analysis:system:FFTAchan
	wave s.FFTBchan=root:analysis:system:FFTBchan
	wave s.FFTZchan=root:analysis:system:FFTZchan
	wave s.phaseACHAN=root:analysis:system:phaseACHAN
	wave s.phaseBCHAN=root:analysis:system:phaseBCHAN
	wave/c s.ABchan=root:analysis:system:ABchan
	wave/c s.FFTABchan=root:analysis:system:FFTABchan
	
	wave s.fftsum=root:analysis:fftsums:$("FFTsum"+s.filename)
	wave s.int=root:analysis:integral:$("Int"+s.filename)
	wave s.Mwave=root:analysis:T1waves:$("M"+s.filename)
	wave s.twave=root:analysis:timewaves:$("t"+s.filename)
	wave s.t1fitdata=root:analysis:fits:$("T1fit"+s.filename)
	wave s.t1guesswave=root:analysis:system:t1guesswave
	wave s.t1fitwave=root:analysis:fits:$("T1fit"+s.filename)
	wave s.phasewave=root:analysis:phase:$("Phase"+s.filename)
	
	wave s.sysfftsum=root:analysis:system:$("FFTsumwave")
	wave s.sysInt=root:analysis:system:$("Integral")
	wave s.sysM=root:analysis:system:$("M")
	wave s.syst=root:analysis:system:timewave
	wave s.tempfftzchan=root:analysis:system:tempfftzchan
	
	wave s.w_coef=root:analysis:system:w_coef
	wave s.w_sigma=root:analysis:system:w_sigma
	wave s.fit_m=root:analysis:system:fit_M
	wave s.guessfit=root:analysis:system:guessfit
	
	wave s.moment0wave=root:analysis:system:moment0wave
	wave s.moment1wave=root:analysis:system:moment1wave
	wave s.moment2wave=root:analysis:system:moment2wave
	wave s.moment3wave=root:analysis:system:moment3wave
	
	wave s.gparameters=root:analysis:system:gaussianparameters
	wave s.lparameters=root:analysis:system:lorentzianparameters
	wave s.FIguessfit=root:analysis:system:FIguessfit
	wave s.fit_FI=root:analysis:systemfit_FI
	wave s.FIfitparameters=root:analysis:system:FIfitparameters
	
	wave/t s.variablenames=root:analysis:system:variablenames
	
End

Function Structtest()
	STRUCT NMRdata s; initexpt(s)
	
	//print (s.variablenames[0])
	
end