@echo off
title "SCTE erver for Ruby Client Library"
SET full_dir=%~dp0
%~dp0ruby_runtime\bin\ruby.exe -v
echo Running SCTE server
%~dp0ruby_runtime\bin\ruby.exe -I "%~dp0azure-storage-ruby\lib" %~dp0azure\storage\stress\scte_server.rb