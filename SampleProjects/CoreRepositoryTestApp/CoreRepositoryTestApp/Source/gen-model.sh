modeld=Model.xcdatamodeld
modelversion=$(/usr/libexec/PlistBuddy -c 'print _XCCurrentVersionName' $modeld/.xccurrentversion)
model=$modeld/$modelversion
echo "Mo'Generating code for $model..."
mogenerator -m "$model" --machine-dir Generated --human-dir Human --template-var arc=true