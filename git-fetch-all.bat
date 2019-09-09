@echo off

REM trying to print updated and todo projects at the end ... no luck yet, it's not bash :(

set toDate=()
set toDo=()

set directories=(org.opentoken-6.0b ^
    code_generator ^
    common ^
    code_generator_input ^
    code_generator_model ^
    code_generator_output ^
    utils_assertions ^
    utils_files_services ^
    utils_strings_services ^
    utils_templates ^
    )

pushd ..

for %%d in %directories% do (
    if "%%d" NEQ "" (
        call :gitStatus %%d
    )
)

rem echo.todo projects:
rem for %%t in (%toDo%) do ( echo %%t )
rem echo.DOOONE

popd

REM ===== gitStatus ====
:gitStatus
set directory=%~1
if "%directory%"=="" goto :EOF
if not exist "%directory%" (
   echo directory not found: "%directory%"
) else (
  echo.==========
  echo.Checking %directory%
  echo.==========
  pushd %directory%
  git status --porcelain
  FOR /F "tokens=*" %%g IN ('git status --porcelain') do (
      echo."%directory%\%%g" >> ..\todo_list.txt
  rem   set "toDo=%%toDo%%, %directory%"

  rem   rem SET VAR=%%g
  rem   rem echo %directory%
  rem   rem echo %VAR%
  rem   rem if "%%g"=="" (
  rem   rem    echo."up to date"
  rem   rem    echo.
  rem   rem    set "toDate=%%toDate%%, %%g"
  rem   rem    echo."%toDate%"
  rem   rem ) else (
  rem   rem echo %%g
  rem   rem )
  )
  popd
)
goto :EOF
REM ===== gitStatus ====
