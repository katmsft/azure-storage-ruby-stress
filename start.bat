@echo off
title "SCTE erver for Ruby Client Library"
echo 1/3/2018 2:00
echo Split Version
SET full_dir=%~dp0
%~dp0ruby_runtime\bin\ruby.exe -v
echo Running SCTE server
%~dp0ruby_runtime\bin\ruby.exe -I "%~dp0azure-storage-ruby\common\lib;%~dp0azure-storage-ruby\blob\lib;%~dp0azure-storage-ruby\table\lib;%~dp0azure-storage-ruby\queue\lib;%~dp0azure-storage-ruby\file\lib" %~dp0azure\storage\stress\scte_server.rb