SET INPUTFILENAME=%2
SET EXTENSION=jpg
SET INFIX=%1

IF "%INFIX%"=="guetzli" GOTO guetzli
IF "%INFIX%"=="jpeg-recompress" GOTO jpeg-recompress
IF "%INFIX%"=="jpegoptim" GOTO jpegoptim
IF "%INFIX%"=="mozjpeg" GOTO mozjpeg
IF "%INFIX%"=="libjpeg-turbo" GOTO libjpeg-turbo

echo Not found.
goto commonexit

:guetzli
break>%INPUTFILENAME%_%INFIX%.log
FOR /L %%G IN (84,3,93) DO (
	ptime ""%cd%\guetzli\guetzli" --quality %%G %INPUTFILENAME%.%EXTENSION% %INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%">>%INPUTFILENAME%_%INFIX%.log
	for %%I in (%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%) do @echo datatoken#%INPUTFILENAME%,%INFIX%,%%G,%%~zI>>%INPUTFILENAME%_%INFIX%.log
)
goto commonexit

:jpeg-recompress
break>%INPUTFILENAME%_%INFIX%.log
FOR /L %%G IN (84,3,93) DO (
	ptime ""%cd%\jpeg-archive\jpeg-recompress" -n %%G -x %%G %INPUTFILENAME%.%EXTENSION% %INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%">>%INPUTFILENAME%_%INFIX%.log
	for %%I in (%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%) do @echo datatoken#%INPUTFILENAME%,%INFIX%,%%G,%%~zI>>%INPUTFILENAME%_%INFIX%.log
)
goto commonexit

:jpegoptim
break>%INPUTFILENAME%_%INFIX%.log
FOR /L %%G IN (84,3,93) DO (
	ptime ""%cd%\jpegoptim\jpegoptim" -m %%G --stdout %INPUTFILENAME%.%EXTENSION%>%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%">>%INPUTFILENAME%_%INFIX%.log
	for %%I in (%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%) do @echo datatoken#%INPUTFILENAME%,%INFIX%,%%G,%%~zI>>%INPUTFILENAME%_%INFIX%.log
)
goto commonexit

:mozjpeg
break>%INPUTFILENAME%_%INFIX%.log
FOR /L %%G IN (84,3,93) DO (
	ptime ""%cd%\mozjpeg\cjpeg" -quality %%G -optimize %INPUTFILENAME%.%EXTENSION%>%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%">>%INPUTFILENAME%_%INFIX%.log
	for %%I in (%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%) do @echo datatoken#%INPUTFILENAME%,%INFIX%,%%G,%%~zI>>%INPUTFILENAME%_%INFIX%.log
)
goto commonexit

:libjpeg-turbo
magick convert -format ppm %INPUTFILENAME%.%EXTENSION% %INPUTFILENAME%.ppm
break>%INPUTFILENAME%_%INFIX%.log
FOR /L %%G IN (84,3,93) DO (
	ptime ""%cd%\libjpeg-turbo\cjpeg" -quality %%G -optimize -outfile %INPUTFILENAME%_%INFIX%_%%G.%EXTENSION% %INPUTFILENAME%.ppm">>%INPUTFILENAME%_%INFIX%.log
	for %%I in (%INPUTFILENAME%_%INFIX%_%%G.%EXTENSION%) do @echo datatoken#%INPUTFILENAME%,%INFIX%,%%G,%%~zI>>%INPUTFILENAME%_%INFIX%.log
)
goto commonexit

:commonexit
echo EXITING