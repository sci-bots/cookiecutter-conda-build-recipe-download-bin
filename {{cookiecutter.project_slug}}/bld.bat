set PKG_URL={{cookiecutter.url}}
set FILENAME={{cookiecutter.url.split('/')[-1]}}
REM Download Windows binary.
"%PYTHON%" -m wget "%PKG_URL%"
if errorlevel 1 exit 1
mkdir "%PKG_NAME%"
REM Extract files from from {{cookiecutter.bin_format}} archive.
{% if cookiecutter.bin_format in ('tar.gz', 'tar.bz2', 'tar') %}
tar xvf %FILENAME% -C "%PKG_NAME%"
{% else %}{% if cookiecutter.bin_format in ('zip', '7zip', '7z') %}
"%PREFIX%"\Library\bin\7za x %FILENAME% -y -o "%PKG_NAME%"
{% endif %}
{% endif %}
if errorlevel 1 exit 1
REM Copy contents to ${PREFIX}\Library\bin
REM TODO xcopy /S /Y /I /Q %PKG_NAME% "%PREFIX%"\...
if errorlevel 1 exit 1
