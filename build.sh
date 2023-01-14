# Paths for JS
PRODPATHJS="/Assets/JS/"
DEVPATHJS="/Testing/Assets/JS/"

# Path for CSS
PRODPATHCSS="/Assets/CSS/"
DEVPATHCSS="/Testing/Assets/CSS/"

echo "==== Initializing Build Tools ===="
echo "What is the Name of the Project ?"
read PROJECT_NAME

#Replacing the Paths in Assets and Files According to the Environment
echo "Is it Dev Build or Prod Build ?"
echo "[1] Dev"
echo "[2] Prod"
read ENV


DATE="$(date +%d%m%Y)"

if [ "$ENV" = 1 ];
then
    echo "===== Searching for Production Paths to Replace =====*"
    ENV="Development"
    rm -r "IPRU-$PROJECT_NAME-ManualBuild-$DATE-V1"
    rm -r "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1-Testing"
    mkdir "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1-Testing"
    sed -i "s+$PRODPATHCSS+$DEVPATHCSS+g" "HTML/index.html"
    sed -i "s+$PRODPATHJS+$DEVPATHJS+g" "HTML/index.html"
    sed -i "s+$PRODPATHJS+$DEVPATHJS+g" "demo.txt"
    sed -i "s/production/testing/g" "demo.txt"
    cp "demo.txt" "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1-Testing"
    cp "HTML/index.html" "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1-Testing"
else 
    echo "===== Searching for Development Paths to Replace ====="
    ENV="Production"
    rm -r "IPRU-$PROJECT_NAME-ManualBuild-$DATE-V1-Testing"
    rm -r "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1"
    mkdir "IPRU-$PROJECT_NAME-ManualBuild-$DATE-V1"
    sed -i "s+$DEVPATHCSS+$PRODPATHCSS+g" "HTML/index.html"
    sed -i "s+$DEVPATHJS+$PRODPATHJS+g" "HTML/index.html"
    sed -i "s+$DEVPATHJS+$PRODPATHJS+g" "demo.txt"
    sed -i "s/testing/production/g" "demo.txt"
    cp "demo.txt" "IPRU-$PROJECT_NAME-ManualBuild-$DATE-V1"
    cp "HTML/index.html" "IPRU-$PROJECT_NAME-ManualBuild-$DATE-V1"
fi

echo "===== Path has been Changes for $ENV Environment ====="

#Minify the all the files and directories
echo "Want to Create Igonore File?"
echo "[1] Yes"
echo "[2] No"
read IGNORE

if [ "$IGNORE" = 1 ];
then
    echo "==== Creating Ignore File ====="
    rm -r ".ignore"
    touch ".ignore"
    echo >> "node_modules"
    vi ".ignore"
    echo "==== Ignore File Created ====="
else
    echo "==== Skipping Ignore Files ===="
fi


#
echo "Do you want to create Bundle for AEM or AWS ?"
echo "[1] AEM"
echo "[2] AWS"
read HOST

if [ "$HOST" = 1 ];
then
    HOST="AEM"
    mkdir "$HOST"
    mv "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1-Testing" "$HOST"
    mv ".ignore" "$HOST"
else
    HOST="AWS"
    mkdir "$HOST"
    mv "IPRU-$PROJECT_NAME--ManualBuild-$DATE-V1-Testing" "$HOST"
    mv ".ignore" "$HOST"
fi

echo "==== $PROJECT_NAME's $ENV Optimized build is Ready to Deploy on $HOST ===="