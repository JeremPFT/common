@echo off

set directories=( ^
    org.opentoken-6.0b ^
    code_generator ^
    code_generator_input ^
    code_generator_model ^
    code_generator_output ^
    common ^
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

popd

REM ===== gitStatus ====
:gitStatus
set directory=%~1
if not exist "%directory%" (
   echo directory not found: "%directory%"
) else (
  echo.==========
  echo.Checking %directory%
  echo.==========
  pushd %directory%
  git status --short
  popd
)
goto :EOF
REM ===== gitStatus ====
