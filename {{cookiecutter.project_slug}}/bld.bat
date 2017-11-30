set PKG_URL={{cookiecutter.url}}
set FILENAME={{cookiecutter.url.split('/')[-1]}}
REM Download Windows binary.
"%PYTHON%" -m wget "%PKG_URL%"
if errorlevel 1 exit 1
mkdir "%PKG_NAME%"
REM Extract files from from {{cookiecutter.bin_format}} archive.
{% if cookiecutter.bin_format.lower() in ('tar.gz', 'tar.bz2', 'tar') %}
tar xvf %FILENAME% -C "%PKG_NAME%"
{% else %}{% if cookiecutter.bin_format.lower() in ('zip', '7zip', '7z') %}
"%PREFIX%"/Library/bin/7za x %FILENAME% -y -o"%PKG_NAME%"
{% endif %}
{% endif %}
if errorlevel 1 exit 1

REM Copy full archive contents to Conda environment.
set INSTALL_PATH=%PREFIX%/library/opt/%PKG_NAME%
xcopy /S /Y /I /Q %PKG_NAME% %INSTALL_PATH%

REM Make link to main executable in `Scripts` directory.
set EXE_PATH=%CONDA_PREFIX%/library/opt/%PKG_NAME%/%PKG_NAME%.exe
set BAT_PATH=%PREFIX%/Scripts/%PKG_NAME%.bat
echo @echo off >> "%BAT_PATH%"
if errorlevel 1 exit 1
echo "%EXE_PATH%" %* >> "%BAT_PATH%"
if errorlevel 1 exit 1
