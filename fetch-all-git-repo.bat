@echo off

set OUTPUT=%~dp0todo_list.txt

echo. > %OUTPUT%

set myDirs=code_generator ^
           code_generator_input ^
           code_generator_model ^
           code_generator_output ^
           common ^
           utils

set otherDirs=org.opentoken-6.0b ^
              org.stephe_leake.aunit_ext-3.3 ^
              org.stephe_leake.makerules-3.3 ^
              org.stephe_leake.sal-3.3 ^
              org.wisitoken-1.3.0


set directories=%myDirs% %otherDirs%

pushd ..

for %%d in (%directories%) do (
    if "%%d" NEQ "" (
        set flag=0
        call :gitStatus %%d
    )
)

popd

type %OUTPUT%

REM ===== gitStatus ====
:gitStatus
set directory=%~1
if "%directory%"=="" goto :EOF
if not exist "%directory%" (
   echo directory not found: "%directory%"
) else (
REM  echo.==========
  echo.Checking %directory%...
REM  echo.==========
  pushd %directory%

  echo repository %directory%: >> %OUTPUT%

  FOR /F "tokens=*" %%g IN ('git status --porcelain') do (
      echo. > flag.txt
      echo.  %%g >> %OUTPUT%
  )

  if exist flag.txt (
    del flag.txt
  ) else (
    echo.  UP TO DATE >> %OUTPUT%
  )

  echo. >> %OUTPUT%
  popd
)
goto :EOF
REM ===== gitStatus ====