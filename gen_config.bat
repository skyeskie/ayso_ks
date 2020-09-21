setlocal
FOR /F "tokens=*" %%i in ('type .env') do SET %%i
flutter pub run environment_config:generate
endlocal
