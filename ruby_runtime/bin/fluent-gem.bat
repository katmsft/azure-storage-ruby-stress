@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"E:\dev\src\ruby\ruby_thrift\ruby_runtime\bin\ruby.exe" "E:/dev/src/ruby/ruby_thrift/ruby_runtime/bin/fluent-gem" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"E:\dev\src\ruby\ruby_thrift\ruby_runtime\bin\ruby.exe" "%~dpn0" %*
