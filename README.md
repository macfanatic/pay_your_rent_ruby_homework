# Improvements:
* I would use bundler and pull in active_support/core_ext/object/blank methods for #blank?
* I introduce a `config/boot.rb` file to manage requiring all files better, including modifying load path
* I would use rspec for unit testing the service classes
* I would use aruba (cucumber for CLI apps) for integration testing, if desired

## To Run
There is a sample data file included.

```shell
$> bin/script data/sample.txt
```
