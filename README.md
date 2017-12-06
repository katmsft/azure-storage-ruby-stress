# SCTE server for Microsoft Azure Storage Client Library for Ruby

This project is to hold code to start SCTE server for Azure Storage Client Library for Ruby.

# Getting Started

## Dependencies.
All dependencies should be already included in the `./ruby_runtime` folder, except azure-storage-ruby. The code should be put in './azure-storage-ruby', or downloaded using the following command if Git is installed
```
git clone https://github.com/Azure/azure-storage-ruby.git
```

## Running server
Run start.bat in root folder.

# Maintenance

## Updating auto-generated code
The auto-generated code is in `./azure/storage/stress/auto_generated`. To update them when there is a change, use command `thrift -r --gen rb:namespaced --out ruby .\All.thrift` to generated the code, and put all generated files into `./azure/storage/stress/auto_generated` without any previous folder structure, and change all the `require` in the files to `require_relative` except `require "thrift"`.

Note that the namespace in IDL files for ruby should be `namespace rb Azure.Storage.Stress`

## Updating handler code
For a handler function called `dummy_function`, one should search for `dummy_function_args` and `dummy_function_results` to see what the function should be receiving and returning.
