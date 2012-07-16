modeld=Model.xcdatamodeld
modelversion=$(/usr/libexec/PlistBuddy -c 'print _XCCurrentVersionName' $modeld/.xccurrentversion)
model=$modeld/$modelversion
echo "Mo'Generating code for $model..."
mogenerator -m "$model" --machine-dir ModelGenerated --human-dir ModelHuman --template-var arc=true