#pragma rtGlobals=1		// Use modern global access method and strict wave access.

Function LoadTecMag()		//need macro to interface; function speeds things up

	STRUCT NMRdata expt; initexpt(expt)

	String pathName,fileName, pathstring, curfolder = GetDataFolder(1)
	variable filerefnum
	
	PauseUpdate; Silent 1
	SetDataFolder "Root:"
	
	open/d/r/t="????" filerefnum			//allows user to find file and puts name into global var 'S_fileName'; doesn't open file
	fileName = FileNameof(S_fileName)
	pathstring = PathNameof(S_fileName)	//this pathname is in text form; we must give it an igor symbolic name because	
	NewPath/O temporaryPath, pathstring	//that is how all other functions are run, i.e. with '$' sign preceeding pathname.
	pathName = "temporaryPath"		//*you must also do this--literal strings in a function call do not get passed
										//when using 'execute' (which will be used later in code).  what a pain.	
	expt.filename=removeending(filename,".tnt")
	
	readtechmagfile(pathname, filename, expt)

	DetectExpttype(expt)

	loadspectrum("", 0, expt.filename)
	
End

Function readtechmagfile(pathname,filename, s)
	string pathname,filename
	STRUCT NMRdata &s

	variable i=0
	variable frefnum, datapoints
			
	make/o/n=21 root:analysis:statwaves:$("Stats"+s.filename)
	wave s.statwave=root:analysis:statwaves:$("Stats"+s.filename)
	s.statwave=NAN
	open/P=$pathname/r/t="BINA" frefnum as filename
	
	fsetpos frefnum, 20					//From techmag manual for data format
	fbinread/F=3 frefnum, s.points1D         
	
	fsetpos frefnum, 24
	fbinread/F=3  frefnum, s.points2D

//	fsetpos frefnum, 28
//	fbinread/F=3 frefnum, scans3D
	
	fsetpos frefnum, 1052
	fbinread/F=3 frefnum, datapoints
	
//	fsetpos frefnum, 20+76
//	fbinread/f=5 frefnum, field
	
	fsetpos frefnum, 20+76+8
	fbinread/f=5 frefnum, s.w0

	fsetpos frefnum, 20+76+164+32
	fbinread/f=5 frefnum, s.samplerate
	//print "Sample rate =  " + num2str(samplerate) + "s"
	s.samplerate*=10^6

	variable data
	i=0
	make/o/n=(s.points1D*s.points2D,2) root:$s.filename
	wave s.data=root:$s.filename
	
	do
		fsetpos frefnum, 1056+i*8
		fbinread/f=4 frefnum, data
		s.data[i][0]=data
		i+=1
	while(i<s.points1D*s.points2D)
	i=0
	
	do
		fsetpos frefnum, 1060+i*8
		fbinread/f=4 frefnum, data
		s.data[i][1]=data
		i+=1
	while(i<s.points1D*s.points2D)
	close frefnum	

End


Function LoadTextFolder()			

	STRUCT nmrdata expt; initexpt(expt)
	
	setdatafolder root:
	
	string pathName, filename, gbasename
	variable i=0
		
	if (Exists("temporaryPath"))
		KillPath temporaryPath
	endif
	NewPath/O temporaryPath
	pathName = "temporaryPath"

	do
		filename = Indexedfile($pathname, i, ".txt")
			if(strlen(filename)==0)
				if(i<99)
					filename = Indexedfile($pathname, i-1, ".txt")
					//gfilename =  removeending(filename, "_"+num2istr(9)+".txt" )
				else
					filename = Indexedfile($pathname, i-1, ".txt")
					//gfilename =  removeending(filename, "_"+num2istr(99)+".txt" )
				endif
				break
			endif
		Loadwave/q/n=$filename/o/M/G/P=$pathname filename
		if(strsearch(filename, "_0.txt",0)!=-1)
			expt.filename=removeending(filename , "_0.txt")
		endif
		i+=1
	while(1)
	initexpt(expt)	
	Addtextwaves(expt)
	
End 


Function Addtextwaves( s)
	STRUCT NMRdata &s
	
	string wname = s.filename+"_0.txt0"
	wave wave0= root:$wname
	make/o/n=(0, 2) root:$(s.filename);initexpt(s)
	print s.filename
	variable i, dimx
	
	dimx=dimsize(wave0,0)
	variable j
	i=0
	
	do
		insertpoints i*dimx, dimx, s.data
		s.data[i*dimx, (i+1)*dimx-1][1]=-wave0[p-dimx*i][y-1]
		s.data[i*dimx, (i+1)*dimx-1][0]=wave0[p-dimx*i][y+1]
		i+=1	
		killwaves wave0//".txt0"nameend
		wname = s.filename+"_"+num2istr(i)+".txt0"

		wave wave0=$wname
	while(exists(nameofwave(wave0))>0)
			
	make/o/n=(21) root:analysis:statwaves:$("Stats"+s.filename); initexpt(s)
		
	s.points2D=i
	s.points1D=dimsize(s.data,0)/(s.points2D)
	
	s.statwave[0]=s.points1D
	s.statwave[1]=s.points2D
	
	loadstats(s)
	
	loadspectrum("", 0, s.filename)

End


Function LoadMr2()		//need macro to interface; function speeds things up

	STRUCT NMRdata expt; initexpt(expt)

	String pathName,fileName, pathstring, curfolder = GetDataFolder(1)
	variable filerefnum
	
	PauseUpdate; Silent 1
	SetDataFolder "Root:"
	
	open/d/r/t="????" filerefnum			//allows user to find file and puts name into global var 'S_fileName'; doesn't open file
	fileName = FileNameof(S_fileName)
	pathstring = PathNameof(S_fileName)	//this pathname is in text form; we must give it an igor symbolic name because	
	NewPath/O temporaryPath, pathstring	//that is how all other functions are run, i.e. with '$' sign preceeding pathname.
	pathName = "temporaryPath"		//*you must also do this--literal strings in a function call do not get passed
										//when using 'execute' (which will be used later in code).  what a pain.	
	expt.filename=removeending(filename,".mr2")
	
	readmagresfile(pathname, filename, expt)

	loadspectrum("", 0, expt.filename)
	
End



Function readmagresfile(pathname, filename, s)
	string pathname, filename
	STRUCT NMRdata &s
	
	make/o/n=(21) root:analysis:statwaves:$("Stats"+s.filename);initexpt(s)
	
	setdatafolder root:analysis:system:
	
	variable frefnum
	open/P=$pathname/r/t="BINA" frefnum as filename
	
	fsetpos frefnum, 0
	fbinread/b=2/f=3 frefnum, s.points2D
	s.statwave[1]=s.points2D

	fsetpos frefnum, 50
	fbinread/b=2/f=3 frefnum, s.points1D
	s.statwave[0]=s.points1D
	
	fsetpos frefnum, 154
	fbinread/b=2/f=5 frefnum, s.H0
	if(s.H0>0)
		s.statwave[5]=s.H0
	endif
	
	fsetpos frefnum, 162
	fbinread/b=2/f=5 frefnum, s.w0
	if(s.w0>0)	
		s.statwave[3]=s.w0
	endif
	
	fsetpos frefnum, 178
	fbinread/b=2/f=5 frefnum, s.samplerate
	s.samplerate*=10^6
	s.statwave[2]= s.samplerate
	
	GBLoadWAve/o/v/n=tempmr2_/T={2,4}/S=2048/W=2/U=(s.points1D*s.points2D)/P=$pathname filename
	
	make/o/n=(s.points1D*s.points2D,2) root:$s.filename;initexpt(s)
	s.data[][0]=s.tempmr2_0
	s.data[][1]=s.tempmr2_1[p]
	
	
	setdatafolder root:
end

Function DetectExpttype(s)
	STRUCT NMRData &s
	
	if(strsearch(s.filename, "T1", 0)>=0)
		s.experimenttype=0
		s.T1measure=1
		s.fieldsweep=0
		s.frequencysweep=0
	elseif(strsearch(s.filename, "HS",0)>=0)
		s.experimenttype=1
		s.fieldsweep=1
		s.T1measure=0
		s.frequencysweep=0
	elseif(strsearch(s.filename, "ws", 0)>=0)
		s.experimenttype=2
		s.frequencysweep=1
		s.T1measure=0
		s.fieldsweep=0
	elseif(strsearch(s.filename, "T2", 0)>=0)
		s.experimenttype=3
	elseif(strsearch(s.filename, "Nut",0)>=0)
		s.experimenttype=4
	elseif(strsearch(s.filename, "Rep",0)>=0)
		s.experimenttype=5
	endif
end