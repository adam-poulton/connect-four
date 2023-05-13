# connect-four
A text-based implementation of Connect Four in Ruby

## Running Connect Four
Navigate to the project root directory and run the followiung command:
```
ruby lib/connect_four.rb
```


## Install Ruby (if required)
1. Make sure Ruby is installed on your system. You can check with the following command:
```
ruby --version
```


2. If required, install Ruby on your system. If you are on Linux (Ubuntu/Debian), you can use the apt package manager to install Ruby
with the following command:
```
sudo apt update
sudo apt install ruby-full
```

3. Check if the Ruby package manager, RubyGems, is installed:
```
gem --version
```

4. If required, install RubyGems on your system. If you are on Linux (Ubuntu/Debian), you can use the apt package manager to install RubyGems
with the following command:
```
sudo apt update
sudo apt install rubygems
```


## Testing
1. Make sure RSpec is installed in your Ruby environment. You can install it by running the following command:
```
gem install rspec
```
2. Once RSpec is installed, navigate to the root directory of the project in your terminal.
3. To run all the tests, use the following command:
```
rspec
```
RSpec will automatically discover and run all the test files with names ending in `_spec.rb` within the `spec` directory and its subdirectories.
If you want to run a specific test file, you can provide the file path as an argument. For example:
```
rpsec spec/board_spec.rb
```
